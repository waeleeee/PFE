const db = require("../../config/db");

/**
 * Get all interviews for candidate (ONLINE only)
 */
exports.getCandidateInterviews = async (userId) => {
  const [rows] = await db.query(
    `
    SELECT 
      c.id_candidature AS id,
      o.titre AS jobTitle,
      co.nom AS company,
      c.entretien_date AS date,
      c.entretien_lieu AS meetingLink,
      c.statut AS status
    FROM candidature c
    JOIN offre o ON c.id_offre = o.id_offre
    JOIN company co ON o.id_entreprise = co.id_company
    WHERE c.id_user = ?
      AND c.entretien_date IS NOT NULL
    ORDER BY c.entretien_date DESC
    `,
    [userId]
  );

  return rows;
};

/**
 * Confirm interview
 */
exports.confirmInterview = async (id) => {
  await db.query(
    "UPDATE candidature SET statut = 'confirmed' WHERE id_candidature = ?",
    [id]
  );
};

/**
 * Cancel interview
 */
exports.cancelInterview = async (id) => {
  await db.query(
    "UPDATE candidature SET statut = 'cancelled' WHERE id_candidature = ?",
    [id]
  );
};

/**
 * Schedule ONLINE interview
 */
exports.scheduleInterview = async (id, date) => {
  // Generate ONLINE meeting link
  const meetingLink = `https://meet.yourapp.com/interview/${id}`;

  await db.query(
    `
    UPDATE candidature 
    SET entretien_date = ?, 
        entretien_lieu = ?, 
        statut = 'scheduled'
    WHERE id_candidature = ?
    `,
    [date, meetingLink, id]
  );
};