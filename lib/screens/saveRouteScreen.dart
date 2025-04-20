import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart'; 
import '../models/enum.dart';
import '../models/route.dart' as app_models;
import '../providers/route_creation_provider.dart';
 
class SaveRouteScreen extends ConsumerStatefulWidget {
  final app_models.Route route;
  final app_models.UserRoute? userRoute;

  const SaveRouteScreen({
    Key? key,
    required this.route,
    this.userRoute,
  }) : super(key: key);

  @override
  ConsumerState<SaveRouteScreen> createState() => _SaveRouteScreenState();
}

class _SaveRouteScreenState extends ConsumerState<SaveRouteScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  // State for Difficulty Level
  DifficultyLevelEnum? _selectedDifficulty = DifficultyLevelEnum.Easy;

  // State for isLoop
  bool _isLoop = false;

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
                      widget.userRoute?.durationMinutes != null 
                          ? _formatDuration(Duration(minutes: widget.userRoute!.durationMinutes!))
                          : 'Not available',
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.date_range),
                    title: const Text('Start Date'),
                    subtitle: Text(
                      widget.route.startDate != null
                          ? DateFormat('yyyy-MM-dd – kk:mm').format(widget.route.startDate!.toLocal())
                          : 'Not set',
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.date_range),
                    title: const Text('End Date'),
                    subtitle: Text(
                        widget.route.endDate != null
                            ? DateFormat('yyyy-MM-dd – kk:mm').format(widget.route.endDate!.toLocal())
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

  /// Builds the difficulty selector
  Widget _buildDifficultySelector() {
    return DropdownButtonFormField<DifficultyLevelEnum>(
      value: _selectedDifficulty,
      decoration: const InputDecoration(
        labelText: 'Difficulty Level',
        border: OutlineInputBorder(),
      ),
      items: DifficultyLevelEnum.values.map((DifficultyLevelEnum value) {
        return DropdownMenuItem<DifficultyLevelEnum>(
          value: value,
          child: Text(value.name),
        );
      }).toList(),
      onChanged: (DifficultyLevelEnum? newValue) {
        setState(() {
          _selectedDifficulty = newValue;
        });
      },
      validator: (value) => value == null ? 'Please select a difficulty' : null,
    );
  }

  /// Builds the isLoop toggle
  Widget _buildIsLoopToggle() {
    return SwitchListTile(
      title: const Text('Is this a loop route?'),
      value: _isLoop,
      onChanged: (bool value) {
        setState(() {
          _isLoop = value;
        });
      },
      secondary: const Icon(Icons.loop),
    );
  }

  /// Called when the user hits "Save Route"
  Future<void> _onSavePressed() async {
    if (!_formKey.currentState!.validate()) return;

    final routeNotifier = ref.read(routeCreationProvider.notifier);
    final difficulty = _selectedDifficulty != null 
        ? app_models.DifficultyLevel(level: _selectedDifficulty!.name) 
        : null;

    bool success = false;
    String successMessage = '';
    String errorMessage = '';

    // Determine if this is the initial finalization of a new route
    // A simple heuristic: base route length is null before first finalization
    bool isInitialFinalization = widget.route.length == null;

    try {
      if (isInitialFinalization) {
        // Finalize the BASE route (only done once)
        final finalizedRoute = await routeNotifier.finalizeBaseRoute(
          _nameController.text,
          _descriptionController.text.isNotEmpty ? _descriptionController.text : null,
          difficulty, // Difficulty set for the base route from first user
          _isLoop,    // isLoop set for the base route from first user
        );
        if (finalizedRoute != null) {
          success = true;
          successMessage = 'New route finalized and saved!';
        } else {
          errorMessage = 'Failed to finalize the new base route.';
        }
      } else {
        // Update the specific USER route's difficulty from this trip
        if (widget.userRoute?.id == null) {
          errorMessage = 'Cannot update difficulty: UserRoute ID is missing.';
        } else if (difficulty == null) {
           errorMessage = 'Cannot update difficulty: Difficulty level not selected.';
        } else {
           await routeNotifier.updateUserRouteDifficulty(
              widget.userRoute!.id!, 
              difficulty
           );
           success = true; // Assume success if no exception
           successMessage = 'Journey difficulty updated!';
           // Note: We might want more robust error handling from updateUserRouteDifficulty
        }
      }
    } catch (e) {
       errorMessage = 'An error occurred: $e';
       success = false;
    }

    // Show feedback
    if (!mounted) return;

    if (success) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Success'),
          content: Text(successMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // close dialog
                Navigator.of(context).pop(); // go back from SaveRouteScreen
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage.isNotEmpty ? errorMessage : 'An unknown error occurred.')),
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
              _buildDifficultySelector(),
              const SizedBox(height: 10),
              _buildIsLoopToggle(),
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
