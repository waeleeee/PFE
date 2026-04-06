const express = require("express");
const router = express.Router();
const adminController = require("./admin.controller");
const authMiddleware = require("../../middlewares/auth.middleware");
const roleMiddleware = require("../../middlewares/role.middleware");

// All routes require ADMIN role
router.use(authMiddleware);
router.use(roleMiddleware("ADMIN"));

router.get("/statistics", adminController.getStats);
router.get("/reports", adminController.getReports);

// User CRUD
router.get("/users", adminController.getUsers);
router.post("/users", adminController.createUser);
router.put("/users/:id", adminController.updateUser);
router.patch("/users/:id/verify", adminController.updateUserStatus);
router.delete("/users/:id", adminController.deleteUser);

// Company CRUD
router.get("/companies", adminController.getCompanies);
router.post("/companies", adminController.createCompany);
router.put("/companies/:id", adminController.updateCompany);
router.delete("/companies/:id", adminController.deleteCompany);

// Applications CRUD
router.get("/applications", adminController.getApplications);
router.patch("/applications/:id/status", adminController.updateApplicationStatus);
router.delete("/applications/:id", adminController.deleteApplication);

module.exports = router;