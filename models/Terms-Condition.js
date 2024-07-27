const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");

const TermsCondition = sequelize.define(
  "terms_condition",
  {
    tnc: {
      type: DataTypes.TEXT,
      allowNull: false,
    },
    category: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
  },
  {
    timestamps: true,
  }
);

module.exports = TermsCondition;
