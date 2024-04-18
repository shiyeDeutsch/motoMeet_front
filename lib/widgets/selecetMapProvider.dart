import 'package:flutter/material.dart';

enum MapType { standard, satellite, terrain }

class MapTypeSelector extends StatefulWidget {
  @override
  _MapTypeSelectorState createState() => _MapTypeSelectorState();
}

class _MapTypeSelectorState extends State<MapTypeSelector> {
  MapType _currentMapType = MapType.standard;
  bool _isExpanded = false;

  void _changeMapType(MapType type) {
    setState(() {
      _currentMapType = type;
      _isExpanded = false; // Close the selector after making a selection
    });
    // Here, you would add code to change the actual map type
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Text('Change Map Type'),
        ),
        if (_isExpanded) ...[
          _mapTypeOption(MapType.standard, 'Standard'),
          _mapTypeOption(MapType.satellite, 'Satellite'),
          _mapTypeOption(MapType.terrain, 'Terrain'),
        ],
      ],
    );
  }

  Widget _mapTypeOption(MapType type, String title) {
    return ListTile(
      title: Text(title),
      leading: Radio(
        value: type,
        groupValue: _currentMapType,
        onChanged: (MapType? value) {
          if (value != null) {
            _changeMapType(value);
          }
        },
      ),
    );
  }
}
