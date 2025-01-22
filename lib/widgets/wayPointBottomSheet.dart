import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/enum.dart';
import '../models/route.dart';
import '../services/loctionService.dart';
import '../services/routeService.dart';

class WayPointBottomSheet extends StatefulWidget {
  @override
  _WayPointBottomSheetState createState() => _WayPointBottomSheetState();
}

class _WayPointBottomSheetState extends State<WayPointBottomSheet> {
  WaypointCategory _selectedCategory = WaypointCategory.Natural;
  WaypointType? _selectedType;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context  ) {
    return Container(
       color: Colors.black,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.6, 
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTopHandle(),
 
           _buildCategorySelector(),
          Divider(color: Colors.grey),
           _buildWaypointTypeGrid(),
        ],
      ),
    );
  }

  Widget _buildTopHandle() {
    return Container(
      height: 4.0,
      width: 40.0,
      margin: EdgeInsets.only(top: 8.0, bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey[700],
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

 Widget _buildCategorySelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: WaypointCategory.values.map((category) {
        bool isSelected = _selectedCategory == category;
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedCategory = category;
              _selectedType = null;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.blueAccent : Colors.grey[800],
                    shape: BoxShape.circle,
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: Colors.blueAccent.withOpacity(0.6),
                              spreadRadius: 2,
                              blurRadius: 6,
                            ),
                          ]
                        : [],
                  ),
                  child: Center(child: _getCategoryIcon(category, isSelected)),
                ),
                SizedBox(height: 1),
                Text(
                  category.toString().split('.').last,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _getCategoryIcon(WaypointCategory category, bool isSelected) {
     switch (category) {
      case WaypointCategory.Natural:
        return Icon(Icons.nature, color: Colors.white, size: 30);
      case WaypointCategory.Informative:
        return Icon(Icons.info, color: Colors.white, size: 30);
      case WaypointCategory.Warning:
        return Icon(Icons.warning, color: Colors.white, size: 30);
      default:
        return Icon(Icons.place, color: Colors.white, size: 30);
    }
  }

  Widget _buildWaypointTypeGrid() {
    List<WaypointType> waypointTypes = _getWaypointTypesByCategory(_selectedCategory);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: GridView.builder(
          itemCount: waypointTypes.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            childAspectRatio: 1.5,
          ),
          itemBuilder: (context, index) {
            WaypointType type = waypointTypes[index];
            return Consumer(
              builder: (context, ref, child) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedType = type;
                    });

                 //    Navigator.pop(context);
                // Then show the landmark details sheet after closing
                Future.delayed(Duration.zero, () {
                  _showLandmarkDetailsBottomSheet(context,   ref);
                });
                    // _handleWaypointSelection(
                    //   context,
                    //   type,
                    //   ref,
                    // );
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Color(0xFF2A2A2A),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: _getWaypointIcon(type),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        type.toString().split('.').last.replaceAll('_', ' '),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _getWaypointIcon(WaypointType type) {
   
    switch (type) {
      // Natural Waypoints
      case WaypointType.Lake:
        return Icon(Icons.pool, color: Colors.white, size: 30);
      case WaypointType.Cliff:
        return Icon(Icons.landscape, color: Colors.white, size: 30);
      case WaypointType.Waterfall:
        return Icon(Icons.water, color: Colors.white, size: 30);
      case WaypointType.WaterSpring:
        return Icon(Icons.opacity, color: Colors.white, size: 30);
      case WaypointType.River:
        return Icon(Icons.opacity, color: Colors.white, size: 30); 
        return Icon(Icons.terrain, color: Colors.white, size: 30);
      case WaypointType.Forest:
        return Icon(Icons.park, color: Colors.white, size: 30);
      case WaypointType.Meadow:
        return Icon(Icons.grass, color: Colors.white, size: 30); 
      case WaypointType.Cave:
        return Icon(Icons.dark_mode, color: Colors.white, size: 30);  
      case WaypointType.Valley:
        return Icon(Icons.forest, color: Colors.white, size: 30);
      case WaypointType.Beach:
        return Icon(Icons.beach_access, color: Colors.white, size: 30);
      case WaypointType.Glacier:
        return Icon(Icons.ac_unit, color: Colors.white, size: 30);
      case WaypointType.Volcano:
        return Icon(Icons.local_fire_department, color: Colors.white, size: 30);

      // Informative Waypoints
      case WaypointType.HistoricalSite:
        return Icon(Icons.history, color: Colors.white, size: 30);
      case WaypointType.VisitorCenter:
        return Icon(Icons.info_outline, color: Colors.white, size: 30);
      case WaypointType.Viewpoint:
        return Icon(Icons.visibility, color: Colors.white, size: 30);
      case WaypointType.Museum:
        return Icon(Icons.museum, color: Colors.white, size: 30);
      case WaypointType.CulturalSite:
        return Icon(Icons.account_balance, color: Colors.white, size: 30);
      case WaypointType.EducationalTrail:
        return Icon(Icons.school, color: Colors.white, size: 30);
      case WaypointType.ParkOffice:
        return Icon(Icons.apartment, color: Colors.white, size: 30);

      // Warning Waypoints
      case WaypointType.SteepDrop:
        return Icon(Icons.trending_down, color: Colors.white, size: 30);
      case WaypointType.SlipperyPath:
        return Icon(Icons.fast_forward , color: Colors.white, size: 30);  
      case WaypointType.HighTide:
        return Icon(Icons.waves, color: Colors.white, size: 30);
      case WaypointType.WildlifeSighting:
        return Icon(Icons.pets, color: Colors.white, size: 30);
      case WaypointType.FloodingArea:
        return Icon(Icons.water_damage, color: Colors.white, size: 30);  
      case WaypointType.Rockfall:
        return Icon(Icons.landscape, color: Colors.white, size: 30);  
      case WaypointType.RestrictedArea:
        return Icon(Icons.block, color: Colors.white, size: 30);
      default:
        return Icon(Icons.place, color: Colors.white, size: 30);
    }
  }

  List<WaypointType> _getWaypointTypesByCategory(WaypointCategory category) {
    switch (category) {
      case WaypointCategory.Natural:
        return WaypointTypeExtension.naturalWaypointRange.toList();
      case WaypointCategory.Informative:
        return WaypointTypeExtension.informativeWaypointRange.toList();
      case WaypointCategory.Warning:
        return WaypointTypeExtension.warningWaypointRange.toList();
      default:
        return [];
    }
  }

  Future<Map<String, String>?> _showLandmarkDetailsDialog() async {
    return showDialog<Map<String, String>>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text(
            'Add Landmark Details',
            style: TextStyle(color: Colors.white),
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
             
              TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 10),
               TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
             ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
            ),
               ElevatedButton(
            onPressed: () => Navigator.pop(context, {
              'name': nameController.text,
              'description': descriptionController.text,
            }),
            child: const Text('Save'),
          ),
          ]
        );
      },
    );
  }

 Future<void> _handleWaypointSelection(
    BuildContext context,
    WaypointType type,
    
    WidgetRef ref,
  ) async {
    final location = await LocationService.getCurrentLocation();
    if (location == null) return;

    final details = await _showLandmarkDetailsDialog();
    if (details == null) return;

    final waypoint = Waypoint(
      location: GeoPoint.fromLatLng(location, null),
      name: details['name'] ?? '',
      description: details['description']??'',
      type: type,
    );
   final routeService = ref.read(routeServiceProvider.notifier);

    routeService.addWaypoint(waypoint);
  }

