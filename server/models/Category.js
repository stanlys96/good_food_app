const { getDatabase } = require('../config/mongodb');
const ObjectID = require('mongodb').ObjectID;

class Category {
  static getCategories() {
    return getDatabase().collection('categories').find().toArray();
  }
}

module.exports = Category;