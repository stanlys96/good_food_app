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

class FavoritesProvider extends ChangeNotifier {
  final AuthService apiService;
  String email;

  FavoritesProvider({required this.apiService, required this.email}) {
    fetchUserFavorites();
  }

  String _message = '';
  ResultState? _state;
  List? _userFavorites;
  int _favoritesLength = 0;
  List? _originalData;

  List? get userFavorites => _userFavorites;
  int get favoritesLength => _favoritesLength;
  ResultState? get state => _state;
  String get message => _message;
  List? get originalData => _originalData;

  Future<dynamic> fetchUserFavorites() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final result = await apiService.getUserData(this.email);
      print(result);
      if (result.data.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        var nestedData = makeNestedList(result.data['favorites']);
        _favoritesLength = 0;
        _originalData = result.data['favorites'];
        nestedData.forEach((data) {
          data.forEach((nestedData) => _favoritesLength++);
        });
        return _userFavorites = nestedData;
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
      _userFavorites?.forEach((item) {
        item?.removeWhere((data) => data['title'] == title);
      });
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
