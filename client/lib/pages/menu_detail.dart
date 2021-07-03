import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/star_widget.dart';
import '../components/icon_box.dart';
import '../components/big_icon_box.dart';
import '../components/big_button.dart';
import '../services/authService.dart';
import '../utility/dialog.dart';

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
    var result = await AuthService()
        .addToCart(email, title, quantity, intPrice, imageUrl);
    if (result == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        this.quantity = 0;
      });
      showMessage('Successfully added to cart!', context);
    }
  }

  signOut() async {
    Navigator.pushNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    int theRest = 5 - widget.rating;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () async {},
            icon: Icon(
              Icons.favorite,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: FaIcon(
              FontAwesomeIcons.shoppingBag,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
            icon: FaIcon(
              FontAwesomeIcons.signOutAlt,
            ),
          ),
          SizedBox(width: 5.0),
        ],
      ),
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
                        BigIconBox(
                          icon: !isPressed
                              ? Icons.favorite_border_outlined
                              : Icons.favorite,
                          color: Colors.red,
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
                        addToCart(widget.email, widget.title, quantity,
                            widget.intPrice, widget.imageUrl, context);
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
