const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");

const ImageReimburse = sequelize.define(
  "image_reimburse",
  {
    image: {
      type: DataTypes.BLOB,
      allowNull: false,
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

module.exports = ImageReimburse;
