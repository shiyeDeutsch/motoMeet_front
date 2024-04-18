import 'package:flutter/material.dart';

import '../../models/enum.dart';

Future<RouteTypeEnum?> showRouteTypeEnumDialog(BuildContext context) async {
  return showDialog<RouteTypeEnum>(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: const Text('Select Route Type'),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, RouteTypeEnum.hiking);
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.directions_walk), // Icon for hiking
                SizedBox(width: 10), // Space between icon and text
                Text('Hiking'),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, RouteTypeEnum.biking);
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.directions_bike), // Icon for biking
                SizedBox(width: 10), // Space between icon and text
                Text('Biking'),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, RouteTypeEnum.motorcycle);
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.motorcycle), // Icon for motorcycle
                SizedBox(width: 10), // Space between icon and text
                Text('Motorcycle'),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, RouteTypeEnum.jeep);
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons
                    .directions_car), // Assuming this for Jeep, customize as needed
                SizedBox(width: 10), // Space between icon and text
                Text('Jeep'),
              ],
            ),
          ),
        ],
      );
    },
  );
}
