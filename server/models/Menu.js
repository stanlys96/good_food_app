const { getDatabase } = require('../config/mongodb');
const ObjectID = require('mongodb').ObjectID;

class Menu {
  static getBurgers() {
    return getDatabase().collection('burgers').find().toArray();
  }

  static getNoodles() {
    return getDatabase().collection('noodles').find().toArray();
  }

  static getDrinks() {
    return getDatabase().collection('drinks').find().toArray();
  }

  static getSnacks() {
    return getDatabase().collection('snacks').find().toArray();
  }

  static getAll() {
    return getDatabase().collection('menu').find().toArray();
  }
}

module.exports = Menu;