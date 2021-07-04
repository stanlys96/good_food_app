import 'package:flutter/material.dart';

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
        Widget cancelButton = ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
          ),
          child: Text("Cancel"),
          onPressed: () {
            Navigator.pop(context);
          },
        );
        Widget continueButton = ElevatedButton(
          child: Text("Yes"),
          onPressed: () {
            deleteAllItems!();
            Navigator.pop(context);
          },
        );

        // set up the AlertDialog
        AlertDialog alert = AlertDialog(
          title: Text("Delete Cart"),
          content: Text("Are you sure you want to delete all cart items?"),
          actions: [
            cancelButton,
            continueButton,
          ],
        );

        // show the dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
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
