import 'package:flutter/material.dart';

class StarWidget extends StatelessWidget {
  IconData icon;
  StarWidget({required this.icon});
  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: Color.fromRGBO(252, 219, 19, 1),
    );
  }
}
