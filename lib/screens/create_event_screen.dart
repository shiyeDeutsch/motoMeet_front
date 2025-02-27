import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:motomeetfront/models/event.dart';
import 'package:motomeetfront/providers/create_event_provider.dart';
import 'package:motomeetfront/widgets/ExpandablePanel.dart';
import 'package:motomeetfront/widgets/customTextFromField.dart';
import 'package:motomeetfront/widgets/dialogs/confirmation_dialog.dart';
import 'package:motomeetfront/widgets/event_item_form.dart';
import 'package:motomeetfront/widgets/event_stage_form.dart';
import 'package:motomeetfront/widgets/loading_indicator.dart';

class CreateEventScreen extends ConsumerStatefulWidget {
  final Event? eventToEdit;

  const CreateEventScreen({Key? key, this.eventToEdit}) : super(key: key);

  @override
  ConsumerState<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends ConsumerState<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late DateTime _startDate;
  late TimeOfDay _startTime;
  late DateTime _endDate;
  late TimeOfDay _endTime;
  bool _isPublic = true;
  bool _requiresApproval = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    
    // Initialize with existing event data if editing
    final event = widget.eventToEdit;
    
    _nameController = TextEditingController(text: event?.name ?? '');
    _descriptionController = TextEditingController(text: event?.description ?? '');
    
    // Initialize dates
    final now = DateTime.now();
    final tomorrow = now.add(const Duration(days: 1));
    
    if (event != null && event.startDateTime != null) {
      _startDate = event.startDateTime!;
      _startTime = TimeOfDay.fromDateTime(event.startDateTime!);
    } else {
      _startDate = tomorrow;
      _startTime = const TimeOfDay(hour: 9, minute: 0);
    }
    
    if (event != null && event.endDateTime != null) {
      _endDate = event.endDateTime!;
      _endTime = TimeOfDay.fromDateTime(event.endDateTime!);
    } else {
      _endDate = tomorrow;
      _endTime = const TimeOfDay(hour: 17, minute: 0);
    }
    
    _isPublic = event?.isPublic ?? true;
    _requiresApproval = event?.requiresApproval ?? false;
    
    // Initialize provider with existing event if editing
    if (event != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(createEventProvider.notifier).initializeWithEvent(event);
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
        if (_endDate.isBefore(_startDate)) {
          _endDate = _startDate;
        }
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _startTime,
    );
    if (picked != null && picked != _startTime) {
      setState(() {
        _startTime = picked;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: _startDate,
      lastDate: _startDate.add(const Duration(days: 365)),
    );
    if (picked != null && picked != _endDate) {
      setState(() {
        _endDate = picked;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _endTime,
    );
    if (picked != null && picked != _endTime) {
      setState(() {
        _endTime = picked;
      });
    }
  }

  DateTime _combineDateAndTime(DateTime date, TimeOfDay time) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }

  Future<void> _saveEvent() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Check if end date/time is after start date/time
    final startDateTime = _combineDateAndTime(_startDate, _startTime);
    final endDateTime = _combineDateAndTime(_endDate, _endTime);
    
    if (endDateTime.isBefore(startDateTime)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('End time must be after start time')),
      );
      return;
    }

    // Prepare event data
    setState(() {
      _isLoading = true;
    });

