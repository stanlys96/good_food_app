import 'package:flutter/material.dart';

showError(String errormessage, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('ERROR'),
        content: Text(errormessage),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          )
        ],
      );
    },
  );
}

showMessage(String message, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Success!'),
        content: Text(message),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          )
        ],
      );
    },
  );
}

twoButtonsDialog(
    BuildContext context, onPressed, title, dialogTitle, dialogText) {
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
      title != null ? onPressed(title) : onPressed();
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(dialogTitle),
    content: Text(dialogText),
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
}
