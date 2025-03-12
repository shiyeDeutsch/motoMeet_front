import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motomeetfront/models/userModel.dart';
import 'package:motomeetfront/providers/event_details_provider.dart';

class PendingParticipantList extends ConsumerWidget {
  final int maxToShow;

  const PendingParticipantList({
    Key? key,
    this.maxToShow = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pendingParticipants = ref.watch(eventDetailsProvider.notifier).getPendingParticipants();

    if (pendingParticipants.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text('No pending requests'),
        ),
      );
    }

    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: maxToShow < pendingParticipants.length
              ? maxToShow
              : pendingParticipants.length,
          itemBuilder: (context, index) {
            final participant = pendingParticipants[index];
            return _buildPendingParticipantTile(participant, ref, context);
          },
        ),
        if (pendingParticipants.length > maxToShow)
          TextButton(
            onPressed: () {
              _showAllPendingParticipants(context, pendingParticipants, ref);
            },
            child: Text('View all ${pendingParticipants.length} requests'),
          ),
      ],
    );
  }

  Widget _buildPendingParticipantTile(UserInfo user, WidgetRef ref, BuildContext context) {
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
      subtitle: const Text('Requesting to join'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.check_circle, color: Colors.green),
            onPressed: () => _approveParticipant(context, ref, user.id.toString()),
            tooltip: 'Approve',
          ),
          IconButton(
            icon: const Icon(Icons.cancel, color: Colors.red),
            onPressed: () => _rejectParticipant(context, ref, user.id.toString()),
            tooltip: 'Reject',
          ),
        ],
      ),
    );
  }

  void _approveParticipant(BuildContext context, WidgetRef ref, String userId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Approve Participant'),
        content: const Text('Are you sure you want to approve this participant?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(eventDetailsProvider.notifier).approveParticipant(userId);
              Navigator.of(context).pop();
            },
            child: const Text('Approve'),
          ),
        ],
      ),
    );
  }

  void _rejectParticipant(BuildContext context, WidgetRef ref, String userId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reject Participant'),
        content: const Text('Are you sure you want to reject this participant?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(eventDetailsProvider.notifier).rejectParticipant(userId);
              Navigator.of(context).pop();
            },
            child: const Text('Reject'),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
          ),
        ],
      ),
    );
  }

  void _showAllPendingParticipants(BuildContext context, List<UserInfo> pendingParticipants, WidgetRef ref) {
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
                        'Pending Requests (${pendingParticipants.length})',
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
                    itemCount: pendingParticipants.length,
                    itemBuilder: (context, index) {
                      return _buildPendingParticipantTile(
                        pendingParticipants[index], ref, context);
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