const express = require("express");
const cors = require("cors");
const path = require("path");
const morgan = require("morgan");
require("dotenv").config();

const routes = require("./routes");
const errorMiddleware = require("./middlewares/error.middleware");

const app = express();

/* ========================
   CORS CONFIGURATION
======================== */

app.use(
  cors({
    origin: true, // allow all localhost dev ports (5173, 5174, 5175...)
    credentials: true,
  })
);

/* ========================
   GLOBAL MIDDLEWARES
======================== */

app.use(morgan("dev"));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

/* ========================
   STATIC FILES
======================== */

app.use("/uploads", express.static(path.join(process.cwd(), "uploads")));
console.log("Serving uploads from:", path.join(process.cwd(), "uploads"));
/* ========================
   API ROUTES
======================== */

app.use("/api", routes);

/* ========================
   ERROR HANDLING
======================== */

app.use(errorMiddleware);

module.exports = app;