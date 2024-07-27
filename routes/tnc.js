const router = require("express").Router();
const tncController = require("../controllers/tncController");
const authLogin = require("../middlewares/auth");

router.post("/edit-tnc", authLogin, tncController.editTnc);
router.post("/get-tnc", authLogin, tncController.getTnc);

module.exports = router;
