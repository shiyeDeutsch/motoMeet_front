import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motomeetfront/models/enum.dart';
import 'package:motomeetfront/screens/create_event/create_event_viewmodel.dart';

class Step2EventDetails extends ConsumerWidget {
  const Step2EventDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(createEventViewModelProvider.notifier);
    final state = ref.watch(createEventViewModelProvider);

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Description
        Text('Description', style: const TextStyle(color: Color(0xFF374151), fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        TextFormField(
          initialValue: state.event.description,
          decoration: InputDecoration(
            hintText: 'What should participants know about this event?',
            hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
            ),
          ),
          maxLines: 5,
          onChanged: viewModel.setDescription,
        ),
        const SizedBox(height: 16),

        // Event Visibility
        Text('Event Visibility', style: const TextStyle(color: Color(0xFF374151), fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        ...EventVisibility.values.map((visibility) {
          return _buildVisibilityCard(
            context,
            title: visibility.name,
            subtitle: _getSubtitleForVisibility(visibility),
            isSelected: state.event.visibility == visibility,
            onTap: () => viewModel.setVisibility(visibility),
          );
        }).toList(),
        const SizedBox(height: 24),
        
        // Maximum Participants
        Text('Maximum Participants', style: const TextStyle(color: Color(0xFF374151), fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        Text('Capacity: ${state.event.maxParticipants ?? 1}', style: const TextStyle(color: Color(0xFF4B5563), fontSize: 14)),
        Slider(
          value: (state.event.maxParticipants ?? 1).toDouble(),
          min: 1,
          max: 100,
          divisions: 99,
          label: (state.event.maxParticipants ?? 1).toString(),
          onChanged: (value) => viewModel.setMaxParticipants(value.toInt()),
          activeColor: const Color(0xFF2563EB),
          inactiveColor: const Color(0xFFE5E7EB),
        ),
        const SizedBox(height: 16),

        // Experience Level
        Text('Experience Level Required', style: const TextStyle(color: Color(0xFF374151), fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        DropdownButtonFormField<ExperienceLevel>(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
            ),
          ),
          value: state.event.experienceLevel,
          items: ExperienceLevel.values
              .map((label) => DropdownMenuItem(
                    child: Text(label.name),
                    value: label,
                  ))
              .toList(),
          onChanged: (value) {
            if (value != null) {
              viewModel.setExperienceLevel(value);
            }
          },
        ),
        const SizedBox(height: 16),

        // Group Settings
        Text('Group Settings', style: const TextStyle(color: Color(0xFF374151), fontSize: 14, fontWeight: FontWeight.w500)),
        SwitchListTile(
          title: const Text('Allow waitlist', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
          subtitle: const Text('Let people join a waitlist when full', style: TextStyle(color: Color(0xFF6B7280), fontSize: 12)),
          value: state.event.allowWaitlist ?? false,
          onChanged: viewModel.setAllowWaitlist,
          activeColor: const Color(0xFF2563EB),
        ),
        SwitchListTile(
          title: const Text('Auto-approve participants', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
          subtitle: const Text('Automatically approve join requests', style: TextStyle(color: Color(0xFF6B7280), fontSize: 12)),
          value: !(state.event.requiresApproval ?? false),
          onChanged: viewModel.setAutoApprove,
          activeColor: const Color(0xFF2563EB),
        ),
        const SizedBox(height: 16),

        // Invite Participants
        Text('Invite Participants', style: const TextStyle(color: Color(0xFF374151), fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Search for friends',
            hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Add invited friends list here
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.link),
          label: const Text('Invite via link'),
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF374151),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            side: const BorderSide(color: Color(0xFFD1D5DB)),
          ),
        ),
      ],
    );
  }

  String _getSubtitleForVisibility(EventVisibility visibility) {
    switch (visibility) {
      case EventVisibility.Public:
        return 'Anyone can join';
      case EventVisibility.Private:
        return 'Only invited participants';
      case EventVisibility.FriendsOnly:
        return 'Only connections can join';
    }
  }

  Widget _buildVisibilityCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    bool isSelected = false,
    required VoidCallback onTap,
  }) {
    final bgColor = isSelected ? const Color(0xFFEFF6FF) : Colors.white;
    final borderColor = isSelected ? const Color(0xFF3B82F6) : const Color(0xFFD1D5DB);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 4),
      color: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: borderColor),
      ),
      child: ListTile(
        onTap: onTap,
        leading: isSelected
            ? const Icon(Icons.check_circle, color: Color(0xFF3B82F6))
            : const Icon(Icons.radio_button_unchecked, color: Color(0xFFD1D5DB)),
        title: Text(title, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
        subtitle: Text(subtitle, style: const TextStyle(color: Color(0xFF6B7280), fontSize: 12)),
      ),
    );
  }
} 