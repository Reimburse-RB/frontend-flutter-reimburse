const router = require("express").Router();
const userController = require("../controllers/userController");
const authLogin = require("../middlewares/auth");
const { uploadImage } = require("../middlewares/base64");

const userRoutes = (messaging) => {
  router.post("/register", (req, res) => userController.userRegister(req, res, messaging));
  router.post("/login", userController.userLogin);
  router.post("/get-profile", authLogin, userController.getProfile);
  router.post("/edit-profile", authLogin, uploadImage, userController.editUser);
  router.post("/change-password", authLogin, userController.changePassword);
  router.post("/change-fcm-token", authLogin, userController.updateFcmToken);
  router.post(
    "/get-user-verification",
    authLogin,
    userController.getVerificationAccount
  );
  router.post(
    "/verification-account",
    authLogin,
    (req, res) => userController.verificationAccount(req, res, messaging)
  );
  router.post(
    "/get-detail-user-verification",
    authLogin,
    userController.getDetailVerificationUser
  );

  return router;
}


module.exports = userRoutes;
