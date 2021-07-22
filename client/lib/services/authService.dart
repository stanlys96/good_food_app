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

  getAll() async {
    try {
      return await dio.get('https://good-food-app.herokuapp.com/menu/all',
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } catch (e) {
      print(e);
    }
  }

  getByCategory(category) async {
    try {
      return await dio.post('https://good-food-app.herokuapp.com/menu/category',
          data: {
            "category": category,
          },
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

  querySearch(category, str) async {
    try {
      return await dio.post('https://good-food-app.herokuapp.com/menu',
          data: {
            "category": category,
            "str": str,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } catch (e) {
      print(e);
    }
  }

  getUserData(email) async {
    try {
      return await dio.get('https://good-food-app.herokuapp.com/user/$email',
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } catch (e) {
      print(e);
    }
  }

  getMenuById(category, id) async {
    try {
      return await dio.get(
          'https://good-food-app.herokuapp.com/menu/$category/$id',
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } catch (e) {
      print(e);
    }
  }

  addToFavorites(id, subTitle, category, email, title, rating, description,
      price, imageUrl) async {
    try {
      return await dio.post(
          'https://good-food-app.herokuapp.com/user/$email/addToFavorites',
          data: {
            "id": id,
            "subTitle": subTitle,
            "category": category,
            "title": title,
            "rating": rating,
            "description": description,
            "price": price,
            "imageUrl": imageUrl
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } catch (e) {
      print(e);
    }
  }

  deleteOneFavorite(email, title) async {
    try {
      return await dio.delete(
          'https://good-food-app.herokuapp.com/user/$email/deleteOneFavorite',
          data: {
            "title": title,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } catch (e) {
      print(e);
    }
  }

  addToCart(email, title, quantity, price, imageUrl) async {
    try {
      return await dio.post(
          'https://good-food-app.herokuapp.com/user/$email/addToCart',
          data: {
            "title": title,
            "quantity": quantity,
            "price": price,
            "imageUrl": imageUrl,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } catch (e) {
      print(e);
    }
  }

  reduceItemQuantity(email, title) async {
    try {
      return await dio.post(
          'https://good-food-app.herokuapp.com/user/$email/reduceQuantity',
          data: {
            "title": title,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } catch (e) {
      print(e);
    }
  }

  increaseItemQuantity(email, title) async {
    try {
      return await dio.post(
          'https://good-food-app.herokuapp.com/user/$email/increaseQuantity',
          data: {
            "title": title,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } catch (e) {
      print(e);
    }
  }

  deleteOneCartItem(email, title) async {
    try {
      return await dio.delete(
          'https://good-food-app.herokuapp.com/user/$email/deleteOneItem',
          data: {
            "title": title,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } catch (e) {
      print(e);
    }
  }

  deleteAllCartItems(email) async {
    try {
      return await dio.delete('https://good-food-app.herokuapp.com/user/$email',
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } catch (e) {
      print(e);
    }
  }
}
