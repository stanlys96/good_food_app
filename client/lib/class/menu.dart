import 'dart:convert';

class Menu {
  late int id;
  late String title;
  late String subTitle;
  late int price;
  late String imageUrl;
  late String description;
  late int rating;

  Menu({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.rating,
  });

  Menu.fromJson(Map<String, dynamic> menu) {
    id = menu['id'];
    title = menu['title'];
    subTitle = menu['subTitle'];
    price = menu['price'];
    imageUrl = menu['imageUrl'];
    description = menu['description'];
    rating = menu['rating'];
  }
}

List<Menu> parseMenus(String? json) {
  if (json == null) {
    return [];
  }

  final List parsed = jsonDecode(json);
  return parsed.map<Menu>((json) => Menu.fromJson(json)).toList();
}

class MenuList {
  List menuList = [
    Menu(
      id: 1,
      title: 'Chicken Burger',
      subTitle: 'Flavoroso',
      price: 80000,
      imageUrl: 'images/burgers/burger_1.jpeg',
      description:
          'Food consisting one or more cooked patties of ground meat, usually beef, placed inside a sliced bread roll or bun.',
      rating: 5,
    ),
    Menu(
      id: 2,
      title: 'Salmon Burger',
      subTitle: 'Salty Squid',
      price: 95000,
      imageUrl: 'images/burgers/burger_2.jpeg',
      description:
          'Food consisting one or more cooked patties of ground meat, usually beef, placed inside a sliced bread roll or bun.',
      rating: 4,
    ),
    Menu(
      id: 3,
      title: 'Beef Cheese Burger',
      subTitle: 'Masala',
      price: 60000,
      imageUrl: 'images/burgers/burger_3.jpeg',
      description:
          'Food consisting one or more cooked patties of ground meat, usually beef, placed inside a sliced bread roll or bun.',
      rating: 5,
    ),
    Menu(
      id: 4,
      title: 'Vegan Burger',
      subTitle: 'Veganic Corner',
      price: 75000,
      imageUrl: 'images/burgers/burger_4.jpeg',
      description:
          'Food consisting one or more cooked patties of ground meat, usually beef, placed inside a sliced bread roll or bun.',
      rating: 4,
    ),
    Menu(
      id: 5,
      title: 'Lamb Burger',
      subTitle: 'New Zealand Fresh',
      price: 105000,
      imageUrl: 'images/burgers/burger_5.jpeg',
      description:
          'Food consisting one or more cooked patties of ground meat, usually beef, placed inside a sliced bread roll or bun.',
      rating: 4,
    ),
  ];
}
