const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");

const ReimburseDetail = sequelize.define(
  "reimburse_detail",
  {
    medical_detail: {
      type: DataTypes.INTEGER,
      allowNull: true,
    },
    travel_detail: {
      type: DataTypes.INTEGER,
      allowNull: true,
    },
    intended_for: {
      type: DataTypes.INTEGER,
      allowNull: true,
    },
    price: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    role: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 1,
    },
    receipt_date: {
      type: DataTypes.DATE,
      allowNull: false,
    },
    description: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    reimburse_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
  },
  {
    timestamps: true,
  }
);

module.exports = ReimburseDetail;
