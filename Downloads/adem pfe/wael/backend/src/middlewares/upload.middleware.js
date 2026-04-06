const multer = require("multer");
const path = require("path");
const fs = require("fs");

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    let folder = "uploads/";

    if (file.fieldname === "cv") folder += "cvs/";
    else if (file.fieldname === "logo") folder += "logos/";
    else if (file.fieldname === "avatar") folder += "images/";
    else if (file.fieldname === "portfolio") folder += "portfolios/";
    else if (file.fieldname === "certifications") folder += "certifications/";

    try {
      const absoluteFolder = path.resolve(folder);
      fs.mkdirSync(absoluteFolder, { recursive: true });
      cb(null, absoluteFolder);
    } catch (err) {
      cb(err);
    }
  },
  filename: (req, file, cb) => {
    const name = file.originalname.replace(/\s+/g, "_");
    cb(null, `${Date.now()}-${name}`);
  },
});

const fileFilter = (req, file, cb) => {
  const allowedTypes = [
    "application/pdf",
    "application/msword",
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
    "image/jpeg",
    "image/png",
    "image/jpg"
  ];

  if (allowedTypes.includes(file.mimetype)) {
    cb(null, true);
  } else {
    cb(new Error("Type de fichier non supporté (PDF, DOC, JPG, PNG uniquement)"), false);
  }
};

const upload = multer({
  storage,
  fileFilter,
  limits: {
    fileSize: 5 * 1024 * 1024
  }
});

module.exports = upload;