import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pages/menu_detail.dart';
import '../provider/user_provider.dart';
import '../services/authService.dart';
import '../utility/priceFormatter.dart';

class MenuCard extends StatelessWidget {
  String title;
  String subTitle;
  int price;
  String imageUrl;
  String description;
  int rating;
  String email;
  int intPrice;

  MenuCard({
    required this.title,
    required this.subTitle,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.rating,
    required this.email,
    required this.intPrice,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider<UserProvider>(
              create: (_) =>
                  UserProvider(apiService: AuthService(), email: email),
              child: MenuDetailPage(
                title: title,
                rating: rating,
                description: description,
                imageUrl: imageUrl,
                price: price,
                email: email,
              ),
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Container(
          padding: EdgeInsets.only(
            left: 15.0,
            top: 15.0,
            bottom: 15.0,
          ),
          decoration: BoxDecoration(
            color: Color.fromRGBO(246, 246, 246, 1),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Hero(
                  tag: imageUrl,
                  child: Image.asset(
                    imageUrl,
                    width: 80.0,
                  ),
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        subTitle,
                        style: TextStyle(
                          color: Color.fromRGBO(193, 193, 193, 1),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      'Rp ${oCcy.format(price).toString()}',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_vert),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
