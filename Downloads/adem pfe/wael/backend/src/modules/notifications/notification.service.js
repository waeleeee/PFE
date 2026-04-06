const notificationModel = require("./notification.model");

exports.getUserNotifications = async (id_user) => {
  const [rows] = await notificationModel.getByUser(id_user);
  return rows;
};

exports.createNotification = async (type, id_user) => {
  await notificationModel.create({
    type,
    id_user,
  });
};

exports.markAsRead = async (id_notif) => {
  await notificationModel.markAsRead(id_notif);
};