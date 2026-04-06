const db = require("../../config/db");

exports.getByUser = (id_user) => {
  return db.query("SELECT * FROM notification WHERE id_user = ?", [id_user]);
};

exports.create = (data) => {
  return db.query(
    "INSERT INTO notification (type, date, id_user) VALUES (?, NOW(), ?)",
    [data.type, data.id_user]
  );
};

exports.markAsRead = (id_notif) => {
  return db.query("UPDATE notification SET lu = 1 WHERE id_notif = ?", [id_notif]);
};