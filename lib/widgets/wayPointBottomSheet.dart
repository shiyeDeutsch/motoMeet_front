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
    return Container(
      // רקע כהה לבוטום שיט
      color: Colors.black,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.6, // גובה מותאם
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // המחוון העליון
          _buildTopHandle(),
          // בורר הקטגוריות
          _buildCategorySelector(),
          Divider(color: Colors.grey),
          // רשימת סוגי הנקודות
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: WaypointCategory.values.map((category) {
          bool isSelected = _selectedCategory == category;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategory = category;
                _selectedType = null; // איפוס הבחירה בסוג בעת שינוי קטגוריה
              });
            },
            child: Column(
              children: [
                // עיגול עם אייקון מותאם
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
                  child: Center(
                    child: _getCategoryIcon(category, isSelected),
                  ),
                ),
                SizedBox(height: 1),
                // שם הקטגוריה
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
          );
        }).toList(),
      ),
    );
  }

  Widget _getCategoryIcon(WaypointCategory category, bool isSelected) {
    // החלף את האייקונים האלו באייקונים מותאמים אישית לפי הצורך
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
            crossAxisCount: 3, // מספר העמודות ברשת
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio:1.5, // יחס גובה-רוחב
          ),
          itemBuilder: (context, index) {
            WaypointType type = waypointTypes[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedType = type;
                });
                _handleWaypointSelection(
                  context,
                  type,
                
                );
              },
              child: Column(
                children: [
                  // עיגול עם אייקון מותאם
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
                  // שם הסוג
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
        ),
      ),
    );
  }

  Widget _getWaypointIcon(WaypointType type) {
    // החלף את האייקונים האלו באייקונים מותאמים אישית לפי הצורך
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
        return Icon(Icons.opacity, color: Colors.white, size: 30); // אין אייקון כזה, החלף לאייקון מתאים
      case WaypointType.MountainPeak:
        return Icon(Icons.terrain, color: Colors.white, size: 30);
      case WaypointType.Forest:
        return Icon(Icons.park, color: Colors.white, size: 30);
      case WaypointType.Meadow:
        return Icon(Icons.grass, color: Colors.white, size: 30); // אין אייקון כזה, החלף לאייקון מתאים
      case WaypointType.Cave:
        return Icon(Icons.dark_mode, color: Colors.white, size: 30); // אין אייקון כזה, החלף לאייקון מתאים
      case WaypointType.Valley:
        return Icon(Icons.forest, color: Colors.white, size: 30); // החלף לאייקון מתאים
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
        return Icon(Icons.fast_forward , color: Colors.white, size: 30); // אין אייקון כזה, החלף לאייקון מתאים
      case WaypointType.HighTide:
        return Icon(Icons.waves, color: Colors.white, size: 30);
      case WaypointType.WildlifeSighting:
        return Icon(Icons.pets, color: Colors.white, size: 30);
      case WaypointType.FloodingArea:
        return Icon(Icons.water_damage, color: Colors.white, size: 30); // אין אייקון כזה, החלף לאייקון מתאים
      case WaypointType.Rockfall:
        return Icon(Icons.landscape, color: Colors.white, size: 30); // אין אייקון כזה, החלף לאייקון מתאים
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

  void _showLandmarkDetailsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text(
            'Add Landmark Details',
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // שדה שם
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
              // שדה תיאור
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
              // ניתן להוסיף שדות נוספים לפי הצורך
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
    
    
  ) async {
    final location = await LocationService.getCurrentLocation();
    if (location == null) return;

    final details = await _showWaypointDetailsDialog(context);
    if (details == null) return;

    final waypoint = Waypoint(
      location: GeoPoint.fromLatLng(location, null),
      name: details['name'],
      description: details['description'],
      type: type,
    );
   final routeService = ref.read(routeServiceProvider.notifier);

    routeService.addWaypoint(waypoint);
  }


}

 
