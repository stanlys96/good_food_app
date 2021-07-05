import 'package:flutter/material.dart';
import '../services/authService.dart';

enum ResultState { Loading, NoData, HasData, Error }

List makeNestedList(List list) {
  List output = [];
  List temp = [];
  for (int i = 0; i < list.length; i++) {
    if (i % 2 == 0 && i != 0) {
      output.add(temp);
      temp = [];
    }
    temp.add(list[i]);
  }
  output.add(temp);
  return output;
}

class UserProvider extends ChangeNotifier {
  final AuthService apiService;
  String email;

  UserProvider({required this.apiService, required this.email}) {
    fetchUserCart();
    fetchUserFavorites();
  }

  // User Data
  Map? _userResult;
  String _message = '';
  ResultState? _state;
  List? _userCart;
  List? _userFavorites;
  num _totalPrice = 0;
  List? _nestedUserFavorites;
  int _favoritesLength = 0;

  String get message => _message;
  Map? get result => _userResult;
  ResultState? get state => _state;
  List? get userCart => _userCart;
  List? get userFavorites => _userFavorites;
  List? get nestedUserFavorites => _nestedUserFavorites;
  num get totalPrice => _totalPrice;
  int get favoritesLength => _favoritesLength;

  Future<dynamic> fetchUserCart() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final result = await apiService.getUserData(this.email);
      if (result.data.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        calculateTotalPrice(result.data['cart']);
        notifyListeners();
        return _userCart = result.data['cart'];
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> fetchUserFavorites() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final result = await apiService.getUserData(this.email);
      if (result.data.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        _nestedUserFavorites = makeNestedList(result.data['favorites']);
        _favoritesLength = 0;
        _nestedUserFavorites?.forEach((data) {
          data.forEach((nestedData) => _favoritesLength++);
        });
        notifyListeners();
        return _userFavorites = result.data['favorites'];
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> deleteOneFavorite(title) async {
    try {
      await apiService.deleteOneFavorite(this.email, title);
      _nestedUserFavorites?.forEach((item) {
        item?.removeWhere((data) => data['title'] == title);
      });
      _userFavorites?.removeWhere((data) => data['title'] == title);
      _state = ResultState.HasData;
      _favoritesLength--;
      notifyListeners();
      return _userFavorites;
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> addToCart(title, quantity, intPrice, imageUrl) async {
    try {
      await apiService.addToCart(
          this.email, title, quantity, intPrice, imageUrl);
      _userCart?.add({
        "title": title,
        "quantity": quantity,
        "intPrice": intPrice,
        "imageUrl": imageUrl,
      });
      // _state = ResultState.HasData;
      calculateTotalPrice(_userCart);
      notifyListeners();
      return _userCart;
    } catch (e) {
      print(e);
      // _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> addToFavorites(
      title, rating, description, price, imageUrl) async {
    try {
      var found = false;
      _userFavorites?.forEach((data) {
        if (data['title'] == title) {
          found = true;
        }
      });
      if (!found) {
        apiService.addToFavorites(
            this.email, title, rating, description, price, imageUrl);
        _state = ResultState.HasData;
        _userFavorites?.add({
          "title": title,
          "rating": rating,
          "description": description,
          "price": price,
          "imageUrl": imageUrl,
        });
        notifyListeners();
        return 'Success';
      } else {
        return 'Duplicate';
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> deleteOneCart(title) async {
    try {
      await apiService.deleteOneCartItem(this.email, title);
      _userCart?.removeWhere((item) => item['title'] == title);
      _state = ResultState.HasData;
      calculateTotalPrice(_userCart);
      notifyListeners();
      return _userCart;
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> deleteAllCarts() async {
    try {
      await apiService.deleteAllCartItems(this.email);
      _userCart = [];
      _state = ResultState.HasData;
      this._totalPrice = 0;
      notifyListeners();
      return _userCart;
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> reduceCartQuantity(title) async {
    try {
      await apiService.reduceItemQuantity(this.email, title);
      _userCart?.forEach((cart) async {
        if (cart['title'] == title) {
          if (cart['quantity'] == 1) {
            await apiService.deleteOneCartItem(this.email, title);
            _userCart?.removeWhere((item) => item['title'] == title);
            calculateTotalPrice(_userCart);
            notifyListeners();
            return;
          }
          cart['quantity']--;
        }
      });
      calculateTotalPrice(_userCart);
      notifyListeners();
      return _userCart;
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> addCartQuantity(title) async {
    try {
      await apiService.increaseItemQuantity(this.email, title);
      _userCart?.forEach((cart) async {
        if (cart['title'] == title) {
          cart['quantity']++;
        }
      });
      calculateTotalPrice(_userCart);
      notifyListeners();
      return _userCart;
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  calculateTotalPrice(getData) {
    this._totalPrice = 0;
    getData.forEach((data) {
      this._totalPrice += data['quantity'] * data['price'];
    });
  }
}
