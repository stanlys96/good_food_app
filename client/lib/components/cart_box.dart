import 'package:flutter/material.dart';
import 'package:food_delivery_app/utility/dialog.dart';
import '../utility/priceFormatter.dart';

class CartBox extends StatelessWidget {
  String title;
  int quantity;
  String imageUrl;
  int price;
  String email;
  Function reduceQuantity;
  Function increaseQuantity;
  Function deleteItem;
  CartBox({
    required this.title,
    required this.quantity,
    required this.imageUrl,
    required this.price,
    required this.email,
    required this.reduceQuantity,
    required this.increaseQuantity,
    required this.deleteItem,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Color.fromRGBO(246, 246, 246, 1),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(
                imageUrl,
                width: 70.0,
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.only(
                  left: 12.0,
                  right: 5.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.fill,
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            increaseQuantity(title);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color.fromRGBO(238, 238, 238, 1),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Icon(Icons.add),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            quantity.toString(),
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            reduceQuantity(title);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color.fromRGBO(238, 238, 238, 1),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Icon(Icons.remove),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 5.0,
            ),
            Expanded(
              child: FittedBox(
                fit: BoxFit.fill,
                child: Text(
                  'Rp ${oCcy.format(price).toString()}',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
            IconButton(
              constraints: BoxConstraints(
                maxWidth: 30.0,
                maxHeight: 100.0,
              ),
              onPressed: () {
                twoButtonsDialog(context, deleteItem, title, "Delete Cart",
                    "Are you sure you want to delete this item?");
              },
              icon: Center(
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
