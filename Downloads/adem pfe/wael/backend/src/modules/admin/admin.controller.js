const adminService = require("./admin.service");

exports.getStats = async (req, res, next) => {
  try {
    const stats = await adminService.getDashboardStats();
    res.json(stats);
  } catch (error) {
    next(error);
  }
};

// User CRUD
exports.getUsers = async (req, res, next) => {
  try {
    const filters = req.query;
    const users = await adminService.manageUsers(filters);
    res.json(users);
  } catch (error) {
    next(error);
  }
};

exports.createUser = async (req, res, next) => {
  try {
    const userId = await adminService.createUser(req.body);
    res.status(201).json({ id: userId, message: "User created successfully" });
  } catch (error) {
    next(error);
  }
};

exports.updateUser = async (req, res, next) => {
  try {
    const updated = await adminService.updateUser(req.params.id, req.body);
    if (!updated) {
      return res.status(404).json({ message: "User not found" });
    }
    res.json({ message: "User updated successfully" });
  } catch (error) {
    next(error);
  }
};

exports.updateUserStatus = async (req, res, next) => {
  try {
    await adminService.updateUserStatus(req.params.id, req.body.is_verified);
    res.json({ message: "User status updated" });
  } catch (error) {
    next(error);
  }
};

exports.deleteUser = async (req, res, next) => {
  try {
    await adminService.deleteUser(req.params.id);
    res.json({ message: "User deleted" });
  } catch (error) {
    next(error);
  }
};

// Company CRUD
exports.getCompanies = async (req, res, next) => {
  try {
    const filters = req.query;
    const companies = await adminService.getAllCompanies(filters);
    res.json(companies);
  } catch (error) {
    next(error);
  }
};

exports.createCompany = async (req, res, next) => {
  try {
    const companyId = await adminService.createCompany(req.body);
    res.status(201).json({ id: companyId, message: "Company created successfully" });
  } catch (error) {
    next(error);
  }
};

exports.updateCompany = async (req, res, next) => {
  try {
    const updated = await adminService.updateCompany(req.params.id, req.body);
    if (!updated) {
      return res.status(404).json({ message: "Company not found" });
    }
    res.json({ message: "Company updated successfully" });
  } catch (error) {
    next(error);
  }
};

exports.deleteCompany = async (req, res, next) => {
  try {
    await adminService.deleteCompany(req.params.id);
    res.json({ message: "Company deleted" });
  } catch (error) {
    next(error);
  }
};

// Applications CRUD
exports.getApplications = async (req, res, next) => {
  try {
    const filters = req.query;
    const applications = await adminService.getAllApplications(filters);
    res.json(applications);
  } catch (error) {
    next(error);
  }
};

exports.updateApplicationStatus = async (req, res, next) => {
  try {
    await adminService.updateApplicationStatus(req.params.id, req.body.status);
    res.json({ message: "Application status updated" });
  } catch (error) {
    next(error);
  }
};

exports.deleteApplication = async (req, res, next) => {
  try {
    await adminService.deleteApplication(req.params.id);
    res.json({ message: "Application deleted" });
  } catch (error) {
    next(error);
  }
};

exports.getReports = async (req, res, next) => {
  try {
    const reports = await adminService.getReports();
    res.json(reports);
  } catch (error) {
    next(error);
  }
};