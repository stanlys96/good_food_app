const Category = require('../models/Category');

class CategoryController {
  static async getCategories(req, res) {
    try {
      const categories = await Category.getCategories();
      res.json(categories);
    } catch(err) {
      console.log(err);
    }
  }
}

module.exports = CategoryController;