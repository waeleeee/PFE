const Application = require("./application.model");
const Job = require("../jobs/job.model");
const pool = require("../../config/db");
const fs = require("fs/promises");
const path = require("path");
const parseCvLocal = require("../ai/cv.parser");

const normalizeCompetences = (raw = "") => {
  // Turn section text into a compact comma-separated list.
  const text = String(raw || "")
    .replace(/\r/g, "\n")
    .split("\n")
    .map((l) => l.replace(/^[-•*]\s*/, "").trim())
    .filter(Boolean)
    .join(", ");

  // Basic de-dup + cleanup
  const parts = text
    .split(",")
    .map((p) => p.trim())
    .filter(Boolean)
    .map((p) => p.replace(/\s+/g, " "));

  const seen = new Set();
  const unique = [];
  for (const p of parts) {
    const key = p.toLowerCase();
    if (!seen.has(key)) {
      seen.add(key);
      unique.push(p);
    }
  }
  return unique.slice(0, 50).join(", ");
};

exports.applyToJob = async (userId, data) => {
  const job = await Job.findById(data.id_offre);
  if (!job) throw new Error("Offre non trouvée");
  if (job.statut !== 'OUVERT') throw new Error("Cette offre n'accepte plus de candidatures");

  return await Application.create({ ...data, id_user: userId });
};

exports.getMyApplications = async (userId) => {
  return await Application.findByUser(userId);
};

exports.getJobApplications = async (jobId, recruiterId) => {
  const job = await Job.findById(jobId);
  if (!job) throw new Error("Offre non trouvée");
  
  const companyId = await Job.getCompanyIdByUser(recruiterId);
  if (job.id_entreprise !== companyId) throw new Error("Accès non autorisé");

  return await Application.findByJob(jobId);
};

exports.getCompanyApplications = async (recruiterId) => {
  const companyId = await Job.getCompanyIdByUser(recruiterId);
  if (!companyId) throw new Error("Compte recruteur non configuré");

  const rows = await Application.findByCompany(companyId);

  // Enrich missing skills from CV (cached into user.competences).
  // Keep it safe: only process a small number per request.
  const MAX_PARSE_PER_REQUEST = 6;
  let parsed = 0;

  for (const r of rows) {
    if (parsed >= MAX_PARSE_PER_REQUEST) break;
    if (String(r.candidate_skills || "").trim()) continue;
    const cvFilename = String(r.candidate_cv_url || "").trim();
    if (!cvFilename) continue;

    // Only PDFs are supported by the local parser.
    if (!cvFilename.toLowerCase().endsWith(".pdf")) continue;

    try {
      const cvPath = path.resolve("uploads", "cvs", cvFilename);
      const buf = await fs.readFile(cvPath);
      const sections = await parseCvLocal(buf);
      const extracted = normalizeCompetences(sections?.competences || "");
      if (!extracted) continue;

      // Cache into user.competences only if empty, so we don't overwrite manual skills.
      await pool.execute(
        "UPDATE user SET competences = ? WHERE id_user = ? AND (competences IS NULL OR competences = '')",
        [extracted, r.id_user]
      );

      r.candidate_skills = extracted;
      parsed += 1;
    } catch (e) {
      // Ignore parse errors; analytics will fall back to other fields.
      continue;
    }
  }

  return rows;
};

exports.updateApplicationStatus = async (id, recruiterId, data) => {
  const application = await Application.findById(id);
  if (!application) throw new Error("Candidature non trouvée");
  if (application.recruiter_id !== recruiterId) throw new Error("Accès non autorisé");

  return await Application.updateStatus(id, data.statut, data);
};

exports.respondToOffer = async (id, candidateId, decision) => {
  const application = await Application.findById(id);
  if (!application) throw new Error("Candidature non trouvée");
  if (application.id_user !== candidateId) throw new Error("Accès non autorisé");
  if (application.statut?.toUpperCase() !== "ACCEPTED") throw new Error("Aucune offre active pour cette candidature");

  const normalizedInput = decision?.toUpperCase();
  if (!["ACCEPT", "REJECT"].includes(normalizedInput)) {
    throw new Error("Décision invalide");
  }
  const normalizedDecision = normalizedInput === "ACCEPT" ? "ACCEPTED" : "REJECTED";
  if (application.offer_status && application.offer_status !== "PENDING") {
    throw new Error("Cette offre a déjà reçu une réponse");
  }

  return await Application.respondToOffer(id, normalizedDecision);
};