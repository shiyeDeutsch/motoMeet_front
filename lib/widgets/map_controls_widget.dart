import 'package:flutter/material.dart';

class MapControlsWidget extends StatelessWidget {
  final VoidCallback onCenterLocationPressed;
  final VoidCallback onLayersPressed;
  final VoidCallback onBackPressed;

  const MapControlsWidget({
    Key? key,
    required this.onCenterLocationPressed,
    required this.onLayersPressed,
    required this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Back button in top left
        Positioned(
          top: 50.0,
          left: 16.0,
          child: _buildBackButton(),
        ),
        
        // Right side controls
        Positioned(
          top: 50.0,
          right: 16.0,
          child: Column(
            children: [
              _buildMapControlButton(
                icon: Icons.my_location,
                onPressed: onCenterLocationPressed,
                tooltip: 'Center on my location',
              ),
              const SizedBox(height: 12),
              _buildMapControlButton(
                icon: Icons.layers,
                onPressed: onLayersPressed,
                tooltip: 'Map layers',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBackButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: onBackPressed,
        tooltip: 'Back',
        color: const Color(0xFF3E6C51), // Forest green from adventure theme
      ),
    );
  }

  Widget _buildMapControlButton({
    required IconData icon,
    required VoidCallback onPressed,
    required String tooltip,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
        tooltip: tooltip,
        color: const Color(0xFF3E6C51), // Forest green from adventure theme
      ),
    );
  }
}