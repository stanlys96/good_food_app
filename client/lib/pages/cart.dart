import 'package:flutter/material.dart';
import '../components/big_icon_box.dart';
import '../components/cart_box.dart';
import '../components/big_button.dart';

class CartPage extends StatefulWidget {
  static final routeName = '/cart';
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int quantity = 0;
  bool isPressed = false;
  List cart = [];
  void changeValue(task) {
    setState(() {
      if (task == 'minus') {
        if (quantity == 0) {
          return;
        }
        quantity--;
      } else if (task == 'plus') {
        quantity++;
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(246, 246, 246, 1),
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      backgroundColor: Color.fromRGBO(246, 246, 246, 1),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 25.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Orders,',
                      style: TextStyle(
                        fontSize: 22.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        bottom: 15.0,
                      ),
                      child: Text(
                        '5 items selected',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                BigIconBox(icon: Icons.delete, color: Colors.black)
              ],
            ),
            Container(
              height: 285.0,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return CartBox();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subtotal (5 items)',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Color.fromRGBO(151, 151, 151, 1),
                    ),
                  ),
                  Text(
                    'Rp 2.850.000',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                bottom: 20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Delivery charge',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Color.fromRGBO(151, 151, 151, 1),
                    ),
                  ),
                  Text(
                    'Free delivery',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 2.0,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                bottom: 20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Amount:',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Rp 2.850.000',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            BigButton(
              title: 'Checkout',
            ),
          ],
        ),
      ),
    );
  }
}
