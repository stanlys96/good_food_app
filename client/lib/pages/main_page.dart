import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:core';
import '../components/category_card.dart';
import '../components/menu_card.dart';
import '../components/app_bar.dart';
import '../provider/restaurant_provider.dart';
import '../model/menu.dart';
import '../data/api/apiService.dart';
import '../widgets/platform_widget.dart';
import '../utility/provider_state.dart';
import '../widgets/navigation_drawer.dart';

class MainPage extends StatefulWidget {
  static final routeName = '/main';
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String userEmail = '';
  String userFullName = '';

  getQuerySearch(context, str) async {
    Provider.of<RestaurantsProvider>(context, listen: false)
        .fetchRestaurantResult(str);
  }

  void changeCardState(BuildContext context, int id) {
    var categoryList = Provider.of<RestaurantsProvider>(context, listen: false)
        .categoriesResult;
    for (int i = 0; i < categoryList.length; i++) {
      if (categoryList[i].id == id) {
        categoryList[i].setIsPressed(true);
        Provider.of<RestaurantsProvider>(context, listen: false).category_name =
            categoryList[i].title.toLowerCase();
        Provider.of<RestaurantsProvider>(context, listen: false)
            .fetchRestaurantData();
      } else {
        categoryList[i].setIsPressed(false);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userEmail = prefs.getString('userEmail')!;
      userFullName = prefs.getString('userFullName')!;
    });
  }

  Widget _buildItem(context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: header(context, userEmail),
      drawer: NavigationDrawerWidget(),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.0),
            topRight: Radius.circular(50.0),
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(
            left: 30.0,
            right: 30.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15.0,
              ),
              Text(
                'Hi, ${userFullName}',
                style: TextStyle(
                  fontSize: 19.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 5.0,
                  bottom: 10.0,
                ),
                child: Text(
                  'Food Special For You',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 5.0,
                ),
                decoration: BoxDecoration(
                  // color: Color.fromRGBO(246, 246, 246, 1),
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.search,
                      size: 18.0,
                    ),
                    SizedBox(width: 15.0),
                    Consumer<RestaurantsProvider>(builder: (context, state, _) {
                      return Container(
                        width: 290.0,
                        child: TextField(
                          onChanged: (val) {
                            getQuerySearch(context, val);
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            hintText: 'Search',
                          ),
                        ),
                      );
                    })
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  bottom: 10.0,
                ),
                child: Text(
                  'Categories',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18.0,
                  ),
                ),
              ),
              Container(
                height: 80.0,
                child: Consumer<RestaurantsProvider>(
                  builder: (context, state, _) {
                    if (state.categoriesState == ResultState.Loading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state.categoriesState == ResultState.HasData) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.categoriesResult.length,
                        itemBuilder: (context, index) {
                          return CategoryCard(
                            title: state.categoriesResult[index].title,
                            isPressed: state.categoriesResult[index].isPressed,
                            id: state.categoriesResult[index].id,
                            icon: state.categoriesResult[index].icon,
                            changeState: changeCardState,
                          );
                        },
                      );
                    } else if (state.categoriesState == ResultState.NoData) {
                      return Center(child: Text(state.categoriesMessage));
                    } else if (state.categoriesState == ResultState.Error) {
                      return Center(child: Text(state.categoriesMessage));
                    } else {
                      return Center(child: Text(''));
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 15.0,
                  bottom: 10.0,
                ),
                child: Text(
                  'Most Popular',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Expanded(
                child:
                    Consumer<RestaurantsProvider>(builder: (context, state, _) {
                  if (state.state == ResultState.Loading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state.state == ResultState.HasData) {
                    return ListView.builder(
                      itemCount: state.result.length,
                      itemBuilder: (context, index) {
                        Menu menu = Menu.fromJson(state.result[index]);
                        return MenuCard(
                          menu: menu,
                          email: userEmail,
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return ChangeNotifierProvider<RestaurantsProvider>(
      create: (_) => RestaurantsProvider(apiService: ApiService()),
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

IconButton buttonIcon(BuildContext context) {
  return IconButton(
    onPressed: () {},
    icon: Icon(Icons.menu),
  );
}
