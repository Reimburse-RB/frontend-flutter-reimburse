const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");

const Notification = sequelize.define(
  "notification",
  {
    title: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    body: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    reimburse_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    category_reimbursement: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    user: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    identity_number: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    price: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    date_reimburse: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    category: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    token_target: {
      type: DataTypes.STRING,
      allowNull: false,
    },
  },
  {
    timestamps: true,
  }
);

module.exports = Notification;
