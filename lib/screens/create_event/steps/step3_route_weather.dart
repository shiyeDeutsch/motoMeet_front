import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motomeetfront/screens/create_event/create_event_viewmodel.dart';
import 'package:motomeetfront/routing/routes.dart';

class Step3RouteWeather extends ConsumerWidget {
  const Step3RouteWeather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(createEventViewModelProvider.notifier);
    final state = ref.watch(createEventViewModelProvider);

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Route Options
        Text('Route Options', style: const TextStyle(color: Color(0xFF374151), fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.discoverRoutes);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2563EB),
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.map_outlined, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'Select a Route from Discover',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Selected Route Details (example)
        if (state.event.route.value != null)
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            color: const Color(0xFFF3F4F6),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  color: Colors.grey[300],
                  child: const Center(child: Text('Map View Placeholder')),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(state.event.route.value!.name ?? 'Unnamed Route', style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildRouteStat('${state.event.route.value!.length ?? 0} km', 'Distance'),
                          _buildRouteStat('${state.event.route.value!.elevationGain ?? 0} m', 'Elevation'),
                          _buildRouteStat(state.event.route.value!.durationMinutes.toString() ?? '0h 0m', 'Est. Time'),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        const SizedBox(height: 16),
        
        // Terrain Info
        Text('Terrain Information', style: const TextStyle(color: Color(0xFF374151), fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        // Add terrain info widget here
        
        const SizedBox(height: 16),

        // Additional Route Notes
        Text('Additional Route Notes', style: const TextStyle(color: Color(0xFF374151), fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Add any specific details about the route...',
            hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
            ),
          ),
          maxLines: 3,
          onChanged: viewModel.setAdditionalRouteNotes,
        ),
        const SizedBox(height: 16),
        
        // Weather
        Text('Weather Considerations', style: const TextStyle(color: Color(0xFF374151), fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Card(
          elevation: 0,
          color: const Color(0xFFEFF6FF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: Color(0xFFDBEAFE)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(17.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.cloud_queue, size: 32, color: Color(0xFF2563EB)),
                    const SizedBox(width: 8),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('May 15, 2024', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
                        Text('Partly Cloudy', style: TextStyle(color: Color(0xFF6B7280), fontSize: 12)),
                      ],
                    ),
                    const Spacer(),
                    Text('68°F', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.black)),
                  ],
                ),
                const SizedBox(height: 8),
                const Text('Recommendation: Pack layers and light rain gear', style: TextStyle(color: Color(0xFF1E40AF))),
              ],
            ),
          ),
        ),
        // SwitchListTile for Weather Alerts
      ],
    );
  }

  Widget _buildRouteStat(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
} 