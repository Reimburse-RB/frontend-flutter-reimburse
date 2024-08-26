const express = require("express");
const User = require("../models/User");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const { where } = require("sequelize");
const path = require("path");
const { isNil } = require("ramda");
const UserFamily = require("../models/User-Family");
const allStatus = require("../utils/allStatus");
require("dotenv").config();
const fs = require("fs");

module.exports = {
  userRegister: async (req, res) => {
    const { name, identity_number, role, email, password } = req.body;

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

      const salt = await bcrypt.genSalt(10);
      const hashPassword = await bcrypt.hash(password, salt);

      const token = jwt.sign({ email: email }, process.env.SECRET_KEY);

      const user = await User.create({
        fullname: name,
        email,
        password: hashPassword,
        identity_number,
        status: 2,
        role,
        token,
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
    const { email, password } = req.body;
    try {
      const user = await User.findOne({ where: { email: email } });

      const validpass = await bcrypt.compare(password, user.password);
      if (!validpass) {
        return res.json({
          success: false,
          msg: "Password Anda Salah!!",
        });
      }

      return res.json({
        success: true,
        msg: "Anda Berhasil Login!!",
        token: user.token,
        user: user,
      });
    } catch (error) {
      return res.json({ msg: error.message });
    }
  },

  getVerificationAccount: async (req, res) => {
    const user = req.userAuth;

    try {
      if (user.role != 2) {
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
            user.image_url != null
              ? `${process.env.URL}${user.image_url}`
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

  verificationAccount: async (req, res) => {
    const { userId } = req.body;
    const user = req.userAuth;

    try {
      if (isNil(userId)) {
        return res.json({
          success: false,
          msg: "Input user id",
        });
      }

      if (user.role != 2) {
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

      if (user.role != 2) {
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
          img_url:
            user.image_url != null
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

      if (req.fileName !== undefined) {
        if (
          user.image_url == undefined ||
          user.image_url == null ||
          user.image_url == ""
        ) {
          user.image_url = `images/upload/${req.fileName}`;
        } else {
          await fs.promises.unlink(path.join(`public/${user.image_url}`));
          user.image_url = `images/upload/${req.fileName}`;
        }
      }

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
        msg: "success update data",
        data: user,
      });
    } catch (e) {
      return res.json({
        success: false,
        msg: e.message,
      });
    }
  },
};
