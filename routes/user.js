const router = require("express").Router();
const userController = require("../controllers/userController");
const authLogin = require("../middlewares/auth");

router.post("/register", userController.userRegister);
router.post("/login", userController.userLogin);

module.exports = router;
