const validator = require('validator');
const bcrypt = require('bcrypt');
const crypto = require('crypto');
// const catchAsync = require('../utils/catchAsync');

exports.checkPassword = async function (candidatePassword, EntereduserPassword) {
  try {
    return bcrypt.compare(candidatePassword, EntereduserPassword);
  } catch (error) {
    return -1;
  }
};

exports.checkEmail = function (email) {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return emailRegex.test(email);
};

exports.phoneCheck = function (PhoneNumber) {
  return /^\d+$/.test(PhoneNumber)
};

exports.hashPassword = async function (password) {
  try {
    return await bcrypt.hash(password, 12)
  } catch (error) {
    return -1;
  }
};
