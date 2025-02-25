import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../models/route.dart';
import '../models/userModel.dart';
import '../services/isar/repository_provider.dart';
import '../widgets/customTextFromField.dart';

class PersonalProfileScreen extends ConsumerStatefulWidget {
  const PersonalProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PersonalProfileScreen> createState() =>
      _PersonalProfileScreenState();
}

class _PersonalProfileScreenState extends ConsumerState<PersonalProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  final _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final repoProvider = GetIt.I<RepositoryProvider>();
    final user = await repoProvider.userInfoRepository.getLastSync();

    if (user != null) {
      setState(() {
        _nameController.text = '${user.firstName} ${user.lastName}';
        _bioController.text = user.bio ?? '';
        _locationController.text = user.address ?? '';
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Implement profile editing functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Picture
              Center(
                child: Stack(
                  children: [
                    const CircleAvatar(
                      radius: 70,
                      backgroundImage:
                          AssetImage('assets/images/default_profile.png'),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt, color: Colors.white),
                          onPressed: () {
                            // TODO: Implement profile picture update
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Username and Basic Info
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                readOnly: true,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _bioController,
                decoration: const InputDecoration(
                  labelText: 'Bio',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.info),
                ),
                readOnly: true,
                maxLines: 3,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_on),
                ),
                readOnly: true,
              ),
              const SizedBox(height: 20),

              // Routes Created
              const Text(
                'Routes Created',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              _buildRouteList(),
              const SizedBox(height: 20),

              // Favorite Routes
              const Text(
                'Favorite Routes',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              _buildFavoriteRouteList(),
              const SizedBox(height: 20),

              // Activity Statistics
              const Text(
                'Activity Statistics',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              _buildActivityStats(),
              const SizedBox(height: 20),

              // Groups
              const Text(
                'Groups',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              _buildGroupList(),
              const SizedBox(height: 20),

              // Upcoming Events
              const Text(
                'Upcoming Events',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              _buildEventList(),
              const SizedBox(height: 20),

              // Privacy Settings
              const Text(
                'Privacy Settings',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              _buildPrivacySettings(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRouteList() {
    // TODO: Fetch user's created routes from the database
    final routes = <NewRoute>[];
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: routes.length,
        itemBuilder: (context, index) {
          final route = routes[index];
          return Card(
            child: SizedBox(
              width: 150,
              child: Column(
                children: [
                  Expanded(
                    child: Image.asset('assets/images/default_route.png',
                        fit: BoxFit.cover),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(route.name),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFavoriteRouteList() {
    // TODO: Fetch user's favorite routes from the database
    final favoriteRoutes = <NewRoute>[];
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: favoriteRoutes.length,
        itemBuilder: (context, index) {
          final route = favoriteRoutes[index];
          return Card(
            child: SizedBox(
              width: 150,
              child: Column(
                children: [
                  Expanded(
                    child: Image.asset('assets/images/default_route.png',
                        fit: BoxFit.cover),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(route.name),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildActivityStats() {
    // TODO: Fetch user's activity statistics from the database
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Total Distance: 0 km'),
        Text('Completed Routes: 0'),
      ],
    );
  }

  Widget _buildGroupList() {
    // TODO: Fetch user's groups from the database
    final groups = <String>[];
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: groups.length,
        itemBuilder: (context, index) {
          final group = groups[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(group),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEventList() {
    // TODO: Fetch user's upcoming events from the database
    final events = <String>[];
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(event),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPrivacySettings() {
    return Column(
      children: [
        _buildPrivacyToggle('Routes Public', true),
        _buildPrivacyToggle('Groups Public', false),
        _buildPrivacyToggle('Route History Public', false),
      ],
    );
  }

  Widget _buildPrivacyToggle(String label, bool initialValue) {
    bool isPublic = initialValue;
    return StatefulBuilder(
      builder: (context, setState) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Switch(
              value: isPublic,
              onChanged: (newValue) {
                setState(() {
                  isPublic = newValue;
                  // TODO: Implement privacy setting update in the database
                });
              },
            ),
          ],
        );
      },
    );
  }
}