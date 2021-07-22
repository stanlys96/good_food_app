import 'package:flutter/material.dart';
import 'package:food_delivery_app/utility/dialog.dart';
import './star_widget.dart';
import '../utility/priceFormatter.dart';
import '../pages/menu_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/menu.dart';

class FavoriteCard extends StatefulWidget {
  Menu menu;
  Function onPressed;

  FavoriteCard({
    required this.menu,
    required this.onPressed,
  });

  @override
  _FavoriteCardState createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  String email = '';

  getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      this.email = prefs.getString('userEmail')!;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    int theRest = 5 - widget.menu.rating;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MenuDetailPage(
              menu: widget.menu,
              email: email,
            ),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(right: 10.0),
        child: Container(
          width: 175.0,
          padding: EdgeInsets.only(
            top: 10.0,
            bottom: 10.0,
            left: 10.0,
            right: 10.0,
          ),
          decoration: BoxDecoration(
            color: Color.fromRGBO(246, 246, 246, 1),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      15.0,
                    ),
                    child: Image.asset(
                      widget.menu.imageUrl,
                      width: 150.0,
                      height: 100.0,
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, right: 12.0),
                          child: InkWell(
                            onTap: () {
                              twoButtonsDialog(
                                  context,
                                  widget.onPressed,
                                  widget.menu.title,
                                  "Delete Favorite",
                                  "Are you sure you want to delete this item?");
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8.0,
                ),
                child: Text(
                  widget.menu.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 8.0,
                ),
                child: Text(
                  'Rp ${oCcy.format(widget.menu.price).toString()}',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      for (int i = 0; i < widget.menu.rating; i++)
                        StarWidget(icon: Icons.star)
                    ],
                  ),
                  Row(
                    children: [
                      for (int i = 0; i < theRest; i++)
                        StarWidget(icon: Icons.star_outline)
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
