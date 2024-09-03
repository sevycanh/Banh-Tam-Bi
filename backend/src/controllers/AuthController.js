const User = require("../models/User");
const CryptoJS = require("crypto-js");
const jwt = require("jsonwebtoken");

module.exports = {
  register: async (req, res) => {
    const user = await User.findOne({ phone: req.body.phone });

    if (user) {
      return res.status(409).json("User exist");
  }

    const newUser = new User({
      name: req.body.name,
      phone: req.body.phone,
      location: "",
      isAdmin: false,
      password: CryptoJS.AES.encrypt(
        req.body.password,
        process.env.Crypto_SEC
      ).toString(),
    });

    try {
      await newUser.save();
      return res.status(201).json("Success")
    } catch (error) {
      return res.status(500).json(error);
    }
  },

  login: async (req, res) => {
    try {
      const user = await User.findOne({
        phone: req.body.phone,
        deleted: false,
      });

      if (!user) {
        return res.status(401).json("Wrong Login Details");
      } else {
        const deCryptedPass = CryptoJS.AES.decrypt(
          user.password,
          process.env.Crypto_SEC
        );

        const dePassword = deCryptedPass.toString(CryptoJS.enc.Utf8);

        if (dePassword !== req.body.password){
          return res.status(401).json("Wrong Login Details");
        }

        const userToken = jwt.sign(
          {
            id: user._id,
            isAdmin: user.isAdmin,
          },
          process.env.JWT_SEC,
          {
            expiresIn: 3600,
          }
        );

        const { password, __v, createAt, ...other } = user._doc;

        return res.status(200).json({
          ...other,
          userToken,
        });
      }
    } catch (error) {
      return res.status(500).json("Login error");
    }
  },

};
