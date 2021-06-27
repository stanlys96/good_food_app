import 'package:flutter/material.dart';
import '../pages/menu_detail.dart';

class MenuCard extends StatelessWidget {
  String title;
  String subTitle;
  String price;
  String imageUrl;
  String description;
  int rating;

  MenuCard({
    required this.title,
    required this.subTitle,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.rating,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MenuDetailPage(
              title: title,
              rating: rating,
              description: description,
              imageUrl: imageUrl,
              price: price,
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
                      'Rp $price',
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
