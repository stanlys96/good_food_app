import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  String title;
  BigButton({required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 15.0,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromRGBO(252, 219, 19, 1),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 17.0,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
