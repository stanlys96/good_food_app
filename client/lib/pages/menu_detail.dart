import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/app_bar.dart';
import '../components/star_widget.dart';
import '../components/icon_box.dart';
import '../components/favorite_button.dart';
import '../components/big_button.dart';
import '../utility/dialog.dart';
import '../utility/priceFormatter.dart';
import '../utility/provider_state.dart';
import '../provider/cart_provider.dart';
import '../provider/favorites_provider.dart';
import '../model/menu.dart';
import '../widgets/platform_widget.dart';
import '../widgets/icon_button.dart';
import '../services/authService.dart';

class MenuDetailPage extends StatefulWidget {
  static final routeName = '/menuDetail';
  Menu menu;
  String email;

  MenuDetailPage({
    required this.menu,
    required this.email,
  });

  @override
  State<MenuDetailPage> createState() => _MenuDetailPageState();
}

class _MenuDetailPageState extends State<MenuDetailPage> {
  int quantity = 0;
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
    await Provider.of<CartProvider>(context, listen: false)
        .addToCart(title, quantity, intPrice, imageUrl);
    showMessage('Successfully added to cart!', context);
    setState(() {
      this.quantity = 0;
    });
  }

  favoriteOnTap(context) async {
    var message = await Provider.of<FavoritesProvider>(context, listen: false)
        .addToFavorites(
            widget.menu.id,
            widget.menu.subTitle,
            widget.menu.category,
            widget.menu.title,
            widget.menu.rating,
            widget.menu.description,
            widget.menu.price,
            widget.menu.imageUrl);
    if (message == 'Success') {
      showMessage('Successfully added to favorites!', context);
    } else {
      showError('This meal is already added to favorites!', context);
    }
  }

  Widget _buildItem(context) {
    int theRest = 5 - widget.menu.rating;
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
                  image: AssetImage(widget.menu.imageUrl),
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
                              widget.menu.title,
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
                                    for (int i = 0; i < widget.menu.rating; i++)
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
                        Consumer<FavoritesProvider>(
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
                        widget.menu.description,
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
                          'Rp ${oCcy.format(widget.menu.price).toString()}',
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
                    Consumer<CartProvider>(
                      builder: (context, state, _) {
                        return InkWell(
                          onTap: () {
                            if (quantity == 0) {
                              showError('Please add quantity.', context);
                            } else {
                              addToCart(
                                  widget.email,
                                  widget.menu.title,
                                  quantity,
                                  widget.menu.price,
                                  widget.menu.imageUrl,
                                  context);
                            }
                          },
                          child: BigButton(
                            title: 'Add to Cart',
                          ),
                        );
                      },
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

  Widget _buildAndroid(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CartProvider>(
          create: (_) =>
              CartProvider(apiService: AuthService(), email: widget.email),
        ),
        ChangeNotifierProvider<FavoritesProvider>(
          create: (_) =>
              FavoritesProvider(apiService: AuthService(), email: widget.email),
        ),
      ],
      child: _buildItem(context),
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
