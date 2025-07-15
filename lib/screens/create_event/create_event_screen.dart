import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motomeetfront/models/event.dart';
import 'package:motomeetfront/screens/create_event/create_event_viewmodel.dart';
import 'package:motomeetfront/screens/create_event/steps/step1_basic_info.dart';
import 'package:motomeetfront/screens/create_event/steps/step2_event_details.dart';
import 'package:motomeetfront/screens/create_event/steps/step3_route_weather.dart';
import 'package:motomeetfront/screens/create_event/steps/step4_equipment_publish.dart';

class CreateEventScreen extends ConsumerStatefulWidget {
  final Event? eventToEdit;

  const CreateEventScreen({Key? key, this.eventToEdit}) : super(key: key);

  @override
  ConsumerState<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends ConsumerState<CreateEventScreen> {
  final PageController _pageController = PageController();
  bool _isSaving = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(createEventViewModelProvider.notifier);
    final state = ref.watch(createEventViewModelProvider);
    final isEditing = widget.eventToEdit != null;

    ref.listen<int>(
      createEventViewModelProvider.select((s) => s.currentStep),
      (previous, next) {
        if (next != _pageController.page?.round()) {
          _pageController.animateToPage(
            next,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        }
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Custom Header
            Container(
              padding: const EdgeInsets.fromLTRB(24, 18, 24, 19),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      if (state.currentStep == 0) {
                        Navigator.of(context).pop();
                      } else {
                        viewModel.previousStep();
                      }
                    },
                  ),
                  Text(
                    isEditing ? 'Edit Event' : 'Create Event',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            // Step Indicator
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 20.0),
              child: Row(
                children: [
                  Text(
                    'Step ${state.currentStep + 1} of 4',
                    style: const TextStyle(color: Color(0xFF4B5563)),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 140,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(9999),
                      child: LinearProgressIndicator(
                        value: (state.currentStep + 1) / 4,
                        backgroundColor: const Color(0xFFE5E7EB),
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2563EB)),
                        minHeight: 4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(), // Disable swipe
                children: const [
                  Step1BasicInfo(),
                  Step2EventDetails(),
                  Step3RouteWeather(),
                  Step4EquipmentPublish(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 17, 16, 28),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Color(0xFFE5E7EB), width: 1.0),
          ),
        ),
        child: ElevatedButton(
          onPressed: () async {
            if (_isSaving) return;

            if (state.currentStep == 3) {
              setState(() {
                _isSaving = true;
              });
              final success = await viewModel.saveEvent();
              if (mounted) {
                setState(() {
                  _isSaving = false;
                });
                if (success) {
                  Navigator.of(context).pop();
                }
              }
            } else {
              viewModel.nextStep();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2563EB),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          child: _isSaving
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                )
              : Text(
                  state.currentStep == 3 ? 'Publish' : 'Next',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
        ),
      ),
    );
  }
} 