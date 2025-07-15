import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motomeetfront/screens/create_event/create_event_viewmodel.dart';
import 'package:motomeetfront/models/event.dart';

class Step4EquipmentPublish extends ConsumerWidget {
  const Step4EquipmentPublish({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(createEventViewModelProvider.notifier);
    final state = ref.watch(createEventViewModelProvider);

    final requiredGear = state.event.requiredItems.where((item) => item.isRecommended == false).toList();
    final recommendedGear = state.event.requiredItems.where((item) => item.isRecommended == true).toList();

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Equipment Recommendations
        Text('Equipment Recommendations', style: const TextStyle(color: Color(0xFF374151), fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        _buildSectionHeader(context, 'Required Gear'),
        ...requiredGear.map((item) => _buildGearItem(context, item.itemName ?? '', isRequired: true, isChecked: true)),

        const SizedBox(height: 12),
        _buildSectionHeader(context, 'Recommended Gear'),
        ...recommendedGear.map((item) => _buildGearItem(context, item.itemName ?? '', isChecked: true)),
        
        const SizedBox(height: 16),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Add custom item...',
            hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
            ),
            suffixIcon: const Icon(Icons.add, color: Color(0xFF2563EB)),
          ),
          onFieldSubmitted: (value) {
            viewModel.addEventItem(EventItem(itemName: value, isRecommended: false));
          },
        ),
        const SizedBox(height: 24),

        // Safety Information
        Text('Safety Information', style: const TextStyle(color: Color(0xFF374151), fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: state.event.emergencyContact,
          decoration: InputDecoration(
            labelText: 'Emergency Contact',
            labelStyle: const TextStyle(color: Color(0xFF6B7280)),
            hintText: 'Name & phone number',
            hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
            ),
          ),
          onChanged: viewModel.setEmergencyContact,
        ),
        const SizedBox(height: 12),
        TextFormField(
          initialValue: state.event.safetyNotes,
          maxLines: 3,
          decoration: InputDecoration(
            labelText: 'Safety Notes',
            labelStyle: const TextStyle(color: Color(0xFF6B7280)),
            hintText: 'Add safety protocols or emergency procedures...',
            hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
            ),
          ),
          onChanged: viewModel.setSafetyNotes,
        ),
        const SizedBox(height: 24),

        // Final Review
        Text('Final Review', style: const TextStyle(color: Color(0xFF374151), fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  image: state.event.bannerImageUrl != null
                      ? DecorationImage(
                          image: NetworkImage(state.event.bannerImageUrl!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: state.event.bannerImageUrl == null 
                    ? const Center(child: Text('Banner Placeholder'))
                    : null,
              ),
              ListTile(
                title: Text(state.event.name ?? 'No Title', style: const TextStyle(color: Color(0xFF111827), fontSize: 16, fontWeight: FontWeight.w600)),
                subtitle: Text('${state.event.startDateTime?.toString() ?? 'No Date'}\n${state.event.route.value?.name ?? 'No Route'}', style: const TextStyle(color: Color(0xFF6B7280), fontSize: 14)),
                isThreeLine: true,
              ),
              const Divider(),
              _buildReviewRow(context, 'Basic Info', 'Title, type, date, time, location', () => viewModel.goToStep(0)),
              _buildReviewRow(context, 'Event Details', 'Description, visibility, participants', () => viewModel.goToStep(1)),
              _buildReviewRow(context, 'Route & Weather', 'Mountain Trail Loop, weather alerts', () => viewModel.goToStep(2)),
            ],
          ),
        ),
        const SizedBox(height: 24),
        
        // Social Sharing
        Text('Social Sharing', style: const TextStyle(color: Color(0xFF374151), fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildSocialButton('Facebook'),
            _buildSocialButton('Twitter'),
            _buildSocialButton('Instagram'),
          ],
        ),
        const SizedBox(height: 24),

        // Publish Buttons are in the main screen's bottom bar
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(title, style: const TextStyle(color: Color(0xFF374151), fontSize: 12, fontWeight: FontWeight.w500));
  }

  Widget _buildGearItem(BuildContext context, String name, {bool isRequired = false, bool isChecked = false}) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade300, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Checkbox(value: isChecked, onChanged: (val) {}),
        title: Text(name, style: const TextStyle(color: Color(0xFF111827), fontSize: 14)),
        trailing: isRequired 
            ? Chip(
                label: Text('required', style: TextStyle(color: Colors.red.shade900, fontSize: 12)),
                backgroundColor: Colors.red.shade100,
                labelStyle: TextStyle(color: Colors.red.shade900, fontSize: 12),
                padding: EdgeInsets.zero,
              )
            : null,
      ),
    );
  }

  Widget _buildReviewRow(BuildContext context, String title, String subtitle, VoidCallback onEdit) {
    return ListTile(
      title: Text(title, style: const TextStyle(color: Color(0xFF111827), fontSize: 14, fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: const TextStyle(color: Color(0xFF6B7280), fontSize: 14)),
      trailing: TextButton(onPressed: onEdit, child: const Text('Edit', style: TextStyle(color: Color(0xFF2563EB), fontSize: 14))),
    );
  }

  Widget _buildSocialButton(String platform) {
    return OutlinedButton(
      onPressed: () {},
      child: Text(platform, style: const TextStyle(color: Colors.black, fontSize: 14)),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.black,
        side: const BorderSide(color: Color(0xFFD1D5DB)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
} 