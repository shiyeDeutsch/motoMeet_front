import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motomeetfront/models/enum.dart';
import 'package:motomeetfront/screens/create_event/create_event_viewmodel.dart';

class Step1BasicInfo extends ConsumerWidget {
  const Step1BasicInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(createEventViewModelProvider.notifier);
    final state = ref.watch(createEventViewModelProvider);

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Event Title
        Text('Event Title', style: const TextStyle(color: Color(0xFF374151), fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        TextFormField(
          initialValue: state.event.name,
          decoration: InputDecoration(
            hintText: 'Enter event name',
            hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
            ),
          ),
          onChanged: viewModel.setEventTitle,
        ),
        const SizedBox(height: 16),

        // Event Type
        Text('Event Type', style: const TextStyle(color: Color(0xFF374151), fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: EventType.values.map((type) {
            return _buildEventTypeCard(
              context,
              icon: _getIconForEventType(type),
              label: type.name,
              isSelected: state.event.eventType == type,
              onTap: () => viewModel.setEventType(type),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),

        // Date & Time
        Text('Date & Time', style: const TextStyle(color: Color(0xFF374151), fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                // controller to show formatted date
                decoration: InputDecoration(
                  hintText: 'Select Date',
                  hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
                  ),
                  prefixIcon: const Icon(Icons.calendar_today, color: Color(0xFF9CA3AF)),
                ),
                readOnly: true,
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: state.event.startDateTime ?? DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (date != null) {
                    viewModel.setStartDate(date);
                  }
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                // controller to show formatted time
                decoration: InputDecoration(
                  hintText: 'Select Time',
                  hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
                  ),
                  prefixIcon: const Icon(Icons.access_time, color: Color(0xFF9CA3AF)),
                ),
                readOnly: true,
                onTap: () async {
                   final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(state.event.startDateTime ?? DateTime.now()),
                  );
                  if (time != null) {
                    final now = DateTime.now();
                    viewModel.setStartTime(DateTime(now.year, now.month, now.day, time.hour, time.minute));
                  }
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Duration
        Text('Duration', style: const TextStyle(color: Color(0xFF374151), fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'hours',
                  labelStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  // Handle duration change
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'minutes',
                  labelStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  // Handle duration change
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Location
        Text('Location', style: const TextStyle(color: Color(0xFF374151), fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        TextFormField(
          initialValue: state.event.locationName,
          decoration: InputDecoration(
            hintText: 'Search or enter address',
            hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
            ),
            prefixIcon: const Icon(Icons.location_on, color: Color(0xFF9CA3AF)),
          ),
          onChanged: viewModel.setLocation,
        ),
        const SizedBox(height: 16),
        
        // Banner Image
        Text('Banner Image', style: const TextStyle(color: Color(0xFF374151), fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        // TODO: Replace with a dashed border
        GestureDetector(
          onTap: () {
            // Handle image picking
          },
          child: Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFD1D5DB)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_upload_outlined, color: Color(0xFF9CA3AF)),
                  SizedBox(height: 8),
                  Text('Upload event banner image', style: TextStyle(color: Color(0xFF9CA3AF))),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  IconData _getIconForEventType(EventType type) {
    switch (type) {
      case EventType.Ride:
        return Icons.motorcycle;
      case EventType.Hike:
        return Icons.hiking;
      case EventType.Meeting:
        return Icons.people;
      case EventType.Race:
        return Icons.flag;
    }
  }

  Widget _buildEventTypeCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    bool isSelected = false,
    required VoidCallback onTap,
  }) {
    final color = isSelected ? const Color(0xFF3B82F6) : const Color(0xFF4B5563);
    final bgColor = isSelected ? const Color(0xFFEFF6FF) : Colors.white;
    final borderColor = isSelected ? const Color(0xFF3B82F6) : const Color(0xFFD1D5DB);

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 0,
          color: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: borderColor),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 25),
            child: Column(
              children: [
                Icon(icon, color: color),
                const SizedBox(height: 4),
                Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 