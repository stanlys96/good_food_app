class Menu {
  String id;
  String title;
  String subTitle;
  String imageUrl;
  String description;
  int price;
  int rating;
  String category;

  Menu({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.rating,
    required this.category,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        id: json["_id"],
        title: json["title"],
        subTitle: json["subTitle"],
        description: json["description"],
        imageUrl: json["imageUrl"],
        price: json["price"],
        rating: json["rating"],
        category: json["category"],
      );
}
