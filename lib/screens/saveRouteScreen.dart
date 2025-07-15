import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  DifficultyLevelEnum _selectedDifficulty = DifficultyLevelEnum.Easy;
  bool _isLoop = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.route.name);
    _descriptionController =
        TextEditingController(text: widget.route.description ?? '');
    _isLoop = widget.route.isLoop ?? false;
    _selectedDifficulty = widget.route.difficultyLevel?.level != null
        ? DifficultyLevelEnum.values.firstWhere(
            (e) => e.name == widget.route.difficultyLevel!.level,
            orElse: () => DifficultyLevelEnum.Easy)
        : DifficultyLevelEnum.Easy;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    return '${hours}h ${minutes}m';
  }

  Future<void> _onSavePressed() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a name for your route'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final routeNotifier = ref.read(routeCreationProvider.notifier);
    final difficulty = app_models.DifficultyLevel(level: _selectedDifficulty.name);

    bool success = false;
    String successMessage = '';
    String errorMessage = '';

    bool isInitialFinalization = widget.route.length == null;

    try {
      if (isInitialFinalization) {
        final finalizedRoute = await routeNotifier.finalizeBaseRoute(
          _nameController.text.trim(),
          _descriptionController.text.trim().isNotEmpty
              ? _descriptionController.text.trim()
              : null,
          difficulty,
          _isLoop,
        );
        if (finalizedRoute != null) {
          success = true;
          successMessage = 'New route finalized and saved!';
        } else {
          errorMessage = 'Failed to finalize the new base route.';
        }
      } else {
        if (widget.userRoute?.id == null) {
          errorMessage = 'Cannot update difficulty: UserRoute ID is missing.';
        } else {
          await routeNotifier.updateUserRouteDifficulty(
              widget.userRoute!.id!, difficulty);
          success = true;
          successMessage = 'Journey difficulty updated!';
        }
      }
    } catch (e) {
      errorMessage = 'An error occurred: $e';
      success = false;
    }

    setState(() {
      _isSaving = false;
    });

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
        SnackBar(
            content: Text(errorMessage.isNotEmpty
                ? errorMessage
                : 'An unknown error occurred.'),
            backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 300,
            child: Image.network(
              'https://static.motiffcontent.com/private/resource/image/19675f812cf032f-94571d58-11a0-485e-b893-8394b5b1f45b.png',
              fit: BoxFit.cover,
            ),
          ),
          // Back Button
          Positioned(
            top: 56,
            left: 20,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFF1F2937)),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),

          // Main Content
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 250.0), // Adjust to reveal image
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Name your adventure',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF212121),
                          ),
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            hintText: 'E.g., Morning Forest Trail',
                            hintStyle: TextStyle(color: Color(0xFF9CA3AF)),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Color(0xFFD1D5DB)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a name for the route';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          controller: _descriptionController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: 'What made this route special?',
                            fillColor: const Color(0xFFF5F5F5),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Text('Difficulty',
                            style: const TextStyle(
                                color: Color(0xFF4B5563), fontSize: 14)),
                        const SizedBox(height: 8),
                        _buildDifficultySelector(),
                        const SizedBox(height: 24),
                        _buildIsLoopToggle(),
                        const SizedBox(height: 26),
                        _buildRouteStatistics(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          // Save Button
          Positioned(
            bottom: 32,
            right: 24,
            child: FloatingActionButton(
              onPressed: _isSaving ? null : _onSavePressed,
              backgroundColor: _isSaving ? Colors.grey : const Color(0xFF2196F3),
              child: _isSaving 
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Icon(Icons.check, color: Colors.white, size: 32),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDifficultySelector() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(9999),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: DifficultyLevelEnum.values.map((level) {
          bool isSelected = _selectedDifficulty == level;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDifficulty = level;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF2196F3) : Colors.transparent,
                borderRadius: BorderRadius.circular(9999),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        )
                      ]
                    : [],
              ),
              child: Text(
                level.name,
                style: TextStyle(
                  color: isSelected ? Colors.white : const Color(0xFF374151),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildIsLoopToggle() {
    return Row(
      children: [
        const Icon(Icons.loop, color: Color(0xFF2196F3)),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Loop Route',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              Text('This route ends at the starting point',
                  style: TextStyle(fontSize: 14, color: Color(0xFF4B5563))),
            ],
          ),
        ),
        Switch(
          value: _isLoop,
          onChanged: (value) {
            setState(() {
              _isLoop = value;
            });
          },
          activeColor: const Color(0xFF2196F3),
        ),
      ],
    );
  }
  
  Widget _buildRouteStatistics() {
    return ExpansionTile(
      title: const Text('Route Statistics', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
      children: [
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 2.5,
          children: [
             _buildStatItem(Icons.timer_outlined, 'Duration', widget.userRoute?.durationMinutes != null ? _formatDuration(Duration(minutes: widget.userRoute!.durationMinutes!)) : 'N/A'),
             _buildStatItem(Icons.directions_run, 'Distance', widget.route.length != null ? '${(widget.route.length! / 1000).toStringAsFixed(1)} km' : 'N/A'),
             _buildStatItem(Icons.access_time, 'Start', widget.route.startDate != null ? DateFormat('kk:mm').format(widget.route.startDate!.toLocal()) : 'N/A'),
             _buildStatItem(Icons.access_time_filled, 'End', widget.route.endDate != null ? DateFormat('kk:mm').format(widget.route.endDate!.toLocal()) : 'N/A'),
             _buildStatItem(Icons.arrow_upward, 'Elevation Gain', '${widget.route.elevationGain?.toStringAsFixed(0) ?? 'N/A'} m'),
             _buildStatItem(Icons.speed, 'Avg. Pace', '10:15/km'), // Placeholder
          ],
        )
      ],
    );
  }

  Widget _buildStatItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Icon(icon, color: const Color(0xFF2196F3), size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF4B5563))),
              Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            ],
          )
        ],
      ),
    );
  }
}
