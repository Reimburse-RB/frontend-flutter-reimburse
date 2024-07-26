const router = require("express").Router();
const userController = require("../controllers/userController");
const authLogin = require("../middlewares/auth");
const { uploadImage } = require("../middlewares/base64");

router.post("/register", userController.userRegister);
router.post("/login", userController.userLogin);
router.post("/edit-profile", authLogin, uploadImage, userController.editUser);

module.exports = router;
