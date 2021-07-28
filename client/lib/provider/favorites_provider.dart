import 'package:flutter/material.dart';
import '../data/api/apiService.dart';
import '../utility/provider_state.dart';
import '../utility/nested_list.dart';

class FavoritesProvider extends ChangeNotifier {
  final ApiService apiService;
  String email;

  FavoritesProvider({required this.apiService, required this.email}) {
    fetchUserFavorites();
  }

  String _message = '';
  ResultState? _state;
  List _userFavorites = [];
  List _nestedUserFavorites = [];
  int _favoritesLength = 0;

  String get message => _message;
  ResultState? get state => _state;
  List get userFavorites => _userFavorites;
  List get nestedUserFavorites => _nestedUserFavorites;
  int get favoritesLength => _favoritesLength;

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
        _nestedUserFavorites.forEach((data) {
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

  Future<dynamic> addToFavorites(id, subTitle, category, title, rating,
      description, price, imageUrl) async {
    try {
      var found = false;
      _userFavorites.forEach((data) {
        if (data['title'] == title) {
          found = true;
        }
      });
      if (!found) {
        apiService.addToFavorites(id, subTitle, category, this.email, title,
            rating, description, price, imageUrl);
        _state = ResultState.HasData;
        _userFavorites.add({
          "id": id,
          "subTitle": subTitle,
          "category": category,
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

  Future<dynamic> deleteOneFavorite(title) async {
    try {
      await apiService.deleteOneFavorite(this.email, title);
      _nestedUserFavorites.forEach((item) {
        item?.removeWhere((data) => data['title'] == title);
      });
      _userFavorites.removeWhere((data) => data['title'] == title);
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
}
