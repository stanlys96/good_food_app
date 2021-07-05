import 'package:flutter/material.dart';
import './star_widget.dart';
import '../utility/priceFormatter.dart';

class FavoriteCard extends StatelessWidget {
  String title;
  int price;
  String imageUrl;
  int rating;
  Function onPressed;
  FavoriteCard({
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    int theRest = 5 - rating;
    return Padding(
      padding: EdgeInsets.only(right: 10.0),
      child: Container(
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
                    imageUrl,
                    width: 150.0,
                    height: 100.0,
                  ),
                ),
                Container(
                  width: 150.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, right: 12.0),
                        child: InkWell(
                          onTap: () {
                            Widget cancelButton = ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                              ),
                              child: Text("Cancel"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            );
                            Widget continueButton = ElevatedButton(
                              child: Text("Yes"),
                              onPressed: () {
                                onPressed(title);
                                Navigator.pop(context);
                              },
                            );

                            // set up the AlertDialog
                            AlertDialog alert = AlertDialog(
                              title: Text("Delete Favorite"),
                              content: Text(
                                  "Are you sure you want to delete this favorite?"),
                              actions: [
                                cancelButton,
                                continueButton,
                              ],
                            );

                            // show the dialog
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );
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
                title,
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
                'Rp ${oCcy.format(price).toString()}',
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
                    for (int i = 0; i < rating; i++)
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
    );
  }
}
