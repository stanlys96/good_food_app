const User = require('../models/User');
const { comparePassword } = require('../helpers/bcrypt');
const { generateToken } = require('../helpers/jwt');

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
      const email = req.params.email;
      const cart = await User.addToCart(email, req.body);
      res.json(cart);
    } catch (err) {
      console.log(err);
    }
  }

  static async addToFavorites(req, res) {
    try {
      const email = req.params.email;
      const favorite = await User.addToFavorites(email, req.body);
      res.json(favorite);
    } catch (err) {
      console.log(err);
    }
  }

  static async reduceQuantity(req, res) {
    try {
      const email = req.params.email;
      const cart = await User.reduceItemQuantity(email, req.body);
      res.json(cart);
    } catch (err) {
      console.log(err);
    }
  }

  static async increaseQuantity(req, res) {
    try {
      const email = req.params.email;
      const cart = await User.addItemQuantity(email, req.body);
      res.json(cart);
    } catch (err) {
      console.log(err);
    }
  }

  static async deleteOneItem(req, res) {
    try {
      const email = req.params.email;
      const item = await User.deleteOneItem(email, req.body);
      res.json(item);
    } catch (err) {
      console.log(err);
    }
  }

  static async deleteOneFavorite(req, res) {
    try {
      const email = req.params.email;
      const item = await User.deleteOneFavorite(email, req.body);
      res.json(item);
    } catch (err) {
      console.log(err);
    }
  }

  static async deleteAllCartItems(req, res) {
    try {
      const email = req.params.email;
      console.log(email);
      const item = await User.deleteAllItems(email);
      res.json(item);
    } catch (err) {
      console.log(err);
    }
  }

  static async getUser(req, res) {
    try {
      const email = req.params.email;
      const user = await User.findingOne(email);
      res.json({
        full_name: user.full_name,
        email: user.email,
        cart: user.cart,
        favorites: user.favorites
      })
    } catch (err) {
      console.log(err);
    }
  }
}

module.exports = UserController;