const notificationService = require("./notification.service");

exports.getUserNotifications = async (req, res) => {
  try {
    const id_user = req.user.id;
    const notifications = await notificationService.getUserNotifications(id_user);
    res.json(notifications);
  } catch (error) {
    res.status(500).json({ message: "Server error" });
  }
};

exports.createNotification = async (req, res) => {
  try {
    const { type, id_user } = req.body;
    await notificationService.createNotification(type, id_user);
    res.json({ message: "Notification created" });
  } catch (error) {
    res.status(500).json({ message: "Server error" });
  }
};

exports.markAsRead = async (req, res) => {
  try {
    const { id } = req.params;
    await notificationService.markAsRead(id);
    res.json({ message: "Marked as read" });
  } catch (error) {
    res.status(500).json({ message: "Server error" });
  }
};