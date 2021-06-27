import 'package:flutter/material.dart';

class IconBox extends StatelessWidget {
  double size;
  Icon icon;
  Function? changeValue;
  String? task;
  IconBox(
      {required this.size, required this.icon, this.changeValue, this.task});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        changeValue!(task);
      },
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          border: Border.all(
            color: Color.fromRGBO(238, 238, 238, 1),
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: icon,
      ),
    );
  }
}