    try {
      final notifier = ref.read(createEventProvider.notifier);
      
      // Update event details
      notifier.updateEventDetails(
        name: _nameController.text,
        description: _descriptionController.text,
        isPublic: _isPublic,
        requiresApproval: _requiresApproval,
        startDateTime: startDateTime,
        endDateTime: endDateTime,
      );
      
      // Save event
      final result = await notifier.saveEvent();
      
      if (mounted) {
        if (result) {
          Navigator.of(context).pop(true); // Success
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to save event. Please try again.')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final createEventState = ref.watch(createEventProvider);
    final isEditing = widget.eventToEdit != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Event' : 'Create Event'),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _saveEvent,
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('SAVE'),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: LoadingIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Basic Event Details
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Basic Details',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              CustomTextFormField(
                                controller: _nameController,
                                labelText: 'Event Name',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter an event name';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              CustomTextFormField(
                                controller: _descriptionController,
                                labelText: 'Description',
                                maxLines: 5,
                              ),
                              const SizedBox(height: 16),
                              // Event privacy settings
                              SwitchListTile(
                                title: const Text('Public Event'),
                                subtitle: const Text(
                                  'Public events are visible to everyone',
                                ),
                                value: _isPublic,
                                onChanged: (value) {
                                  setState(() {
                                    _isPublic = value;
                                  });
                                },
                              ),
                              SwitchListTile(
                                title: const Text('Require Approval'),
                                subtitle: const Text(
                                  'Participants need approval to join',
                                ),
                                value: _requiresApproval,
                                onChanged: (value) {
                                  setState(() {
                                    _requiresApproval = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Date and Time Selection
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Date and Time',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              
                              // Start Date and Time
                              const Text(
                                'Start',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      title: const Text('Date'),
                                      subtitle: Text(
                                        DateFormat('EEE, MMM d, y')
                                            .format(_startDate),
                                      ),
                                      onTap: () => _selectStartDate(context),
                                      trailing: const Icon(Icons.calendar_today),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      title: const Text('Time'),
                                      subtitle: Text(_startTime.format(context)),
                                      onTap: () => _selectStartTime(context),
                                      trailing: const Icon(Icons.access_time),
                                    ),
                                  ),
                                ],
                              ),
                              
                              const Divider(),
                              
                              // End Date and Time
                              const Text(
                                'End',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      title: const Text('Date'),
                                      subtitle: Text(
                                        DateFormat('EEE, MMM d, y')
                                            .format(_endDate),
                                      ),
                                      onTap: () => _selectEndDate(context),
                                      trailing: const Icon(Icons.calendar_today),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      title: const Text('Time'),
                                      subtitle: Text(_endTime.format(context)),
                                      onTap: () => _selectEndTime(context),
                                      trailing: const Icon(Icons.access_time),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Event Stages
                      ExpandablePanel(
                        title: 'Event Stages',
                        subtitle: 'Define the schedule for your event',
                        child: Column(
                          children: [
                            // List existing stages
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: createEventState.stages.length,
                              itemBuilder: (context, index) {
                                final stage = createEventState.stages[index];
                                return ListTile(
                                  title: Text(stage.title ?? 'Unnamed Stage'),
                                  subtitle: Text(
                                    stage.stageStartTime != null
                                        ? DateFormat('MMM d, y - h:mm a').format(stage.stageStartTime!)
                                        : 'No time set',
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () {
                                          _showStageForm(context, stage, index);
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          ref.read(createEventProvider.notifier)
                                              .removeStage(index);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            
                            // Add button
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton.icon(
                                onPressed: () => _showStageForm(context, null),
                                icon: const Icon(Icons.add),
                                label: const Text('Add Stage'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Required Items
                      ExpandablePanel(
                        title: 'Required Equipment',
                        subtitle: 'List items that participants should bring',
                        child: Column(
                          children: [
                            // List existing items
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: createEventState.requiredItems.length,
                              itemBuilder: (context, index) {
                                final item = createEventState.requiredItems[index];
                                return ListTile(
                                  title: Text(item.itemName ?? 'Unnamed Item'),
                                  subtitle: item.description != null && item.description!.isNotEmpty
                                      ? Text(item.description!)
                                      : null,
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () {
                                          _showItemForm(context, item, index);
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          ref.read(createEventProvider.notifier)
                                              .removeRequiredItem(index);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            
                            // Add button
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton.icon(
                                onPressed: () => _showItemForm(context, null),
                                icon: const Icon(Icons.add),
                                label: const Text('Add Item'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Activities
                      ExpandablePanel(
                        title: 'Activities',
                        subtitle: 'Add activities that will take place',
                        child: Column(
                          children: [
                            // List existing activities
                            if (createEventState.activities.isEmpty)
                              const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text('No activities added yet'),
                              ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: createEventState.activities.length,
                              itemBuilder: (context, index) {
                                final activity = createEventState.activities[index];
                                return ListTile(
                                  title: Text(activity.activityType?.name ?? 'Unnamed Activity'),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      ref.read(createEventProvider.notifier)
                                          .removeActivity(index);
                                    },
                                  ),
                                );
                              },
                            ),
                            
                            // Add button
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton.icon(
                                onPressed: _showActivitySelector,
                                icon: const Icon(Icons.add),
                                label: const Text('Add Activity'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Submit button
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: _isLoading ? null : _saveEvent,
                          child: _isLoading
                              ? const LoadingIndicator(size: 20)
                              : Text(isEditing ? 'Update Event' : 'Create Event'),
                        ),
                      ),
                      
                      if (isEditing) ...[
                        const SizedBox(height: 16),
                        
                        // Delete button
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: _isLoading
                                ? null
                                : () async {
                                    final result = await showDialog<bool>(
                                      context: context,
                                      builder: (context) => const ConfirmationDialog(
                                        title: 'Delete Event',
                                        content: 'Are you sure you want to delete this event? This cannot be undone.',
                                      ),
                                    );
                                    
                                    if (result == true) {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      
                                      try {
                                        final success = await ref.read(createEventProvider.notifier)
                                            .deleteEvent();
                                        
                                        if (mounted) {
                                          if (success) {
                                            Navigator.of(context).pop(true);
                                          } else {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('Failed to delete event')),
                                            );
                                          }
                                        }
                                      } finally {
                                        if (mounted) {
                                          setState(() {
                                            _isLoading = false;
                                          });
                                        }
                                      }
                                    }
                                  },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.red,
                            ),
                            child: const Text('Delete Event'),
                          ),
                        ),
                      ],
                      
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  void _showStageForm(BuildContext context, EventStage? stage, [int? index]) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => EventStageForm(
        stage: stage,
        onSave: (updatedStage) {
          if (index != null) {
            ref.read(createEventProvider.notifier).updateStage(index, updatedStage);
          } else {
            ref.read(createEventProvider.notifier).addStage(updatedStage);
          }
          Navigator.pop(context);
        },
        startDate: _startDate,
        endDate: _endDate,
      ),
    );
  }

  void _showItemForm(BuildContext context, RequiredItem? item, [int? index]) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => EventItemForm(
        item: item,
        onSave: (updatedItem) {
          if (index != null) {
            ref.read(createEventProvider.notifier).updateRequiredItem(index, updatedItem);
          } else {
            ref.read(createEventProvider.notifier).addRequiredItem(updatedItem);
          }
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showActivitySelector() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Activities',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Consumer(
                  builder: (context, ref, child) {
                    final activityTypes = ref.watch(activityTypesProvider);
                    
                    return activityTypes.when(
                      data: (types) => ListView.builder(
                        itemCount: types.length,
                        itemBuilder: (context, index) {
                          final type = types[index];
                          return ListTile(
                            title: Text(type.name ?? 'Unnamed'),
                            onTap: () {
                              ref.read(createEventProvider.notifier).addActivity(
                                EventActivity(activityType: type),
                              );
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                      loading: () => const Center(child: LoadingIndicator()),
                      error: (error, _) => Center(
                        child: Text('Error: $error'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}