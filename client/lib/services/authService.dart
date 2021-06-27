import 'package:dio/dio.dart';

class AuthService {
  Dio dio = Dio();

  register(full_name, email, password) async {
    try {
      return await dio.post('https://good-food-app.herokuapp.com/user/register',
          data: {
            "full_name": full_name,
            "email": email,
            "password": password,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } catch (e) {
      print(e);
    }
  }

  login(email, password) async {
    try {
      return await dio.post('https://good-food-app.herokuapp.com/user/login',
          data: {"email": email, "password": password},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } catch (e) {
      print(e);
    }
  }

  getBurgers() async {
    try {
      return await dio.get('https://good-food-app.herokuapp.com/menu/burgers',
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } catch (e) {
      print(e);
    }
  }

  getNoodles() async {
    try {
      return await dio.get('https://good-food-app.herokuapp.com/menu/noodles',
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } catch (e) {
      print(e);
    }
  }

  getDrinks() async {
    try {
      return await dio.get('https://good-food-app.herokuapp.com/menu/drinks',
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } catch (e) {
      print(e);
    }
  }

  getSnacks() async {
    try {
      return await dio.get('https://good-food-app.herokuapp.com/menu/snacks',
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } catch (e) {
      print(e);
    }
  }

  getAll() async {
    try {
      return await dio.get('https://good-food-app.herokuapp.com/menu/all',
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } catch (e) {
      print(e);
    }
  }

  getMenu(category) async {
    try {
      return await dio.get('https://good-food-app.herokuapp.com/menu/$category',
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } catch (e) {
      print(e);
    }
  }

  getCategories() async {
    try {
      return await dio.get('https://good-food-app.herokuapp.com/category/',
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } catch (e) {
      print(e);
    }
  }
}
