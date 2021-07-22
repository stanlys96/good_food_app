import 'package:flutter/material.dart';
import '../pages/menu_detail.dart';
import '../utility/priceFormatter.dart';
import '../model/menu.dart';

class MenuCard extends StatelessWidget {
  Menu menu;
  String email;

  MenuCard({
    required this.menu,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MenuDetailPage(
              menu: menu,
              email: email,
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
                  tag: menu.imageUrl,
                  child: Image.asset(
                    menu.imageUrl,
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
                      menu.title,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        menu.subTitle,
                        style: TextStyle(
                          color: Color.fromRGBO(193, 193, 193, 1),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      'Rp ${oCcy.format(menu.price).toString()}',
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
