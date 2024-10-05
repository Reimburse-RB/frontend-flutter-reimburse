const { isNotNil } = require("ramda");
const Notification = require("../models/Notification");
require("dotenv").config();
const { Op } = require("sequelize");
const { formatDateTime } = require("../utils/utils");

function decrypt(encrypted) {
  const aesKey = Buffer.from(process.env.AES_KEY, "hex"); // Konversi dari hex ke buffer
  const iv = Buffer.from(process.env.IV_KEY, "hex");

  const decipher = crypto.createDecipheriv("aes-256-cbc", aesKey, iv);

  let decrypted = decipher.update(encrypted, "hex", "utf8");
  decrypted += decipher.final("utf8");

  return decrypted;
}

module.exports = {
  getListNotification: async (req, res) => {
    const user = req.userAuth;

    try {
      const whereParam = {};

      if (user.role == 1) {
        whereParam.category = { [Op.in]: [2, 3] };
      } else {
        whereParam.category = { [Op.in]: [1, 3] };
      }

      whereParam.token_target = user.fcm_token;

      const notification = await Notification.findAll({
        where: whereParam,
        order: [["createdAt", "DESC"]],
      });

      const returnData = [];

      if (isNotNil(notification)) {
        notification.forEach((item) => {
          if (item.category == 3 && item.user_id != user.id) {
            return;
          }
          if (user.role == 1) {
            returnData.push({
              title: item.title,
              body: item.body,
              categoryNotification: item.category_notification,
              categoryReimbursement: item.category_reimbursement,
              date: formatDateTime(item.date, true, true),
              reimburseId: item.reimburse_id,
            });
          } else {
            const userIdentityNumber = decrypt(item.identity_number);
            const userFullname = decrypt(item.user);

            returnData.push({
              title: item.title,
              body: item.body,
              categoryNotification: item.category_notification,
              categoryReimbursement: item.category_reimbursement,
              date: formatDateTime(item.date, true, true),
              reimburseId: item.reimburse_id,
              userId: item.user_id,
              userName: userFullname,
              identityNumber: userIdentityNumber,
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
