import 'package:flutter/material.dart';
import '../components/big_icon_box.dart';
import '../components/cart_box.dart';
import '../components/big_button.dart';
import '../utility/priceFormatter.dart';
import '../services/authService.dart';
import 'dart:core';

class CartPage extends StatefulWidget {
  String userEmail;
  CartPage({required this.userEmail});
  static final routeName = '/cart';
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with TickerProviderStateMixin {
  int quantity = 0;
  bool isPressed = false;
  List cart = [];
  List userCart = [];
  num totalPrice = 0;
  String userEmail = '';

  fetchData() async {
    var user = await AuthService().getUserData(widget.userEmail);
    if (user == null) {
      print('Unable to retrieve');
    } else {
      totalPrice = 0;
      setState(() {
        userCart = user.data['cart'];
        userCart.forEach((data) {
          totalPrice += data['price'] * data['quantity'];
        });
      });
    }
  }

  void calculateTotalPrice(quantity, price) {
    totalPrice += quantity * price;
  }

  reduceQuantity(email, title) async {
    var reduce = await AuthService().reduceItemQuantity(email, title);
    if (reduce == null) {
      print('error');
    } else {
      fetchData();
    }
  }

  increaseQuantity(email, title) async {
    var increase = await AuthService().increaseItemQuantity(email, title);
    if (increase == null) {
      print('error');
    } else {
      fetchData();
    }
  }

  deleteOneItem(email, title) async {
    var delete = await AuthService().deleteOneCartItem(email, title);
    if (delete == null) {
      print('error');
    } else {
      fetchData();
      Navigator.pop(context);
    }
  }

  deleteAllItems() async {
    var delete = await AuthService().deleteAllCartItems(widget.userEmail);
    if (delete == null) {
      print('error');
    } else {
      fetchData();
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
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
                        '${userCart.length.toString()} items selected',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                BigIconBox(
                  icon: Icons.delete,
                  color: Colors.black,
                  deleteAllItems: deleteAllItems,
                ),
              ],
            ),
            Container(
              height: 285.0,
              child: userCart.length == 0
                  ? Center(
                      child: Text('No items to display...'),
                    )
                  : ListView.builder(
                      itemCount: userCart.length,
                      itemBuilder: (context, index) {
                        var data = userCart[index];
                        return CartBox(
                          title: data['title'],
                          quantity: data['quantity'],
                          price: data['price'] * data['quantity'],
                          imageUrl: data['imageUrl'],
                          email: widget.userEmail,
                          reduceQuantity: reduceQuantity,
                          increaseQuantity: increaseQuantity,
                          deleteItem: deleteOneItem,
                        );
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
                    'Subtotal (${userCart.length.toString()} items)',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Color.fromRGBO(151, 151, 151, 1),
                    ),
                  ),
                  Text(
                    'Rp ${oCcy.format(totalPrice).toString()}',
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
                    'Rp ${oCcy.format(totalPrice).toString()}',
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
