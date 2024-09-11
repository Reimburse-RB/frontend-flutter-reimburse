const router = require("express").Router();
const notificationController = require("../controllers/notificationController");
const authLogin = require("../middlewares/auth");

router.post(
  "/get-list-notification",
  authLogin,
  notificationController.getListNotification
);

module.exports = router;
