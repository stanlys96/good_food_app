const Menu = require('../models/Menu');

class MenuController {
  static async getBurgers(req, res) {
    try {
      const burgers = await Menu.getBurgers();
      res.json(burgers);
    } catch (err) {
      console.log(err);
    }
  }

  static async getNoodles(req, res) {
    try {
      const noodles = await Menu.getNoodles();
      res.json(noodles);
    } catch (err) {
      console.log(err);
    }
  }
  static async getDrinks(req, res) {
    try {
      const drinks = await Menu.getDrinks();
      res.json(drinks);
    } catch (err) {
      console.log(err);
    }
  }
  static async getSnacks(req, res) {
    try {
      const snacks = await Menu.getSnacks();
      res.json(snacks);
    } catch (err) {
      console.log(err);
    }
  }

  static async getAll(req, res) {
    try {
      const menu = await Menu.getAll();
      res.json(menu);
    } catch (err) {
      console.log(err);
    }
  }

  static async querySearch(req, res) {
    try {
      const str = req.body.str;
      console.log(str);
      const query = await Menu.querySearch(str);
      res.json(query);
    } catch (err) {
      console.log(err);
    }
  }

  static async getByCategory(req, res) {
    try {
      const category = req.body.category;
      const query = await Menu.getByCategory(category);
      res.json(query);
    } catch (err) {
      console.log(err);
    }
  }
}

module.exports = MenuController;