import 'package:flutter/material.dart';

IconButton buttonIcon(BuildContext context) {
  return IconButton(
    onPressed: () {
      Navigator.pop(context);
    },
    icon: Icon(Icons.arrow_back),
  );
}
