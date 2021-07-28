import 'package:flutter/material.dart';
import '../widgets/dialog.dart';

class BigIconBox extends StatelessWidget {
  IconData icon;
  Color color;
  Function? deleteAllItems;
  BigIconBox({
    required this.icon,
    required this.color,
    this.deleteAllItems,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        twoButtonsDialog(context, deleteAllItems, null, "Delete All Carts",
            "Are you sure you want to delete all cart items?");
      },
      child: Container(
        height: 50.0,
        width: 50.0,
        decoration: BoxDecoration(
          border: Border.all(
            color: Color.fromRGBO(238, 238, 238, 1),
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Icon(
          icon,
          color: color,
        ),
      ),
    );
  }
}
