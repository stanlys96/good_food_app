import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  IconData icon;
  Color color;
  Function onPressed;
  FavoriteButton({
    required this.icon,
    required this.color,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed(context);
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
