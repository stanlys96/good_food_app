import 'dart:core';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/provider/cart_provider.dart';
import 'package:provider/provider.dart';
import '../components/big_icon_box.dart';
import '../components/cart_box.dart';
import '../components/big_button.dart';
import '../widgets/platform_widget.dart';
import '../utility/priceFormatter.dart';
import '../data/api/apiService.dart';
import '../utility/provider_state.dart';

class CartPage extends StatefulWidget {
  String email;
  CartPage({required this.email});
  static final routeName = '/cart';
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Widget _buildItem() {
    return Builder(
      builder: (BuildContext newContext) {
        var cartLength = Provider.of<CartProvider>(newContext).userCart.length;
        var totalPrice = Provider.of<CartProvider>(newContext).totalPrice;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(newContext).accentColor,
            elevation: 0.0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(newContext);
              },
              icon: Icon(Icons.arrow_back),
            ),
          ),
          backgroundColor: Theme.of(newContext).accentColor,
          body: Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 25.0,
            ),
            decoration: BoxDecoration(
              color: Theme.of(newContext).primaryColor,
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
                            '${cartLength.toString()} items selected',
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
                      color: Theme.of(context).accentColor,
                      deleteAllItems:
                          Provider.of<CartProvider>(newContext).deleteAllCarts,
                    ),
                  ],
                ),
                Container(
                  height: 285.0,
                  child: Consumer<CartProvider>(builder: (context, state, _) {
                    if (state.state == ResultState.Loading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state.state == ResultState.HasData) {
                      return state.userCart.length == 0
                          ? Center(
                              child: Text(
                                'No items to display...',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: state.userCart.length,
                              itemBuilder: (context, index) {
                                var data = state.userCart[index];
                                return CartBox(
                                  title: data['title'],
                                  quantity: data['quantity'],
                                  price: data['price'] * data['quantity'],
                                  imageUrl: data['imageUrl'],
                                  email: widget.email,
                                  reduceQuantity:
                                      Provider.of<CartProvider>(context)
                                          .reduceCartQuantity,
                                  increaseQuantity:
                                      Provider.of<CartProvider>(context)
                                          .addCartQuantity,
                                  deleteItem: Provider.of<CartProvider>(context)
                                      .deleteOneCart,
                                );
                              },
                            );
                    } else if (state.state == ResultState.NoData) {
                      return Center(child: Text(state.message));
                    } else if (state.state == ResultState.Error) {
                      return Center(child: Text(state.message));
                    } else {
                      return Center(child: Text(''));
                    }
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subtotal (${cartLength.toString()} items)',
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
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return ChangeNotifierProvider<CartProvider>(
      create: (_) =>
          CartProvider(apiService: ApiService(), email: widget.email),
      child: _buildItem(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildAndroid,
    );
  }
}
