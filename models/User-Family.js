const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");

const UserFamily = sequelize.define(
  "user_family",
  {
    user_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    fullname: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    status: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
  },
  {
    timestamps: true,
  }
);

module.exports = UserFamily;
