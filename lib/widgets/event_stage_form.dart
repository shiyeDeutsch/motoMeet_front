import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motomeetfront/models/event.dart';
import 'package:motomeetfront/widgets/customTextFromField.dart';

class EventStageForm extends StatefulWidget {
  final EventStage? stage;
  final Function(EventStage) onSave;
  final DateTime startDate;
  final DateTime endDate;

  const EventStageForm({
    Key? key,
    this.stage,
    required this.onSave,
    required this.startDate,
    required this.endDate,
  }) : super(key: key);

  @override
  State<EventStageForm> createState() => _EventStageFormState();
}

class _EventStageFormState extends State<EventStageForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late DateTime _stageDate;
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;
  bool _hasEndTime = false;

  @override
  void initState() {
    super.initState();
    
    _titleController = TextEditingController(text: widget.stage?.title ?? '');
    _descriptionController = TextEditingController(text: widget.stage?.description ?? '');
    
    // Initialize date/time
    if (widget.stage?.stageStartTime != null) {
      _stageDate = widget.stage!.stageStartTime!;
      _startTime = TimeOfDay.fromDateTime(widget.stage!.stageStartTime!);
      
      if (widget.stage?.stageEndTime != null) {
        _endTime = TimeOfDay.fromDateTime(widget.stage!.stageEndTime!);
        _hasEndTime = true;
      } else {
        _endTime = _startTime.replacing(hour: _startTime.hour + 1);
      }
    } else {
      _stageDate = widget.startDate;
      _startTime = const TimeOfDay(hour: 9, minute: 0);
      _endTime = const TimeOfDay(hour: 10, minute: 0);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _stageDate,
      firstDate: widget.startDate,
      lastDate: widget.endDate,
    );
    if (picked != null && picked != _stageDate) {
      setState(() {
        _stageDate = picked;
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
        
        // If end time is earlier than start time, adjust it
        final startTimeInMinutes = _startTime.hour * 60 + _startTime.minute;
        final endTimeInMinutes = _endTime.hour * 60 + _endTime.minute;
        
        if (endTimeInMinutes <= startTimeInMinutes) {
          // Set end time to start time + 1 hour
          _endTime = TimeOfDay(
            hour: (_startTime.hour + 1) % 24,
            minute: _startTime.minute,
          );
        }
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

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    
    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 16.0,
        bottom: 16.0 + bottomInset,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.stage == null
                  ? 'Add Stage'
                  : 'Edit Stage',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              controller: _titleController,
              labelText: 'Stage Title',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a stage title';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              controller: _descriptionController,
              labelText: 'Description (Optional)',
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            
            // Date selection
            ListTile(
              title: const Text('Date'),
              subtitle: Text(DateFormat('EEE, MMM d, y').format(_stageDate)),
              trailing: const Icon(Icons.calendar_today),
              onTap: () => _selectDate(context),
            ),
            
            // Start time
            ListTile(
              title: const Text('Start Time'),
              subtitle: Text(_startTime.format(context)),
              trailing: const Icon(Icons.access_time),
              onTap: () => _selectStartTime(context),
            ),
            
            // End time
            SwitchListTile(
              title: const Text('Set End Time'),
              value: _hasEndTime,
              onChanged: (value) {
                setState(() {
                  _hasEndTime = value;
                });
              },
            ),
            
            if (_hasEndTime)
              ListTile(
                title: const Text('End Time'),
                subtitle: Text(_endTime.format(context)),
                trailing: const Icon(Icons.access_time),
                onTap: () => _selectEndTime(context),
                enabled: _hasEndTime,
              ),
            
            const SizedBox(height: 24),
            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final stageStartTime = _combineDateAndTime(_stageDate, _startTime);
                    final stageEndTime = _hasEndTime
                        ? _combineDateAndTime(_stageDate, _endTime)
                        : null;
                    
                    // Validate end time is after start time
                    if (stageEndTime != null && stageEndTime.isBefore(stageStartTime)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('End time must be after start time'),
                        ),
                      );
                      return;
                    }
                    
                    widget.onSave(
                      EventStage(
                        id: widget.stage?.id,
                        title: _titleController.text,
                        description: _descriptionController.text.isNotEmpty
                            ? _descriptionController.text
                            : null,
                        stageStartTime: stageStartTime,
                        stageEndTime: stageEndTime,
                      ),
                    );
                  }
                },
                child: Text(widget.stage == null ? 'Add Stage' : 'Update Stage'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
