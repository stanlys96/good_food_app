import 'package:flutter/material.dart';

class BigIconBox extends StatelessWidget {
  IconData icon;
  Color color;
  BigIconBox({required this.icon, required this.color});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
