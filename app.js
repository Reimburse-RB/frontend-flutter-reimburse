var createError = require("http-errors");
var express = require("express");
var path = require("path");
var cookieParser = require("cookie-parser");
var logger = require("morgan");
var cors = require("cors");
const helmet = require("helmet");
const sequelize = require("./config/database");
const bodyParser = require("body-parser");
require("dotenv").config();

var indexRouter = require("./routes/index");
var usersRouter = require("./routes/users");

const userRouter = require("./routes/user");
const reimburseRouter = require("./routes/reimburse");
const tncRouter = require("./routes/tnc");
const admin = require("firebase-admin");
const serviceAccount = require(process.env.PATH_FIREBASE_KEY);

var app = express();
app.use(cors());
app.use(helmet());

// view engine setup
app.set("views", path.join(__dirname, "views"));
app.set("view engine", "ejs");

app.use(logger("dev"));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, "public")));
app.use(bodyParser.json({ limit: "50mb" }));

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const messaging = admin.messaging();

app.use("/", indexRouter);
app.use("/users", usersRouter);
app.use("/user", userRouter);
app.use("/reimburse", reimburseRouter(messaging));
app.use("/tnc", tncRouter);

// catch 404 and forward to error handler
app.use(function (req, res, next) {
  next(createError(404));
});

sequelize
  .sync()
  .then(() => {
    console.log("Database & tables created!");
  })
  .catch((err) => {
    console.error("Unable to connect to the database:", err);
  });

// error handler
app.use(function (err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get("env") === "development" ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render("error");
});

module.exports = app;
