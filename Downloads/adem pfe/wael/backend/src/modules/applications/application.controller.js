const applicationService = require("./application.service");

exports.apply = async (req, res, next) => {
  try {
    const data = { ...req.body };
    if (req.params.jobId) {
      data.id_offre = req.params.jobId;
    }
    if (req.files?.cv) {
      data.cv = req.files.cv[0].filename;
    }
    const applicationId = await applicationService.applyToJob(req.user.id, data);
    res.status(201).json({ id: applicationId, message: "Candidature envoyée" });
  } catch (error) {
    next(error);
  }
};

exports.getMyApplications = async (req, res, next) => {
  try {
    const apps = await applicationService.getMyApplications(req.user.id);
    res.json(apps);
  } catch (error) {
    next(error);
  }
};

exports.getCompanyApplications = async (req, res, next) => {
  try {
    const apps = await applicationService.getCompanyApplications(req.user.id);
    res.json(apps);
  } catch (error) {
    next(error);
  }
};

exports.getJobApplications = async (req, res, next) => {
  try {
    const apps = await applicationService.getJobApplications(req.params.jobId, req.user.id);
    res.json(apps);
  } catch (error) {
    next(error);
  }
};

exports.updateStatus = async (req, res, next) => {
  try {
    await applicationService.updateApplicationStatus(req.params.id, req.user.id, req.body);
    res.json({ message: "Statut mis à jour" });
  } catch (error) {
    next(error);
  }
};

exports.respondToOffer = async (req, res, next) => {
  try {
    await applicationService.respondToOffer(req.params.id, req.user.id, req.body?.decision);
    res.json({ message: "Réponse à l'offre enregistrée" });
  } catch (error) {
    next(error);
  }
};