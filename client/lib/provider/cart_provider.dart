import 'package:flutter/material.dart';
import '../data/api/apiService.dart';
import '../utility/provider_state.dart';

class CartProvider extends ChangeNotifier {
  final ApiService apiService;
  String email;

  CartProvider({required this.apiService, required this.email}) {
    fetchUserCart();
  }

  // User Data
  String _message = '';
  ResultState? _state;
  List _userCart = [];
  num _totalPrice = 0;

  String get message => _message;
  ResultState? get state => _state;
  List get userCart => _userCart;
  num get totalPrice => _totalPrice;

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

  Future<dynamic> addToCart(title, quantity, intPrice, imageUrl) async {
    try {
      await apiService.addToCart(
          this.email, title, quantity, intPrice, imageUrl);
      _userCart.add({
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

  Future<dynamic> deleteOneCart(title) async {
    try {
      await apiService.deleteOneCartItem(this.email, title);
      _userCart.removeWhere((item) => item['title'] == title);
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
      _userCart.forEach((cart) async {
        if (cart['title'] == title) {
          if (cart['quantity'] == 1) {
            await apiService.deleteOneCartItem(this.email, title);
            _userCart.removeWhere((item) => item['title'] == title);
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
      _userCart.forEach((cart) async {
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
