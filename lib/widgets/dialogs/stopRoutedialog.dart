import 'package:flutter/material.dart';

Future<bool?> showStopDialog(BuildContext context) async {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Are you sure you want to stop the trip?'),
        actions: <Widget>[
          TextButton(
            child: Text('Yes'),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          TextButton(
            child: Text('No'),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
        ],
      );
    },
  );
}
