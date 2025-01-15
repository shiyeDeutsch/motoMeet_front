import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart'; 
import '../models/enum.dart';
import '../models/route.dart';
import '../services/routeService.dart';

class SaveRouteScreen extends StatefulWidget {
  final NewRoute route;

  const SaveRouteScreen({
    Key? key,
    required this.route,
  }) : super(key: key);

  @override
  State<SaveRouteScreen> createState() => _SaveRouteScreenState();
}

class _SaveRouteScreenState extends State<SaveRouteScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  final _routeService = GetIt.I<RouteService>();

  // List of all possible tags
  final List<TagEnum> _allTags = TagEnum.values;
  // The user's current selection
  final Set<TagEnum> _selectedTags = {};

  @override
  void initState() {
    super.initState();
    // Prepopulate fields with existing data if any
    _nameController = TextEditingController(text: widget.route.name);
    _descriptionController = TextEditingController(
      text: widget.route.description ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  /// Toggles a tag in the set
  void _toggleTag(TagEnum tag) {
    setState(() {
      _selectedTags.contains(tag)
          ? _selectedTags.remove(tag)
          : _selectedTags.add(tag);
    });
  }

  /// Format a Duration (e.g., 2h 05m)
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    return '${hours}h ${minutes}m';
  }

  /// Builds the entire form (name, description, route details)
  Widget _buildForm() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Route Name
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Route Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a name for the route';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Description
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              // Expandable route info
              ExpansionTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('Route Details'),
                children: [
                  ListTile(
                    leading: const Icon(Icons.timer),
                    title: const Text('Duration'),
                    subtitle: Text(
                      _formatDuration(widget.route.routeDuration ?? Duration.zero),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.date_range),
                    title: const Text('Start Date'),
                    subtitle: Text(
                      DateFormat('yyyy-MM-dd – kk:mm')
                          .format(widget.route.startDate.toLocal()),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.date_range),
                    title: const Text('End Date'),
                    subtitle: Text(
                        widget.route.endDate != null
                            ? DateFormat('yyyy-MM-dd – kk:mm')
                                .format(widget.route.endDate!.toLocal())
                            : 'Not set'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the tag picker row
  Widget _buildTagPicker() {
    return SizedBox(
      height: 50.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _allTags.length,
        itemBuilder: (context, index) {
          final tag = _allTags[index];
          final isSelected = _selectedTags.contains(tag);
          return GestureDetector(
            onTap: () => _toggleTag(tag),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.grey[300],
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Center(
                child: Text(
                  tag.name,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Called when the user hits "Save Route"
  Future<void> _onSavePressed() async {
    if (!_formKey.currentState!.validate()) return;

    // Attempt to save the route
    final newRoute = await _routeService.saveRoute(
      _nameController.text,
      _descriptionController.text.isNotEmpty
          ? _descriptionController.text
          : null,
      _selectedTags.isNotEmpty ? _selectedTags.toList() : null,
    );

    if (newRoute != null) {
      // Show a success dialog
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Route Saved'),
          content: const Text('Your route has been successfully saved.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // close dialog
                Navigator.of(context).pop(); // go back to previous screen
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // Optionally handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save the route')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Save Your Route'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildForm(),
              const SizedBox(height: 20),
              _buildTagPicker(),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _onSavePressed,
                icon: const Icon(Icons.save),
                label: const Text('Save Route'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
