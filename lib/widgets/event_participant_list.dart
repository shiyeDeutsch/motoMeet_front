import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motomeetfront/models/userModel.dart';
import 'package:motomeetfront/providers/event_participants_provider.dart';
import 'package:motomeetfront/widgets/loading_indicator.dart';

class EventParticipantList extends ConsumerWidget {
  final String eventId;
  final int maxToShow;

  const EventParticipantList({
    Key? key,
    required this.eventId,
    this.maxToShow = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final participantsAsync = ref.watch(eventParticipantsProvider(eventId));

    return participantsAsync.when(
      data: (participants) {
        if (participants.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Text('No participants yet'),
            ),
          );
        }

        return Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: maxToShow < participants.length
                  ? maxToShow
                  : participants.length,
              itemBuilder: (context, index) {
                final participant = participants[index];
                return _buildParticipantTile(participant);
              },
            ),
            if (participants.length > maxToShow)
              TextButton(
                onPressed: () {
                  _showAllParticipants(context, participants);
                },
                child: Text('View all ${participants.length} participants'),
              ),
          ],
        );
      },
      loading: () => const Center(child: LoadingIndicator()),
      error: (error, stack) => Center(
        child: Text('Error: $error'),
      ),
    );
  }

  Widget _buildParticipantTile(UserModel user) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: user.profileImageUrl != null
            ? NetworkImage(user.profileImageUrl!)
            : null,
        child: user.profileImageUrl == null
            ? Text(
                user.username != null && user.username!.isNotEmpty
                    ? user.username![0].toUpperCase()
                    : 'U',
              )
            : null,
      ),
      title: Text(user.username ?? 'Unknown user'),
      subtitle: user.fullName != null && user.fullName!.isNotEmpty
          ? Text(user.fullName!)
          : null,
      onTap: () {
        // Navigate to user profile
      },
    );
  }

  void _showAllParticipants(BuildContext context, List<UserModel> participants) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Participants (${participants.length})',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: participants.length,
                    itemBuilder: (context, index) {
                      return _buildParticipantTile(participants[index]);
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

final eventParticipantsProvider = FutureProvider.family<List<UserModel>, String>((ref, eventId) async {
  final eventsService = ref.read(eventsServiceProvider);
  return await eventsService.getEventParticipants(eventId);
});
