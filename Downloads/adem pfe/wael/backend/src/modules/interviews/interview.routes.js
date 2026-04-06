const express = require("express");
const router = express.Router();

const controller = require("./interview.controller");
const authMiddleware = require("../../middlewares/auth.middleware");

// All routes require authentication
router.get("/", authMiddleware, controller.getMyInterviews);
router.patch("/:id/confirm", authMiddleware, controller.confirm);
router.patch("/:id/cancel", authMiddleware, controller.cancel);
router.patch("/:id/schedule", authMiddleware, controller.schedule);

module.exports = router;