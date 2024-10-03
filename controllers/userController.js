const express = require("express");
const User = require("../models/User");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const { where } = require("sequelize");
const path = require("path");
const { isNil, isNotNil } = require("ramda");
const UserFamily = require("../models/User-Family");
const allStatus = require("../utils/allStatus");
require("dotenv").config();
const fs = require("fs");
const crypto = require("crypto");
const { title } = require("process");
const { Op } = require("sequelize");
const Notification = require("../models/Notification");

module.exports = {
  userRegister: async (req, res, messaging) => {
    const { name, identity_number, role, email, password, fcm_token } =
      req.body;

    try {
      const checkEmail = await User.findOne({
        attributes: ["email"],
        where: {
          email: email,
        },
      });

      if (checkEmail) {
        return res.json({
          success: false,
          msg: "Email sudah digunakan!!",
        });
      }

      // AES Encryption
      const aesKey = Buffer.from(process.env.AES_KEY, "hex"); // Konversi dari hex ke buffer
      const iv = Buffer.from(process.env.IV_KEY, "hex");

      const cipher = crypto.createCipheriv("aes-256-cbc", aesKey, iv);
      let encryptedPassword = cipher.update(password, "utf8", "hex");
      encryptedPassword += cipher.final("hex");

      // const decipher = crypto.createDecipheriv("aes-256-cbc", aesKey, iv);
      // let decryptedPassword = decipher.update(encryptedPassword, "hex", "utf8");
      // decryptedPassword += decipher.final("utf8");

      const salt = await bcrypt.genSalt(10);
      const hashPassword = await bcrypt.hash(encryptedPassword, salt);

      const token = jwt.sign({ email: email }, process.env.SECRET_KEY);

      const user = await User.create({
        fullname: name,
        email,
        password: hashPassword,
        identity_number,
        status: 2,
        role,
        token,
        fcm_token,
      });

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
        const categoryNotification = 'account_verification';
        const titleMessageNotification = `Pengguna Baru ${user.fullname} Menunggu Verifikasi`;
        const bodyMessageNotification = `Pengguna ${user.fullname} dengan Nomor Induk Karyawan ${user.identity_number} telah mendaftar dan membutuhkan verifikasi.`;

        const message = {
          notification: {
            title: titleMessageNotification,
            body: bodyMessageNotification,
          },
          data: {
            categoryNotification: `${categoryNotification}`,
            userId: `${user.id}`,
            date: `${formattedCreatedDate}`,
          },
          token: item.fcm_token ?? '',
        };

        try {
          await messaging.send(message);
        } catch (error) {
          console.error('Error sending message:', error);
        }

        await Notification.create({
          category_notification: categoryNotification,
          title: titleMessageNotification,
          body: bodyMessageNotification,
          user_id: user.id,
          category: 1, //admin/hrd
          token_target: item.fcm_token ?? '',
          date: formattedCreatedDate,
        });
      });

      return res.json({
        success: true,
        msg: "success create data",
        data: user,
      });
    } catch (e) {
      return res.json({ msg: e.message });
    }
  },

  userLogin: async (req, res) => {
    const { email, password, fcm_token } = req.body;
    try {
      const user = await User.findOne({ where: { email: email } });

      if (user) {
        // AES Encryption
        const aesKey = Buffer.from(process.env.AES_KEY, "hex"); // Konversi dari hex ke buffer
        const iv = Buffer.from(process.env.IV_KEY, "hex");

        const cipher = crypto.createCipheriv("aes-256-cbc", aesKey, iv);
        let encryptedPassword = cipher.update(password, "utf8", "hex");
        encryptedPassword += cipher.final("hex");

        const validpass = await bcrypt.compare(
          encryptedPassword,
          user.password
        );
        if (!validpass) {
          return res.json({
            success: false,
            msg: "Password Anda Salah!!",
          });
        }

        if (isNotNil(fcm_token)) {
          await Notification.update(
            { token_target: fcm_token },
            { where: { token_target: user.fcm_token } }
          );
          user.fcm_token = fcm_token;
          user.save();
        }

        return res.json({
          success: true,
          msg: "Anda Berhasil Login!!",
          token: user.token,
          user: user,
        });
      }

      return res.json({
        success: false,
        msg: "Anda Belum Terdaftar!!",
      });
    } catch (error) {
      return res.json({ msg: error.message });
    }
  },

  changePassword: async (req, res) => {
    const user = req.userAuth;
    const { oldPassword, newPassword } = req.body;
    try {
      if (isNil(oldPassword) || isNil(newPassword)) {
        return res.json({
          success: false,
          msg: "All fields are required!!",
        });
      }

      // AES Encryption
      const aesKey = Buffer.from(process.env.AES_KEY, "hex"); // Konversi dari hex ke buffer
      const iv = Buffer.from(process.env.IV_KEY, "hex");

      const cipher = crypto.createCipheriv("aes-256-cbc", aesKey, iv);
      let encryptedPassword = cipher.update(oldPassword, "utf8", "hex");
      encryptedPassword += cipher.final("hex");

      const isPasswordValid = await bcrypt.compare(
        encryptedPassword,
        user.password
      );
      if (!isPasswordValid) {
        return res.json({
          success: false,
          msg: "Old Password not match!!",
        });
      }

      if (newPassword === oldPassword) {
        return res.json({
          success: false,
          msg: "New password cannot be the same as old password!",
        });
      }

      const cipherNew = crypto.createCipheriv("aes-256-cbc", aesKey, iv);
      let encryptedPasswordNew = cipherNew.update(newPassword, "utf8", "hex");
      encryptedPasswordNew += cipherNew.final("hex");

      const salt = await bcrypt.genSalt(10);
      const hashPassword = await bcrypt.hash(encryptedPasswordNew, salt);

      user.password = hashPassword;
      user.save();

      return res.json({
        success: true,
        msg: "Anda Berhasil Mengubah Password",
      });
    } catch (error) {
      return res.json({ msg: error.message });
    }
  },

  updateFcmToken: async (req, res) => {
    const user = req.userAuth;
    const { fcmToken } = req.body;
    try {
      if (isNil(fcmToken)) {
        return res.json({
          success: false,
          msg: "All fields are required!!",
        });
      }

      await Notification.update(
        { token_target: fcmToken },
        { where: { token_target: user.fcm_token } }
      );

      user.fcm_token = fcmToken;
      user.save();

      return res.json({
        success: true,
        msg: "Anda Berhasil Mengubah FCM Token",
      });
    } catch (error) {
      return res.json({ msg: error.message });
    }
  },

  getVerificationAccount: async (req, res) => {
    const user = req.userAuth;

    try {
      if (user.role != 2 && user.role != 3) {
        return res.json({
          success: false,
          msg: "you're not using admin account",
        });
      }

      const allUser = await User.findAll({
        where: {
          status: 2,
        },
      });

      const returnData = [];
      for (const item of allUser) {
        returnData.push({
          id: item.id,
          nik: item.identity_number,
          name: item.fullname,
          img_url:
            item.image_url != null
              ? `${process.env.URL}${item.image_url}`
              : null,
        });
      }

      return res.json({
        success: true,
        msg: "Success getting data user verification!",
        data: returnData,
      });
    } catch (error) {
      return res.json({ msg: error.message });
    }
  },

  verificationAccount: async (req, res, messaging) => {
    const { userId } = req.body;
    const user = req.userAuth;

    try {
      if (isNil(userId)) {
        return res.json({
          success: false,
          msg: "Input user id",
        });
      }

      if (user.role != 2 && user.role != 3) {
        return res.json({
          success: false,
          msg: "you're not using admin account",
        });
      }

      const userDetail = await User.findOne({
        where: {
          id: userId,
        },
      });

      if (userDetail) {
        userDetail.status = 1;
        userDetail.save();

        const now = new Date();
        const day = now.getDate().toString().padStart(2, "0"); // Pastikan dua digit
        const month = (now.getMonth() + 1).toString().padStart(2, "0"); // Bulan dimulai dari 0
        const year = now.getFullYear();
        const formattedCreatedDate = `${year}-${month}-${day} ${now
          .toTimeString()
          .slice(0, 8)}`;

        const categoryNotification = 'verified_account';
        const titleMessageNotification = "Akun Anda Telah Diverifikasi";
        const bodyMessageNotification = `Akun Anda telah diverifikasi oleh Admin. Kini Anda dapat mulai menggunakan seluruh fitur yang tersedia di aplikasi.`;

        const message = {
          notification: {
            title: titleMessageNotification,
            body: bodyMessageNotification,
          },
          data: {
            categoryNotification: `${categoryNotification}`,
            date: `${formattedCreatedDate}`,
          },
          token: userDetail.fcm_token ?? '',
        };

        try {
          await messaging.send(message);
        } catch (error) {
          console.error('Error sending message:', error);
        }

        await Notification.create({
          category_notification: categoryNotification,
          title: titleMessageNotification,
          body: bodyMessageNotification,
          date: formattedCreatedDate,
          user: userDetail.fullname,
          user_id: userDetail.id,
          identity_number: userDetail.identity_number,
          category: 3, //general
          token_target: userDetail.fcm_token ?? '',
        });

        return res.json({
          success: true,
          msg: "success verification user",
          data: userDetail,
        });
      }

      return res.json({
        success: false,
        msg: "failed verification user",
      });
    } catch (error) {
      return res.json({ msg: error.message });
    }
  },

  getProfile: async (req, res) => {
    const user = req.userAuth;
    try {
      const roleUser = allStatus.role.find(
        (itemRole) => itemRole.role_id === user.role
      );

      const returnData = {
        nik: user.identity_number,
        name: user.fullname,
        email: user.email,
        role_id: user.role,
        role_text: roleUser ? roleUser.role_text : "",
        is_account_verified: user.status == 1 ? true : false,
        fcm_token: user.fcm_token,
        img_url:
          user.image_url != null ? `${process.env.URL}${user.image_url}` : null,
      };

      const userFamily = await UserFamily.findAll({
        where: { user_id: user.id },
      });
      const detailFamily = [];
      if (userFamily.length > 0) {
        for (const item of userFamily) {
          const familyStatus = allStatus.familyOption.find(
            (itemFamStat) => itemFamStat.family_status_id === item.status
          );

          detailFamily.push({
            id: item.id,
            family_status_id: item.status,
            family_status_text: familyStatus
              ? familyStatus.family_status_text
              : "",
            name: item.fullname,
          });
        }
      }

      returnData.family_member_data = detailFamily;

      return res.json({
        success: true,
        msg: "Success getting data profile!",
        data: returnData,
      });
    } catch (error) {
      return res.json({ msg: error.message });
    }
  },

  getDetailVerificationUser: async (req, res) => {
    const { userId } = req.body;
    const user = req.userAuth;
    try {
      if (isNil(userId)) {
        return res.json({
          success: false,
          msg: "Input user id",
        });
      }

      if (user.role != 2 && user.role != 3) {
        return res.json({
          success: false,
          msg: "you're not using admin account",
        });
      }

      const detailUser = await User.findOne({
        where: {
          id: userId,
        },
      });

      var returnData = {};

      if (detailUser) {
        const roleUser = allStatus.role.find(
          (itemRole) => itemRole.role_id === detailUser.role
        );

        returnData = {
          nik: detailUser.identity_number,
          name: detailUser.fullname,
          email: detailUser.email,
          role_id: detailUser.role,
          role_text: roleUser ? roleUser.role_text : "",
          is_account_verified: detailUser.status == 1,
          img_url:
            detailUser.image_url != null
              ? `${process.env.URL}${detailUser.image_url}`
              : null,
        };

        const userFamily = await UserFamily.findAll({
          where: { user_id: userId },
        });
        const detailFamily = [];
        if (userFamily.length > 0) {
          for (const item of userFamily) {
            const familyStatus = allStatus.familyOption.find(
              (itemFamStat) => itemFamStat.family_status_id === item.status
            );

            detailFamily.push({
              id: item.id,
              family_status_id: item.status,
              family_status_text: familyStatus
                ? familyStatus.family_status_text
                : "",
              name: item.fullname,
            });
          }
        }

        returnData.family_member_data = detailFamily;

        return res.json({
          success: true,
          msg: "success getting detail user verification",
          data: returnData,
        });
      }

      return res.json({
        success: false,
        msg: "failed getting detail user verification",
      });
    } catch (error) {
      return res.json({ msg: error.message });
    }
  },

  editUser: async (req, res) => {
    try {
      const { email, name, identity_number, family_member_data } = req.body;
      const user = req.userAuth;

      // if (req.fileName !== undefined) {
      //   if (
      //     user.image_url == undefined ||
      //     user.image_url == null ||
      //     user.image_url == ""
      //   ) {
      //     user.image_url = `images/upload/${req.fileName}`;
      //   } else {
      //     await fs.promises.unlink(path.join(`public/${user.image_url}`));
      //     user.image_url = `images/upload/${req.fileName}`;
      //   }
      // }

      user.fullname = name;
      user.email = email;
      user.identity_number = identity_number;

      const family = await UserFamily.findAll({ where: { user_id: user.id } });
      if (!isNil(family_member_data)) {
        for (const itemFamily of family) {
          const idExists = family_member_data.some(
            (item) => item.id === itemFamily.id
          );
          if (!idExists) {
            itemFamily.destroy();
          }
        }

        const arrayFamilyCreate = [];
        for (const item of family_member_data) {
          const idExists = family.some((itemSome) => itemSome.id === item.id);

          if (idExists) {
            const familyDetail = await UserFamily.findOne({
              where: { id: item.id },
            });
            familyDetail.status = item.family_status_id;
            familyDetail.fullname = item.name;
            familyDetail.save();
          } else {
            arrayFamilyCreate.push({
              fullname: item.name,
              status: item.family_status_id,
              user_id: user.id,
            });
          }
        }

        const createFamily = await UserFamily.bulkCreate(arrayFamilyCreate);
      }

      await user.save();

      return res.json({
        success: true,
        msg: "Success update data",
        data: user,
      });
    } catch (e) {
      return res.json({
        success: false,
        msg: e.message,
      });
    }
  },

  editImageUser: async (req, res) => {
    try {
      const user = req.userAuth;

      // Memeriksa apakah ada file yang diunggah
      if (req.file) {
        // Jika pengguna sudah memiliki gambar, hapus gambar yang lama
        if (user.image_url) {
          await fs.promises.unlink(path.join(`public/${user.image_url}`));
        }

        // Simpan path gambar baru
        user.image_url = `images/upload/${req.file.filename}`;
      }

      // Simpan perubahan ke database
      await user.save();

      return res.json({
        success: true,
        msg: "Success update data",
        data: user,
      });
    } catch (e) {
      return res.json({
        success: false,
        msg: e.message,
      });
    }
  }

};
