const router = require("express").Router();
const reimburseController = require("../controllers/reimburseController");
const authLogin = require("../middlewares/auth");
const { uploadMultipleImage } = require("../middlewares/base64");

router.post(
  "/add-reimburse",
  authLogin,
  uploadMultipleImage,
  reimburseController.addReimburse
);

router.post(
  "/get-user-reimburse",
  authLogin,
  reimburseController.getUserReimburse
);

router.post(
  "/get-detail-reimburse",
  authLogin,
  reimburseController.getDetailReimburse
);

router.post("/get-month-recap", authLogin, reimburseController.getMonthRecap);

router.post("/get-year-recap", authLogin, reimburseController.getYearRecap);

router.post(
  "/get-summary-reimburse",
  authLogin,
  reimburseController.getSummaryReimburse
);

router.post(
  "/get-list-purpose-option",
  authLogin,
  reimburseController.getListPurpose
);

router.post(
  "/get-list-detail-title-option",
  authLogin,
  reimburseController.getListDetailTitle
);

router.post(
  "/change-status-reimburse",
  authLogin,
  reimburseController.changeStatusReimburse
);

module.exports = router;
