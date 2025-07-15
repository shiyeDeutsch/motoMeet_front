import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:motomeetfront/common/widgets/event_card.dart';
import 'package:motomeetfront/common/widgets/route_card.dart';
import 'package:motomeetfront/models/event.dart';
import 'package:motomeetfront/models/route.dart' as route_model;
import 'package:motomeetfront/routing/routes.dart';
import 'package:motomeetfront/services/isar/repository_provider.dart';

// Mock data for development
import '../mock/mock_home_data.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    // Using mock data for UI development
    final upcomingEvents = mockUpcomingEvents;
    final recommendedRoutes = mockRecommendedRoutes;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            const _HomeAppBar(),
            const _WelcomeHeader(),
            const SizedBox(height: 21),
            _buildSectionHeader('Your Upcoming Events', () {}),
            const SizedBox(height: 12),
            _buildUpcomingEvents(upcomingEvents, context),
            const SizedBox(height: 34),
            _buildSectionHeader('Recommended Routes', () {
              Navigator.pushNamed(context, Routes.discoverRoutes);
            }),
            const SizedBox(height: 12),
            _buildRecommendedRoutes(recommendedRoutes, context),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onViewAll) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
          TextButton(
            onPressed: onViewAll,
            child: const Text(
              'View All',
              style: TextStyle(
                color: Color(0xFF2196F3),
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedRoutes(List<route_model.Route> routes, BuildContext context) {
    return SizedBox(
      height: 216, // Height from design
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        scrollDirection: Axis.horizontal,
        itemCount: routes.length,
        itemBuilder: (context, index) {
          return RouteCard(route: routes[index]);
        },
        separatorBuilder: (context, index) => const SizedBox(width: 16),
      ),
    );
  }

  Widget _buildUpcomingEvents(List<Event> events, BuildContext context) {
    return SizedBox(
      height: 212, // Height from design
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        scrollDirection: Axis.horizontal,
        itemCount: events.length,
        itemBuilder: (context, index) {
          return EventCard(
            event: events[index],
            onTap: () {
              // Navigate to event details
            },
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 16),
      ),
    );
  }
}

class _HomeAppBar extends StatelessWidget {
  const _HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'TrailMate',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: SvgPicture.network(
                  'https://static.motiffcontent.com/private/resource/image/1980dd8a475e791-256caf42-6c52-411f-be40-0a329ff9615b.svg',
                  colorFilter: const ColorFilter.mode(Color(0xFF4B5563), BlendMode.srcIn),
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: SvgPicture.network(
                  'https://static.motiffcontent.com/private/resource/image/1980dd8a47604bf-b1f54a6f-8122-49d7-9e89-490eac87214d.svg',
                  colorFilter: const ColorFilter.mode(Color(0xFF4B5563), BlendMode.srcIn),
                ),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WelcomeHeader extends ConsumerStatefulWidget {
  const _WelcomeHeader({Key? key}) : super(key: key);

  @override
  ConsumerState<_WelcomeHeader> createState() => _WelcomeHeaderState();
}

class _WelcomeHeaderState extends ConsumerState<_WelcomeHeader> {
  String _userName = 'Guest'; // Default name

  @override
  void initState() {
    super.initState();
    _fetchUserName();
  }

  Future<void> _fetchUserName() async {
    final repositoryProvider = GetIt.I<RepositoryProvider>();
    final currentUser = await repositoryProvider.userInfoRepository.getCurrentUser();
    if (currentUser != null && currentUser.username != null && currentUser.username!.isNotEmpty) {
      setState(() {
        _userName = currentUser.username!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 17, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Good morning, $_userName',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Ready for your next adventure?',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF757575),
            ),
          ),
        ],
      ),
    );
  }
}
