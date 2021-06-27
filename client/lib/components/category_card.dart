import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  String title;
  bool isPressed;
  int id;
  Function changeState;
  dynamic icon;
  CategoryCard({
    required this.title,
    required this.isPressed,
    required this.id,
    required this.changeState,
    required this.icon,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        changeState(id);
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Container(
          width: 90.0,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: isPressed
                ? Color.fromRGBO(253, 219, 50, 1)
                : Color.fromRGBO(246, 246, 246, 1),
            borderRadius: BorderRadius.circular(15.0),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey.withOpacity(0.8),
            //     offset: Offset(0.0, 0.1),
            //     blurRadius: 5.0,
            //   ),
            // ],
          ),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: icon,
                ),
              ),
              SizedBox(height: 5.0),
              Expanded(
                flex: 1,
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
