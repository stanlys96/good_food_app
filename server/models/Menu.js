const { getDatabase } = require('../config/mongodb');
const ObjectID = require('mongodb').ObjectID;

class Menu {
  static getAll() {
    return getDatabase().collection('menu').find().toArray();
  }

  static getByCategory(category) {
    return getDatabase().collection(category).find().toArray();
  }

  static querySearch(category, str) {
    return getDatabase().collection(category).find({ "title": { $regex: `.*${str}.*`, $options: "i" } }).toArray();
  }

  static getById(category, id) {
    return getDatabase().collection(category).findOne({ _id: ObjectID(id) });
  }
}

module.exports = Menu;