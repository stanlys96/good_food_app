import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';

class DatabaseManager {
  final CollectionReference menu =
      FirebaseFirestore.instance.collection('food');

  final CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');

  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  getMenuList() async {
    List itemsList = [];
    String type = 'burgers';
    try {
      await menu.get().then((querySnapshot) {
        querySnapshot.docs.forEach((item) {
          itemsList.add(item.data());
        });
      });
      return itemsList;
    } catch (e) {
      print(e);
    }
  }

  getCategoryList() async {
    List itemsList = [];
    try {
      await categories.get().then((querySnapshot) {
        querySnapshot.docs.forEach((item) {
          itemsList.add(item.data());
        });
      });
      return itemsList;
    } catch (e) {
      print(e);
    }
  }

  updateUserList() async {}

  getUsersList() async {
    List itemsList = [];
    try {
      await users.get().then((querySnapshot) {
        querySnapshot.docs.forEach((item) {
          itemsList.add(item.data());
        });
      });
      return itemsList;
    } catch (e) {
      print(e);
    }
  }
}
