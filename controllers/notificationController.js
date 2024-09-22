const { isNotNil } = require("ramda");
const Notification = require("../models/Notification");
require("dotenv").config();

module.exports = {
  getListNotification: async (req, res) => {
    const user = req.userAuth;

    try {
      const whereParam = {};

      if (user.role == 1) {
        whereParam.category = 2;
      } else {
        whereParam.category = 1;
      }

      whereParam.token_target = user.fcm_token;

      const notification = await Notification.findAll({
        where: whereParam,
        order: [['createdAt', 'DESC']],
      });

      const returnData = [];

      if (isNotNil(notification)) {
        notification.forEach((item) => {
          if (user.role == 1) {
            returnData.push({
              title: item.title,
              body: item.body,
              categoryNotification: item.category_notification,
              categoryReimbursement: item.category_reimbursement,
              date: item.date,
              reimburseId: item.reimburse_id,
            });
          } else {
            returnData.push({
              title: item.title,
              body: item.body,
              categoryNotification: item.category_notification,
              categoryReimbursement: item.category_reimbursement,
              date: item.date,
              reimburseId: item.reimburse_id,
              userId: item.user.id,
              userName: item.user,
              identityNumber: item.identity_number,
              price: item.price,
            });
          }
        });
      }

      return res.json({
        success: true,
        msg: "success getting data",
        data: returnData,
      });
    } catch (e) {
      return res.json({ msg: e.message });
    }
  },
};
