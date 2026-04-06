const express = require("express");
const router = express.Router();
const controller = require("./notification.controller");
const authMiddleware = require("../../middlewares/auth.middleware");

router.get("/", authMiddleware, controller.getUserNotifications);
router.post("/", controller.createNotification);
router.patch("/:id/read", authMiddleware, controller.markAsRead);

module.exports = router;