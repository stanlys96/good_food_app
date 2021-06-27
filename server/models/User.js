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

  static addToCart({ email, title, quantity, price, imageUrl }) {
    return getDatabase().collection('users').update({ email }, {
      $push: {
        cart: {
          title,
          quantity,
          price,
          imageUrl
        },
      }
    })
  }
}

module.exports = User;