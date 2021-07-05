import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/app_bar.dart';
import '../components/star_widget.dart';
import '../components/icon_box.dart';
import '../components/favorite_button.dart';
import '../components/big_button.dart';
import '../utility/dialog.dart';
import '../provider/user_provider.dart';

class MenuDetailPage extends StatefulWidget {
  static final routeName = '/menuDetail';
  String title;
  int rating;
  String description;
  String price;
  String imageUrl;
  String email;
  int intPrice;

  MenuDetailPage({
    required this.title,
    required this.rating,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.email,
    required this.intPrice,
  });

  @override
  State<MenuDetailPage> createState() => _MenuDetailPageState();
}

class _MenuDetailPageState extends State<MenuDetailPage> {
  int quantity = 0;
  bool isPressed = false;
  List? userFavorites = [];
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

  addToCart(email, title, quantity, intPrice, imageUrl, context) async {
    await Provider.of<UserProvider>(context, listen: false)
        .addToCart(title, quantity, intPrice, imageUrl);
    showMessage('Successfully added to cart!', context);
    setState(() {
      this.quantity = 0;
    });
  }

  favoriteOnTap(context) async {
    var message = await Provider.of<UserProvider>(context, listen: false)
        .addToFavorites(widget.title, widget.rating, widget.description,
            widget.intPrice, widget.imageUrl);
    if (message == 'Success') {
      showMessage('Successfully added to favorites!', context);
    } else {
      showError('This meal is already added to favorites!', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    int theRest = 5 - widget.rating;
    return Scaffold(
      appBar: header(context, widget.email, buttonIcon),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 350.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0),
                ),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(widget.imageUrl),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 300.0),
              child: Container(
                height: 400.0,
                padding: EdgeInsets.only(
                  left: 30.0,
                  right: 30.0,
                  top: 25.0,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
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
                              widget.title,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    for (int i = 0; i < widget.rating; i++)
                                      StarWidget(icon: Icons.star)
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    for (int i = 0; i < theRest; i++)
                                      StarWidget(icon: Icons.star_border)
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Consumer<UserProvider>(
                          builder: (context, state, _) {
                            if (state.state == ResultState.Loading) {
                              return Center(child: CircularProgressIndicator());
                            } else if (state.state == ResultState.HasData) {
                              return FavoriteButton(
                                icon: Icons.favorite,
                                color: Colors.red,
                                onPressed: favoriteOnTap,
                              );
                            } else if (state.state == ResultState.NoData) {
                              return Center(child: Text(state.message));
                            } else if (state.state == ResultState.Error) {
                              return Center(child: Text(state.message));
                            } else {
                              return Center(child: Text(''));
                            }
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        bottom: 15.0,
                      ),
                      child: Text(
                        widget.description,
                        style: TextStyle(
                          height: 1.4,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconBox(
                              size: 40.0,
                              icon: Icon(Icons.add),
                              task: 'plus',
                              changeValue: changeValue,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                quantity.toString(),
                                style: TextStyle(
                                  fontSize: 25.0,
                                ),
                              ),
                            ),
                            IconBox(
                              size: 40.0,
                              icon: Icon(Icons.remove),
                              task: 'minus',
                              changeValue: changeValue,
                            ),
                          ],
                        ),
                        Text(
                          'Rp ${widget.price}',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    InkWell(
                      onTap: () {
                        if (quantity == 0) {
                          showError('Please add quantity.', context);
                        } else {
                          addToCart(widget.email, widget.title, quantity,
                              widget.intPrice, widget.imageUrl, context);
                        }
                      },
                      child: BigButton(
                        title: 'Add to Cart',
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

IconButton buttonIcon(BuildContext context) {
  return IconButton(
    onPressed: () {
      Navigator.pop(context);
    },
    icon: Icon(Icons.arrow_back),
  );
}
