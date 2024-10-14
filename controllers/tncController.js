const { isNil, isNotEmpty, isNotNil, forEach } = require("ramda");
const allStatus = require("../utils/allStatus");
const TermsCondition = require("../models/Terms-Condition");
require("dotenv").config();

module.exports = {
  editTnc: async (req, res) => {
    const { list_category_tnc } = req.body;
    const user = req.userAuth;

    try {
      for (const itemList of list_category_tnc) {
        const tnc = await TermsCondition.findAll({
          where: { category: itemList.category_reimbursement_id },
        });
        for (const item of tnc) {
          const idExists = itemList.list_tnc.some(
            (itemTnc) => itemTnc.id === item.id
          );

          if (!idExists) {
            item.destroy();
          }
        }

        const arrayTncCreate = [];
        for (const item of itemList.list_tnc) {
          const idExists = tnc.some((itemSome) => itemSome.id === item.id);

          if (idExists) {
            const tncEdit = await TermsCondition.findOne({
              where: { id: item.id },
            });
            tncEdit.tnc = item.tnc;
            tncEdit.save();
          } else {
            arrayTncCreate.push({
              category: itemList.category_reimbursement_id,
              tnc: item.tnc,
            });
          }
        }

        const createTnc = await TermsCondition.bulkCreate(arrayTncCreate);
      }

      return res.json({
        success: true,
        msg: "Berhasil memperbarui Syarat dan Ketentuan",
      });
    } catch (e) {
      console.error(`error: ${e.message}`);
      return res.json({ success: false, msg: "Terjadi Kesalahan!" });
    }
  },

  getTnc: async (req, res) => {
    const user = req.userAuth;

    try {
      const tncCat1 = await TermsCondition.findAll({
        order: [["id", "ASC"]],
        where: { category: 1 },
      });
      const tncCat2 = await TermsCondition.findAll({
        order: [["id", "ASC"]],
        where: { category: 2 },
      });

      const cat1 = allStatus.tnc.find((itemCat) => itemCat.tnc_id === 1);
      const cat2 = allStatus.tnc.find((itemCat) => itemCat.tnc_id === 2);

      const returnData = [
        {
          category_reimbursement_id: 1,
          title: cat1 ? cat1.tnc_text : "",
          list_tnc: [],
        },
        {
          category_reimbursement_id: 2,
          title: cat2 ? cat2.tnc_text : "",
          list_tnc: [],
        },
      ];

      for (const item of tncCat1) {
        returnData[0].list_tnc.push({
          id: item.id,
          tnc: item.tnc,
        });
      }

      for (const item of tncCat2) {
        returnData[1].list_tnc.push({
          id: item.id,
          tnc: item.tnc,
        });
      }

      return res.json({
        success: true,
        msg: "Berhasil mendapatkan sata",
        data: returnData,
      });
    } catch (e) {
      console.error(`error: ${e.message}`);
      return res.json({ success: false, msg: "Terjadi Kesalahan!" });
    }
  },
};
