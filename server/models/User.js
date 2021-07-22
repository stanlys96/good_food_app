const { getDatabase } = require('../config/mongodb');
const { hashPassword } = require('../helpers/bcrypt');

class User {
  static register(user) {
    user.password = hashPassword(user.password);
    user.favorites = [];
    user.cart = [];
    return getDatabase().collection('users').insertOne(user);
  }

  static findingOne(email) {
    return getDatabase().collection('users').findOne({ email });
  }

  static addToCart(email, { title, quantity, price, imageUrl }) {
    quantity = parseInt(quantity);
    price = parseInt(price);
    getDatabase().collection('users').findOne({ email }).then((result => {
      if (result.cart == undefined) {
        return getDatabase().collection('users').update({ email: email }, {
          $push: {
            cart: {
              title,
              quantity,
              price,
              imageUrl
            },
          }
        })
      } else {
        let found = false;
        result.cart.forEach((data) => {
          if (data.title === title) {
            found = true;
            return getDatabase().collection('users').update({ email, 'cart.title': title }, { $inc: { "cart.$.quantity": quantity } })
          }
        })
        if (!found) {
          return getDatabase().collection('users').update({ email: email }, {
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
    }))
  }

  static addToFavorites(email, { id, subTitle, category, title, rating, description, price, imageUrl }) {
    price = parseInt(price);
    rating = parseInt(rating);
    getDatabase().collection('users').findOne({ email }).then((result => {
      return getDatabase().collection('users').update({ email: email }, {
        $push: {
          favorites: {
            id,
            subTitle,
            category,
            title,
            rating,
            description,
            price,
            imageUrl
          },
        }
      })
    }))
  }

  static deleteOneFavorite(email, { title }) {
    getDatabase().collection('users').findOne({ email }).then((result) => {
      result.favorites.forEach((data) => {
        if (data.title == title) {
          return getDatabase().collection('users').update({ email }, { $pull: { favorites: { title: title } } });
        }
      });
    });
  }

  static reduceItemQuantity(email, { title }) {
    getDatabase().collection('users').findOne({ email }).then((result) => {
      result.cart.forEach((data) => {
        if (data.title == title) {
          if (data.quantity == 1) {
            return getDatabase().collection('users').update({ email }, { $pull: { cart: { title: title } } });
          }
          return getDatabase().collection('users').update({ email, 'cart.title': title }, { $inc: { 'cart.$.quantity': -1 } })
        }
      });
    });
  }

  static addItemQuantity(email, { title }) {
    getDatabase().collection('users').findOne({ email }).then((result) => {
      result.cart.forEach((data) => {
        if (data.title == title) {
          return getDatabase().collection('users').update({ email, 'cart.title': title }, { $inc: { 'cart.$.quantity': +1 } })
        }
      });
    });
  }

  static deleteOneItem(email, { title }) {
    getDatabase().collection('users').findOne({ email }).then((result) => {
      result.cart.forEach((data) => {
        if (data.title == title) {
          return getDatabase().collection('users').update({ email }, { $pull: { cart: { title: title } } });
        }
      });
    });
  }

  static deleteAllItems(email) {
    console.log(email);
    getDatabase().collection('users').findOne({ email }).then((result) => {
      return getDatabase().collection('users').update({}, { $set: { cart: [] } }, { multi: true });
    });
  }
}

module.exports = User;