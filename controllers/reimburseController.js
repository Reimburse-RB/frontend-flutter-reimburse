const { isNil, isNotEmpty, isNotNil, update } = require("ramda");
const { Op } = require("sequelize");
const { formatDateTime, formatCurrency } = require('../utils/utils');
const moment = require('moment-timezone');
const Reimburse = require("../models/Reimburse");
const ImageReimburse = require("../models/Reimburse-Image");
const ReimburseDetail = require("../models/Reimburse-Detail");
const Notification = require("../models/Notification");
const UserFamily = require("../models/User-Family");
const User = require("../models/User");
const allStatus = require("../utils/allStatus");
require("dotenv").config();

module.exports = {
  getUserReimburse: async (req, res) => {
    const { dateReimburse, status, isAdmin, startDate, endDate, isSortByLatest = true } = req.body;
    const user = req.userAuth;

    try {
      const whereParam = {};

      if (!isNil(isAdmin)) {
        if (isAdmin == false) {
          whereParam.user_id = user.id;
        }
      }

      if (isNotNil(status)) {
        whereParam.status = {
          [Op.in]: status,
        };
      }

      if (isNotNil(startDate) && isNotNil(endDate)) {
        whereParam.createdAt = {
          [Op.between]: [startDate, endDate],
        };
      }

      const order = isSortByLatest ? [['createdAt', 'DESC']] : [['createdAt', 'ASC']];

      const reimburse = await Reimburse.findAll({
        where: whereParam,
        order: order,
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

          const cat = allStatus.listCategoryReimbursement.find(
            (itemCat) => itemCat.category_reimbursement_id === item.category
          );

          const dataCard = {
            id: item.id,
            typeReimburse: cat ? cat.category_reimbursement_text : "",
            statusId: item.status,
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
            createdDate: formatDateTime(item.createdAt, false, true),
            approval_by: null,
            approval_by_role: null,
            approval_date: null,
          };

          if (item.purpose_id !== null && item.purpose_id !== 1) {
            const purposeText = allStatus.purposeId.find(
              (itemCat) => itemCat.purpose_id === item.purpose_id
            );

            dataCard.purpose_id = item.purpose_id;
            dataCard.purpose_text = purposeText
              ? purposeText.purpose_text
              : null;
          } else {
            dataCard.purposeId = null;
            dataCard.purpose_text = item.purpose_other ?? purposeText;
          }

          if (!isNil(item.approval_date)) {
            dataCard.approval_date = formatDateTime(item.approval_date, true, false);

            const userApproval = await User.findOne({
              where: { id: item.approval_by },
            });

            dataCard.approval_by = userApproval.fullname;

            const roleUser = allStatus.role.find(
              (itemRole) => itemRole.role_id === userApproval.role
            );
            dataCard.approval_by_role = roleUser.role_text;
          }

          if (!isNil(isAdmin)) {
            if (isAdmin == true) {
              const userReimburse = await User.findOne({
                where: { id: item.user_id },
              });

              if (userReimburse) {
                dataCard.name = userReimburse.fullname;
                dataCard.nik = userReimburse.identity_number;
              }
            }
          }

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

  getCurrentStatusActive: async (req, res) => {
    const user = req.userAuth;

    try {
      if (user.role == 1) {
        return res.json({
          success: false,
          msg: "you're not using admin or hr account",
        });
      }

      const reimburse = await Reimburse.findAll({});

      const returnData = {
        totalDiproses: 0,
        totalKesehatanDiproses: 0,
        totalTrasnportDiproses: 0,
      };

      for (const item of reimburse) {
        if (item.category == 1 && item.status == 1) {
          returnData.totalKesehatanDiproses += 1;
          returnData.totalDiproses += 1;
        }

        if (item.category == 2 && item.status == 1) {
          returnData.totalKesehatanDiproses += 1;
          returnData.totalDiproses += 1;
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
        const userReimburse = await User.findOne({
          where: { id: reimburse.user_id },
        });

        const returnData = {
          name: userReimburse.fullname,
          email: userReimburse.email,
          nik: userReimburse.identity_number,
          status_id: reimburse.status,
          status_text:
            reimburse.status == 1
              ? "Menunggu Diproses"
              : reimburse.status == 2
                ? "Diproses"
                : reimburse.status == 3
                  ? "Diterima"
                  : reimburse.status == 4
                    ? "Ditolak"
                    : "",
          category_reimbursement_id: reimburse.category,
          date: formatDateTime(reimburse.createdAt, true, true),
          approval_by: null,
          approval_by_role: null,
          approval_date: null,
        };

        const cat = allStatus.listCategoryReimbursement.find(
          (itemCat) => itemCat.category_reimbursement_id === reimburse.category
        );

        if (reimburse.purpose_id !== null && reimburse.purpose_id !== 1) {
          const purposeText = allStatus.purposeId.find(
            (itemCat) => itemCat.purpose_id === reimburse.purpose_id
          );

          returnData.purpose_id = reimburse.purpose_id;
          returnData.purpose_text = purposeText
            ? purposeText.purpose_text
            : null;
        } else {
          returnData.purposeId = null;
          returnData.purpose_text = reimburse.purpose_other ?? reimburse.purposeText;
        }

        if (!isNil(reimburse.approval_date)) {
          returnData.approval_date = formatDateTime(reimburse.approval_date, true, false);

          const userApproval = await User.findOne({
            where: { id: reimburse.approval_by },
          });

          returnData.approval_by = userApproval.fullname;

          const roleUser = allStatus.role.find(
            (itemRole) => itemRole.role_id === userApproval.role
          );
          returnData.approval_by_role = roleUser.role_text;
        }

        returnData.category_reimbursement_text = cat
          ? cat.category_reimbursement_text
          : "";

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

        returnData.list_attachment = imageFinal;

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

            const family = await UserFamily.findOne({
              where: { id: detail.intended_for },
            });

            const detailTitleText =
              detail.id != 0
                ? allStatus.titleId.find(
                  (itemTitle) => itemTitle.detail_title_id === detail.title_id
                )
                : null;

            const temp = {
              detail_id: detail.id,
              detail_title_id: detailTitleText != null ? detail.title_id : null,
              detail_title_text:
                detailTitleText != null && detailTitleText.detail_title_id != 1
                  ? detailTitleText.detail_title_text
                  : detail.title_other ?? detailTitleText.detail_title_text,
              detail_family_id: detail.intended_for,
              detail_family_name: family ? family.fullname : "",
              detail_cost: detail.price,
              detail_date: formattedDate,
              detail_desc: detail.description,
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

  getMonthRecap: async (req, res) => {
    const user = req.userAuth;
    const { year, isAdmin } = req.body;
    try {
      const whereParam = {};

      if (!isNil(isAdmin)) {
        if (isAdmin == false) {
          whereParam.user_id = user.id;
        }
      }

      const reimburse = await Reimburse.findAll({
        where: whereParam,
        order: [["createdAt", "asc"]],
      });

      var uniqueMonths = [];
      var returnValue = [];
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

        if (isNil(year)) {
          returnValue = uniqueMonths;
        } else {
          for (const item of uniqueMonths) {
            if (item.includes(year)) {
              returnValue.push(item);
            }
          }
        }
      }

      return res.json({
        success: true,
        msg: "success getting data",
        data: returnValue,
      });
    } catch (e) {
      return res.json({ msg: e.message });
    }
  },

  getYearRecap: async (req, res) => {
    const { isAdmin } = req.body;
    const user = req.userAuth;

    try {
      const whereParam = {};

      if (!isNil(isAdmin)) {
        if (isAdmin == false) {
          whereParam.user_id = user.id;
        }
      }

      const reimburse = await Reimburse.findAll({
        where: whereParam,
        order: [["createdAt", "asc"]],
      });

      var uniqueMonths = [];
      if (isNotNil(reimburse)) {
        const formatDate = (dateString) => {
          const date = new Date(dateString);
          const year = date.getUTCFullYear();
          return `${year}`;
        };

        yearReturn = Array.from(
          new Set(reimburse.map((item) => formatDate(item.createdAt)))
        );
      }

      return res.json({
        success: true,
        msg: "success getting data",
        data: yearReturn,
      });
    } catch (e) {
      return res.json({ msg: e.message });
    }
  },

  addReimburse: async (req, res, messaging) => {
    const {
      category_reimbursement_id,
      purpose_id,
      detail_reimburse,
      purpose_other_text,
    } = req.body;
    const user = req.userAuth;


    try {
      if (user.status == 2) {
        return res.json({
          success: false,
          msg: "User not verified",
        });
      }

      if (isNil(purpose_id)) {
        return res.json({
          success: false,
          msg: "diagnosiss or destination must be filled",
        });
      }

      if (purpose_id == 1 && purpose_other_text == null) {
        return res.json({
          success: false,
          msg: "other diagnosiss or destination must be filled",
        });
      }

      const reimburse = await Reimburse.create({
        purpose_id: purpose_id,
        purpose_other: purpose_other_text,
        user_id: user.id,
        category: category_reimbursement_id,
      });

      if (reimburse) {
        // if (isNotNil(req.fileName)) {
        //   for (let i = 0; i < req.fileName.length; i++) {
        //     const imageSave = await ImageReimburse.create({
        //       reimburse_id: reimburse.id,
        //       image: `images/upload/${req.fileName[i]}`,
        //     });
        //   }
        // }

        var totalPrice = 0;
        if (isNotNil(detail_reimburse) && isNotEmpty(detail_reimburse)) {
          detail_reimburse.forEach(async (item) => {
            const [day, month, year] = item.detail_date.split("/");

            const date = new Date(`${year}-${month}-${day}`);
            const formattedDate = date
              .toISOString()
              .slice(0, 19)
              .replace("T", " ");

            totalPrice += item.detail_cost ? item.detail_cost : 0;
            const detailReimburse = await ReimburseDetail.create({
              title_id: item.detail_title_id,
              title_other: item.detail_title_other_text,
              intended_for: item.detail_family_id,
              price: item.detail_cost,
              receipt_date: formattedDate,
              description: isNil(item.description) ? null : item.description,
              reimburse_id: reimburse.id,
            });
          });
        }

        const cat = allStatus.listCategoryReimbursement.find(
          (itemCat) =>
            itemCat.category_reimbursement_id === category_reimbursement_id
        );
        const now = new Date();
        const day = now.getDate().toString().padStart(2, "0"); // Pastikan dua digit
        const month = (now.getMonth() + 1).toString().padStart(2, "0"); // Bulan dimulai dari 0
        const year = now.getFullYear();
        const formattedCreatedDate = `${year}-${month}-${day} ${now
          .toTimeString()
          .slice(0, 8)}`;

        const userAdmin = await User.findAll({
          where: {
            role: {
              [Op.in]: [2, 3],
            },
          },
        });

        userAdmin.forEach(async (item) => {
          const categoryNotification = 'reimburse';
          const titleMessageNotification = `Reimburse oleh User ${user.fullname} telah diajukan`;
          const bodyMessageNotification = `${user.fullname} telah mengajukan ${cat ? cat.category_reimbursement_text : ""} dengan total ${formatCurrency(totalPrice)}.`;

          const message = {
            notification: {
              title: titleMessageNotification,
              body: bodyMessageNotification,
            },
            data: {
              categoryNotification: `${categoryNotification}`,
              reimburseId: `${reimburse.id}`,
              categoryReimbursement: cat ? cat.category_reimbursement_text : "",
              user: `${user.fullname}`,
              identityNumber: `${user.identity_number}`,
              price: `${totalPrice}`,
              date: `${formattedCreatedDate}`,
            },
            token: item.fcm_token ?? "",
          };

          try {
            await messaging.send(message);
          } catch (error) {
            if (error.code === 'messaging/registration-token-not-registered') {
              console.warn(`Token tidak teregistrasi untuk user ${user.fullname}, token: ${fcmToken}`);
            } else {
              console.error('Error sending message:', error);
            }
          }

          await Notification.create({
            category_notification: categoryNotification,
            title: titleMessageNotification,
            body: bodyMessageNotification,
            reimburse_id: reimburse.id,
            category_reimbursement: cat ? cat.category_reimbursement_text : "",
            user_id: user.id,
            user: user.fullname,
            identity_number: user.identity_number,
            price: totalPrice,
            date: formattedCreatedDate,
            category: 1, // admin/hrd
            token_target: item.fcm_token ?? "",
          });
        });

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

  addImageReimburse: async (req, res) => {
    const { reimburse_id } = req.body;
    const user = req.userAuth;

    try {
      if (user.status == 2) {
        return res.json({
          success: false,
          msg: "User not verified",
        });
      }

      if (!reimburse_id) {
        return res.status(400).json({
          success: false,
          msg: 'reimburse_id is required',
        });
      }

      const reimburseIdInt = parseInt(reimburse_id, 10);

      // Pastikan ada file yang diunggah
      if (req.files && req.files.length > 0) {
        for (let i = 0; i < req.files.length; i++) {
          const imageSave = await ImageReimburse.create({
            reimburse_id: reimburseIdInt,
            image: `images/upload/${req.files[i].filename}`, // Sesuaikan dengan path penyimpanan gambar
          });
        }

        return res.status(200).json({
          success: true,
          msg: 'success create data',
          data: req.files.map(file => file.filename), // Mengembalikan nama file yang diunggah
        });
      } else {
        return res.status(400).json({
          success: false,
          msg: 'No files uploaded',
        });
      }
    } catch (e) {
      return res.json({ msg: e.message });
    }
  },

  changeStatusReimburse: async (req, res, messaging) => {
    const { id, change_status_id } = req.body;
    const user = req.userAuth;

    try {
      if (isNil(id)) {
        return res.json({
          success: false,
          msg: "please insert id of reimburse",
        });
      }

      if (isNil(change_status_id)) {
        return res.json({
          success: false,
          msg: "please insert status id of reimburse",
        });
      }

      const reimburse = await Reimburse.findOne({ where: { id: id } });

      if (reimburse) {
        reimburse.status = change_status_id;
        reimburse.approval_by = user.id;
        reimburse.approval_date = Date.now();
        reimburse.save();

        const userReimburse = await User.findOne({
          where: { id: reimburse.user_id },
        });

        const cat = allStatus.listCategoryReimbursement.find(
          (itemCat) => itemCat.category_reimbursement_id === reimburse.category
        );

        const now = new Date();
        const day = now.getDate().toString().padStart(2, "0"); // Pastikan dua digit
        const month = (now.getMonth() + 1).toString().padStart(2, "0"); // Bulan dimulai dari 0
        const year = now.getFullYear();
        const formattedCreatedDate = `${year}-${month}-${day} ${now
          .toTimeString()
          .slice(0, 8)}`;

        const categoryNotification = 'reimburse';
        const titleMessageNotification = change_status_id == 2
          ? "Pengajuan Diproses" :
          change_status_id == 3
            ? "Pengajuan Berhasil"
            : change_status_id == 4
              ? "Pengajuan Gagal!"
              : "";

        const bodyMessageNotification = `Pengajuan ${cat ? cat.category_reimbursement_text : ""} Anda ${change_status_id == 2 ? "sedang diproses" : change_status_id == 3 ? "berhasil" : change_status_id == 4 ? "gagal" : ""}.`;

        const message = {
          notification: {
            title: titleMessageNotification,
            body: bodyMessageNotification,
          },
          data: {
            categoryNotification: `${categoryNotification}`,
            reimburseId: `${reimburse.id}`,
            categoryReimbursement: `${cat ? cat.category_reimbursement_text : ""}`,
            date: `${formattedCreatedDate}`,
          },
          token: userReimburse.fcm_token ?? "",
        };

        try {
          await messaging.send(message);
        } catch (error) {
          if (error.code === 'messaging/registration-token-not-registered') {
            console.warn(`Token tidak teregistrasi untuk user ${user.fullname}, token: ${fcmToken}`);
          } else {
            console.error('Error sending message:', error);
          }
        }

        await Notification.create({
          category_notification: categoryNotification,
          title: titleMessageNotification,
          body: bodyMessageNotification,
          reimburse_id: reimburse.id,
          category_reimbursement: cat ? cat.category_reimbursement_text : "",
          date: formattedCreatedDate,
          category: 2, //karyawan
          token_target: userReimburse.fcm_token ?? "",
        });

        return res.json({
          success: true,
          msg: "success edit data",
          data: reimburse,
        });
      }

      return res.json({
        success: false,
        msg: "failed edit data",
      });
    } catch (e) {
      return res.json({ msg: e.message });
    }
  },

  getSummaryReimburse: async (req, res) => {
    const user = req.userAuth;

    try {
      const reimburse = await Reimburse.findAll({
        where: { user_id: user.id },
      });

      const returnData = {
        onproceed: 0,
        accepted: 0,
        rejected: 0,
        total_reimburse_this_year: 0,
      };

      for (const item of reimburse) {
        if (item.status == 1 || item.status == 2) {
          returnData.onproceed += 1;
        } else if (item.status == 3) {
          returnData.accepted += 1;
        } else if (item.status == 4) {
          returnData.rejected += 1;
        }

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
        returnData.total_reimburse_this_year += totalPrice;
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

  getListPurpose: async (req, res) => {
    const { category_reimbursement_id } = req.body;
    const user = req.userAuth;

    try {
      let allPurpose;

      if (category_reimbursement_id === 1) {
        allPurpose = [...allStatus.purposeId.slice(1, 10), allStatus.purposeId[0]];
      } else if (category_reimbursement_id === 2) {
        allPurpose = [...allStatus.purposeId.slice(10, 20), allStatus.purposeId[0]];

      } else {
        return res.json({
          success: false,
          msg: "Invalid category_reimbursement_id",
        });
      }

      return res.json({
        success: true,
        msg: "success getting data",
        data: allPurpose,
      });
    } catch (e) {
      return res.json({ msg: e.message });
    }
  },

  getListDetailTitle: async (req, res) => {
    const { category_reimbursement_id } = req.body;
    const user = req.userAuth;

    try {
      let allTitle;

      if (category_reimbursement_id === 1) {
        allTitle = [...allStatus.titleId.slice(1, 10), allStatus.titleId[0]];
      } else if (category_reimbursement_id === 2) {
        allTitle = [...allStatus.titleId.slice(10, 20), allStatus.titleId[0]];
      } else {
        return res.json({
          success: false,
          msg: "Invalid category_reimbursement_id",
        });
      }

      return res.json({
        success: true,
        msg: "success getting data",
        data: allTitle,
      });
    } catch (e) {
      return res.json({ msg: e.message });
    }
  },

};
