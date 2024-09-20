import 'package:flutter/material.dart';

import '../models/enum.dart';

class WayPointBottomSheet extends StatefulWidget {
  @override
  _WayPointBottomSheetState createState() => _WayPointBottomSheetState();
}

class _WayPointBottomSheetState extends State<WayPointBottomSheet> {
  WaypointCategory _selectedCategory = WaypointCategory.Natural;
  WaypointType? _selectedType;

  @override
  Widget build(BuildContext context) {
    return   Container( 
    width: MediaQuery.of( context).size.width,
      height: MediaQuery.of( context).size.height,
      child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildCategorySelector(),
                  Divider(),
                  _buildWaypointTypeList(),
                ],
               
      ),
    );
  }

  // void _showAddLandmarkSheet() {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (context) {
  //       return Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           _buildCategorySelector(),
  //           Divider(),
  //           _buildWaypointTypeList(),
  //         ],
  //       );
  //     },
  //   );
  // }

  Widget _buildCategorySelector() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: WaypointCategory.values.map((category) {
          return ChoiceChip(
            label: Text(category.toString().split('.').last),
            selected: _selectedCategory == category,
            onSelected: (selected) {
              setState(() {
                _selectedCategory = category;
              });
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildWaypointTypeList() {
    List<WaypointType> waypointTypes = _getWaypointTypesByCategory(_selectedCategory);
    return Expanded(
      child: ListView.builder(
        itemCount: waypointTypes.length,
        itemBuilder: (context, index) {
          WaypointType type = waypointTypes[index];
          return ListTile(
            leading: Icon(Icons.landscape), // You can use appropriate icons here
            title: Text(type.toString().split('.').last),
            onTap: () {
              _selectedType = type;
              Navigator.pop(context);
              _showLandmarkDetailsDialog();
            },
          );
        },
      ),
    );
  }

  List<WaypointType> _getWaypointTypesByCategory(WaypointCategory category) {
    switch (category) {
      case WaypointCategory.Natural:
       List<WaypointType> x=   WaypointTypeExtension.naturalWaypointRange.map((e) => e).toList();
      return x;   
      case WaypointCategory.Informative:
       List<WaypointType> y=   WaypointTypeExtension.informativeWaypointRange.map((e) => e).toList();
        return y;
      case WaypointCategory.Warning:
       List<WaypointType> z=   WaypointTypeExtension.warningWaypointRange.map((e) => e).toList();
        return z;
      default:
        return [];
    }
  }

  void _showLandmarkDetailsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Landmark Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Description'),
              ),
              // Add more fields as needed
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Save the landmark details
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
 