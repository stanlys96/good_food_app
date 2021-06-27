import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../class/category.dart';
import '../class/menu.dart';
import '../components/category_card.dart';
import '../components/menu_card.dart';
import 'package:intl/intl.dart';
import '../services/authService.dart';
import 'dart:core';

final oCcy = NumberFormat("#,##0.00", "id_ID");

class MainPage extends StatefulWidget {
  static final routeName = '/main';
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  late AnimationController controller;
  final ScrollController _scrollController = ScrollController();
  String category = 'burgers';
  List categoryList = [];
  List menuList = [];
  List allData = [];

  MenuList menu = MenuList();

  signOut() async {
    Navigator.pushNamed(context, '/home');
  }

  fetchData() async {
    var result = await AuthService().getAll();
    if (result == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        allData = result.data;
        allData.forEach((data) {
          if (data[category] != null) {
            menuList = data[category];
          }
        });
      });
    }
  }

  fetchCategoryData() async {
    var result = await AuthService().getCategories();
    if (result.data == null) {
      print('Unable to retrieve categories');
    } else {
      setState(() {
        result.data.forEach((data) {
          categoryList.add(
            Category(
              id: data['id'],
              title: data['title'],
              isPressed: data['id'] == 1 ? true : false,
              icon:
                  Image.asset('images/${data['title'].toLowerCase()}-icon.png'),
            ),
          );
        });
        categoryList.sort((a, b) => a.id.compareTo(b.id));
      });
    }
  }

  void changeCardState(int id) {
    setState(() {
      for (int i = 0; i < categoryList.length; i++) {
        if (categoryList[i].id == id) {
          categoryList[i].setIsPressed(true);
          category = categoryList[i].title.toLowerCase();
          _scrollController.animateTo(
            _scrollController.position.minScrollExtent,
            duration: Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
          );
          allData.forEach((data) {
            if (data[category] != null) {
              menuList = data[category];
            }
          });
        } else {
          categoryList[i].setIsPressed(false);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchCategoryData();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rcvdData = ModalRoute.of(context)?.settings.arguments as Map;
    if (menuList.length == 0 && categoryList.length == 0) {
      return Scaffold(
        body: SafeArea(
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    value: controller.value,
                    semanticsLabel: 'Linear progress indicator',
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Loading...',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/cart');
              },
              icon: FaIcon(
                FontAwesomeIcons.shoppingBag,
              ),
            ),
            IconButton(
              onPressed: () {
                signOut();
              },
              icon: FaIcon(
                FontAwesomeIcons.signOutAlt,
              ),
            ),
            SizedBox(width: 5.0),
          ],
          elevation: 0.0,
        ),
        body: Container(
          padding: EdgeInsets.only(
            left: 30.0,
            right: 30.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi, ${rcvdData['fullName']}',
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
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 5.0,
                      ),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(246, 246, 246, 1),
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
                          Container(
                            width: 225.0,
                            child: TextField(
                              onChanged: (val) {},
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                                hintText: 'Search',
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(253, 219, 50, 1),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Center(
                            child: FaIcon(FontAwesomeIcons.utensils),
                          ),
                        ),
                      ),
                    )
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
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryList.length,
                  itemBuilder: (context, index) {
                    return CategoryCard(
                      title: categoryList[index].title,
                      isPressed: categoryList[index].isPressed,
                      id: categoryList[index].id,
                      icon: categoryList[index].icon,
                      changeState: changeCardState,
                    );
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
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: menuList.length,
                  itemBuilder: (context, index) {
                    return MenuCard(
                      title: menuList[index]['title'],
                      subTitle: menuList[index]['subTitle'],
                      imageUrl: menuList[index]['imageUrl'],
                      price: oCcy.format(menuList[index]['price']).toString(),
                      description: menuList[index]['description'],
                      rating: menuList[index]['rating'],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}
