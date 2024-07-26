const { isNil, isNotEmpty, isNotNil, forEach } = require("ramda");
const Reimburse = require("../models/Reimburse");
const ImageReimburse = require("../models/Reimburse-Image");
const ReimburseDetail = require("../models/Reimburse-Detail");
require("dotenv").config();

module.exports = {
  getUserReimburse: async (req, res) => {
    const { dateReimburse, status } = req.body;
    const user = req.userAuth;

    try {
      const whereParam = {
        user_id: user.id,
      };

      if (isNotNil(status)) {
        whereParam.status = status;
      }

      const reimburse = await Reimburse.findAll({
        where: whereParam,
      });

      const returnData = [];

      if (isNotNil(reimburse)) {
        var filteredData = reimburse;
        if (isNotNil(dateReimburse)) {
          const monthNames = [
            "Januari",
            "Februari",
            "Maret",
            "April",
            "Mei",
            "Juni",
            "Juli",
            "Agustus",
            "September",
            "Oktober",
            "November",
            "Desember",
          ];

          const formatDate = (dateString) => {
            const date = new Date(dateString);
            const month = monthNames[date.getUTCMonth()];
            const year = date.getUTCFullYear();
            return `${month} ${year}`;
          };

          const targetDateString = dateReimburse;

          filteredData = reimburse.filter(
            (item) => formatDate(item.createdAt) === targetDateString
          );
        }

        for (const item of filteredData) {
          const date = new Date(item.createdAt);
          const options = { year: "numeric", month: "long", day: "numeric" };
          const formattedDate = new Intl.DateTimeFormat(
            "id-ID",
            options
          ).format(date);

          const dataCard = {
            typeReimburse:
              item.role == 1
                ? "Reimbursement Kesehatan"
                : item.role == 2
                ? "Reimbursement Transportasi"
                : "",
            status:
              item.status == 1
                ? "Menunggu Diproses"
                : item.status == 2
                ? "Diproses"
                : item.status == 3
                ? "Diterima"
                : item.status == 4
                ? "Ditolak"
                : "",
            createdDate: formattedDate,
          };

          const reimburseDetail = await ReimburseDetail.findAll({
            where: {
              reimburse_id: item.id,
            },
          });

          var totalPrice = 0;
          if (isNotNil(reimburseDetail)) {
            reimburseDetail.forEach((detail) => {
              totalPrice += detail.price;
            });
          }

          dataCard.totalPrice = totalPrice;

          returnData.push(dataCard);
        }
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

  getDetailReimburse: async (req, res) => {
    const { reimburseId } = req.body;
    const user = req.userAuth;

    try {
      if (isNil(reimburseId)) {
        return res.json({
          success: false,
          msg: "missing value id",
        });
      }

      const reimburse = await Reimburse.findOne({
        where: {
          id: reimburseId,
        },
      });

      if (reimburse) {
        const returnData = {
          employeeName: user.fullname,
          status:
            reimburse.status == 1
              ? "Menunggu Diproses"
              : reimburse.status == 2
              ? "Diproses"
              : reimburse.status == 3
              ? "Diterima"
              : reimburse.status == 4
              ? "Ditolak"
              : "",
        };

        if (reimburse.role == 1) {
          returnData.diagnosiss = reimburse.diagnosiss;
        } else if (reimburse.rple == 2) {
          returnData.destination = reimburse.destination;
        }

        const reimburseImage = await ImageReimburse.findAll({
          where: {
            reimburse_id: reimburseId,
          },
        });

        const imageFinal = [];
        if (isNotNil(reimburseImage)) {
          for (const item of reimburseImage) {
            imageFinal.push({
              id: item.id,
              image: `${process.env.URL}${item.image}`,
            });
          }
        }

        returnData.ImageReimburse = imageFinal;

        const reimburseDetail = await ReimburseDetail.findAll({
          where: {
            reimburse_id: reimburseId,
          },
        });

        var totalPrice = 0;
        var filteredDetailReimburse = [];
        if (isNotNil(reimburseDetail)) {
          for (const detail of reimburseDetail) {
            totalPrice += detail.price;

            const date = new Date(detail.receipt_date);

            const day = date.getUTCDate().toString().padStart(2, "0");
            const month = (date.getUTCMonth() + 1).toString().padStart(2, "0"); // Months are 0-based
            const year = date.getUTCFullYear().toString().slice(-2);

            const formattedDate = `${day}/${month}/${year}`;

            const temp = {
              medicalDetail: detail.medical_detail,
              travelDetail: detail.travel_detail,
              intendedFor: detail.intended_for,
              price: detail.price,
              receipt_date: formattedDate,
              description: detail.description,
            };

            filteredDetailReimburse.push(temp);
          }
        }

        returnData.totalPrice = totalPrice;
        returnData.detailReimburse = filteredDetailReimburse;

        return res.json({
          success: true,
          msg: "success getting data",
          data: returnData,
        });
      }
    } catch (e) {
      return res.json({ msg: e.message });
    }
  },

  getDateReimburse: async (req, res) => {
    const user = req.userAuth;

    try {
      const reimburse = await Reimburse.findAll({
        where: {
          user_id: user.id,
        },
        order: [["createdAt", "asc"]],
      });

      var uniqueMonths = [];
      if (isNotNil(reimburse)) {
        const monthNames = [
          "Januari",
          "Februari",
          "Maret",
          "April",
          "Mei",
          "Juni",
          "Juli",
          "Agustus",
          "September",
          "Oktober",
          "November",
          "Desember",
        ];

        const formatDate = (dateString) => {
          const date = new Date(dateString);
          const month = monthNames[date.getUTCMonth()];
          const year = date.getUTCFullYear();
          return `${month} ${year}`;
        };

        uniqueMonths = Array.from(
          new Set(reimburse.map((item) => formatDate(item.createdAt)))
        );
      }

      return res.json({
        success: true,
        msg: "success getting data",
        data: uniqueMonths,
      });
    } catch (e) {
      return res.json({ msg: e.message });
    }
  },

  addReimburse: async (req, res) => {
    const { diagnosiss, destination, detail_reimburse, role } = req.body;
    const user = req.userAuth;

    try {
      if (isNil(diagnosiss) && isNil(destination)) {
        return res.json({
          success: false,
          msg: "diagnosiss or destination must be filled",
        });
      }

      const reimburse = await Reimburse.create({
        diagnosiss,
        destination,
        user_id: user.id,
        role: role,
      });

      if (reimburse) {
        if (isNotNil(req.fileName)) {
          for (let i = 0; i < req.fileName.length; i++) {
            const imageSave = await ImageReimburse.create({
              reimburse_id: reimburse.id,
              image: `images/${req.fileName[i]}`,
            });
          }
        }

        if (isNotNil(detail_reimburse) && isNotEmpty(detail_reimburse)) {
          detail_reimburse.forEach(async (item) => {
            const detailReimburse = await ReimburseDetail.create({
              medical_detail: isNil(item.medical_detail)
                ? null
                : item.medical_detail,
              travel_detail: isNil(item.travel_detail)
                ? null
                : item.travel_detail,
              intended_for: isNil(item.intended_for) ? null : item.intended_for,
              price: item.price,
              receipt_date: item.receipt_date,
              description: isNil(item.description) ? null : item.description,
              role: role,
              reimburse_id: reimburse.id,
            });
          });
        }

        return res.json({
          success: true,
          msg: "success create data",
          data: reimburse,
        });
      }

      return res.json({
        success: false,
        msg: "failed create data",
      });
    } catch (e) {
      return res.json({ msg: e.message });
    }
  },
};
