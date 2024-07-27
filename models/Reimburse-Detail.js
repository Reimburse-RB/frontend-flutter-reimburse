const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");

const ReimburseDetail = sequelize.define(
  "reimburse_detail",
  {
    title_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    title_other: {
      type: DataTypes.STRING,
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
