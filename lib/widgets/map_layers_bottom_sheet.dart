import 'package:flutter/material.dart';

const String MAPBOX_STYLE = 'mapbox://styles/mapbox/outdoors-v12';

class MapLayersBottomSheet extends StatelessWidget {
  final Function(String) onMapStyleSelected;

  const MapLayersBottomSheet({
    Key? key, 
    required this.onMapStyleSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapStyles = [
      {'name': 'Outdoors', 'style': 'mapbox://styles/mapbox/outdoors-v12'},
      {'name': 'Satellite', 'style': 'mapbox://styles/mapbox/satellite-streets-v12'},
      {'name': 'Navigation', 'style': 'mapbox://styles/mapbox/navigation-day-v1'},
      {'name': 'Dark', 'style': 'mapbox://styles/mapbox/dark-v11'},
    ];
    
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Map Style',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...mapStyles.map((style) => ListTile(
            title: Text(style['name']!),
            onTap: () {
              onMapStyleSelected(style['style']!);
              Navigator.pop(context);
            },
            trailing: style['style'] == MAPBOX_STYLE 
                ? const Icon(Icons.check, color: Color(0xFF3E6C51))
                : null,
          )),
        ],
      ),
    );
  }
}