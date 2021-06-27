const { getDatabase } = require('../config/mongodb');
const { hashPassword } = require('../helpers/bcrypt');

class User {
  static register(user) {
    user.password = hashPassword(user.password);
    return getDatabase().collection('users').insertOne(user);
  }

  static findingOne(email) {
    return getDatabase().collection('users').findOne({ email });
  }
}

module.exports = User;