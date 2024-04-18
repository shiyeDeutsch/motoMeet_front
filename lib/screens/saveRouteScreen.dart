import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart'; // Ensure this is added for date formatting
import 'package:motomeetfront/services/routeService.dart';
import '../models/enum.dart';
import '../models/route.dart';

class SaveRouteScreen extends StatefulWidget {
  final NewRoute route;

  const SaveRouteScreen({super.key, required this.route});

  @override
  _SaveRouteScreenState createState() => _SaveRouteScreenState();
}

class _SaveRouteScreenState extends State<SaveRouteScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  var routeService = GetIt.I<RouteService>();
  final List<TagEnum> tagsIds = TagEnum.values.toList();

  // Tracks selected tags
  final Set<TagEnum> _selectedTags = Set<TagEnum>();

  void _toggleTag(TagEnum tag) {
    setState(() {
      if (_selectedTags.contains(tag)) {
        _selectedTags.remove(tag);
      } else {
        _selectedTags.add(tag);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.route.name);
    _descriptionController =
        TextEditingController(text: widget.route.description ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(duration.inHours)}h ${twoDigits(duration.inMinutes.remainder(60))}m";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Save Your Route'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Route Name',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a name for the route';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                            labelText: 'Description',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 3,
                        ),
                        const SizedBox(height: 20),
                        ExpansionTile(
                          leading: const Icon(Icons.info_outline),
                          title: const Text('Route Details'),
                          children: <Widget>[
                            ListTile(
                              leading: const Icon(Icons.timer),
                              title: const Text('Duration'),
                              subtitle:
                                  Text(formatDuration(widget.route.duration)),
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
                              subtitle: Text(widget.route.endDate != null
                                  ? DateFormat('yyyy-MM-dd – kk:mm')
                                      .format(widget.route.endDate!.toLocal())
                                  : 'Not set'),
                            ),
                            // Implement other details as needed
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              tagPicker (),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    var createdRoute = await routeService.saveRoute(
                        _nameController.text,
                        _descriptionController.text.isNotEmpty
                            ? _descriptionController.text
                            : null,
                        _selectedTags.isNotEmpty
                            ? _selectedTags.toList()
                            : null);
                    if (createdRoute != null) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Route Saved'),
                          content: const Text(
                              'Your route has been successfully saved.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  }
                },
                icon: Icon(Icons.save),
                label: Text('Save Route'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ScrollController controller = ScrollController();
  Widget tagPicker() {
    return Container(
      height: 50.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tagsIds.length,
        itemBuilder: (context, index) {
          final tag = tagsIds[index];
          final isSelected = _selectedTags.contains(tag);
          return GestureDetector(
            onTap: () => _toggleTag(tag),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              margin: EdgeInsets.symmetric(horizontal: 4.0),
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
}
