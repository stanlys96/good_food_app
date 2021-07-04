import 'package:flutter/material.dart';
import '../services/authService.dart';
import '../class/category.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestaurantsProvider extends ChangeNotifier {
  final AuthService apiService;
  String category = 'burgers';

  RestaurantsProvider({required this.apiService}) {
    fetchRestaurantData();
    fetchCategoriesData();
  }

  set category_name(String category) {
    this.category = category;
  }

  // Restaurant Data
  List? _restaurantsResult;
  String _message = '';
  ResultState? _state;

  String get message => _message;
  List? get result => _restaurantsResult;
  ResultState? get state => _state;

  // Categories Data
  List? _categoriesResult;
  String _categoriesMessage = '';
  ResultState? _categoriesState;

  String get categoriesMessage => _categoriesMessage;
  List? get categoriesResult => _categoriesResult;
  ResultState? get categoriesState => _categoriesState;

  Future<dynamic> fetchRestaurantData() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final result = await apiService.getByCategory(this.category);
      if (result.data.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantsResult = result.data;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> fetchRestaurantResult(str) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final result = await apiService.querySearch(this.category, str);
      if (result.data.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantsResult = result.data;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> fetchCategoriesData() async {
    try {
      _categoriesState = ResultState.Loading;
      notifyListeners();
      final result = await apiService.getCategories();
      if (result.data.isEmpty) {
        _categoriesState = ResultState.NoData;
        notifyListeners();
        return _categoriesMessage = 'Empty Data';
      } else {
        List categoryList = [];
        _categoriesState = ResultState.HasData;
        result.data.forEach((data) {
          categoryList.add(
            Category(
              id: data['id'],
              title: data['title'],
              isPressed: data['id'] == 1 ? true : false,
              icon:
                  Image.asset('images/${data['title'].toLowerCase()}-icon.png'),
            ),
          );
        });
        categoryList.sort((a, b) => a.id.compareTo(b.id));
        notifyListeners();
        return _categoriesResult = categoryList;
      }
    } catch (e) {
      _categoriesState = ResultState.Error;
      notifyListeners();
      return _categoriesMessage = 'Error --> $e';
    }
  }
}
