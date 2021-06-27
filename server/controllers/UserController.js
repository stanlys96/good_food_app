const User = require('../models/User');
const { comparePassword } = require('../helpers/bcrypt');
const { generateToken } = require('../helpers/jwt');
const User = require('../models/User');

class UserController {
  static async register(req, res) {
    try {
      const user = await User.register(req.body);
      res.json(user.ops[0]);
    } catch (err) {
      console.log(err);
    }
  }

  static async login(req, res) {
    try {
      const { email, password } = req.body;
      const user = await User.findingOne(email);
      if (user) {
        const comparedPassword = comparePassword(password, user.password);
        if (comparedPassword) {
          const token = generateToken({
            full_name: user.full_name,
            email: user.email,
          })
          res.json({
            full_name: user.full_name,
            email: user.email,
            token
          })
        } else {
          res.json({ message: 'Username or password is incorrect!' });
        }
      } else {
        res.json({ message: 'Username or password is incorrect!' });
      }
    } catch (err) {
      console.log(err);
    }
  }

  static async addToCart(req, res) {
    try {
      const cart = await User.addToCart(req.body);
      res.json(cart);
    } catch (err) {
      console.log(err);
    }
  }

  static async getUser(req, res) {
    try {
      const { email } = req.params.email;
      const User = await User.findingOne(email);
      res.json({
        full_name: user.full_name,
        email: user.email,
        cart: user.cart
      })
    } catch (err) {
      console.log(err);
    }
  }
}

module.exports = UserController;