void _showLandmarkDetailsBottomSheet(BuildContext parentContext , WidgetRef ref) {
    showModalBottomSheet(
      context: parentContext,
      backgroundColor: Colors.grey[900],
      shape:const  RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return LandmarkDetailsSheet(
          onCancel: () => Navigator.pop(context),
        
          onSave: (title, description, mediaFiles) async {
          final location = await LocationService.getCurrentLocation();
          if (location == null) return;

          final waypoint = Waypoint(
            location: GeoPoint.fromLatLng(location, null),
            name: title,
            description: description,
            type: _selectedType!,
          );

          final routeService = ref.read(routeServiceProvider.notifier);
          routeService.addWaypoint(waypoint);

          Navigator.pop(context);
          },
        );
      },
    );
  }
}

 
class LandmarkDetailsSheet extends StatefulWidget {
  final VoidCallback onCancel;
  final Function(String title, String description, List<dynamic> mediaFiles)
      onSave;

  const LandmarkDetailsSheet({
    Key? key,
    required this.onCancel,
    required this.onSave,
  }) : super(key: key);

  @override
  _LandmarkDetailsSheetState createState() => _LandmarkDetailsSheetState();
}

class _LandmarkDetailsSheetState extends State<LandmarkDetailsSheet> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  List<dynamic> _mediaFiles = []; // Placeholder for media files

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        const  Text(
            'Add Landmark Details',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
       const   SizedBox(height: 20),
           TextField(
            controller: _titleController,
            style: const TextStyle(color: Colors.white),
            decoration:const InputDecoration(
              labelText: 'Title',
              labelStyle: TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
        const  SizedBox(height: 20),
          TextField(
            controller: _descController,
            style:const TextStyle(color: Colors.white),
            decoration:const InputDecoration(
              labelText: 'Description',
              labelStyle: TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            maxLines: null, // Allows multi-line input
            keyboardType: TextInputType.multiline,
          ),
      const    SizedBox(height: 20),
      const    Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Media (Images/Videos)',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
   const       SizedBox(height: 10),
          Row(
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                onPressed: _pickMedia, // Placeholder method
                icon:const Icon(Icons.file_upload, color: Colors.white),
                label:const Text('Upload', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: widget.onCancel,
                child:const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                onPressed: () {
                  widget.onSave(
                    _titleController.text.trim(),
                    _descController.text.trim(),
                    _mediaFiles,
                  );
                },
                child:const Text('Save'),
              ),
            ],
          ),
        const  SizedBox(height: 20),
        ],
      ),
    );
  }

  void _pickMedia() {
    // Placeholder for picking media files
    // Integrate image_picker or file_picker here.
    // For demonstration, we just add a fake file name:
    setState(() {
      _mediaFiles.add('fake_media_file.png');
    });
  }
}
