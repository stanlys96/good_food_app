const Menu = require('../models/Menu');

class MenuController {
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
      const category = req.body.category;
      const query = await Menu.querySearch(category, str);
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

  static async getById(req, res) {
    try {
      const category = req.params.category;
      const id = req.params.id;
      const menu = await Menu.getById(category, id);
      res.json(menu);
    } catch (err) {
      console.log(err);
    }
  }
}

module.exports = MenuController;