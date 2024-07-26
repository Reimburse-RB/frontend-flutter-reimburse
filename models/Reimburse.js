const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");

const Reimburse = sequelize.define(
  "reimburse",
  {
    diagnosiss: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    destination: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    status: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 1,
    },
    role: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: 1,
    },
    user_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
  },
  {
    timestamps: true,
  }
);

module.exports = Reimburse;
