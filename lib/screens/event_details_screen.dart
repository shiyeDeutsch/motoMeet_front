import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:motomeetfront/models/event.dart';
import 'package:motomeetfront/providers/event_details_provider.dart';
import 'package:motomeetfront/widgets/ExpandablePanel.dart';
import 'package:motomeetfront/widgets/dialogs/confirmation_dialog.dart';
import 'package:motomeetfront/widgets/event_participant_list.dart';
import 'package:motomeetfront/widgets/event_stages_list.dart';
import 'package:motomeetfront/widgets/loading_indicator.dart';

class EventDetailsScreen extends ConsumerStatefulWidget {
  final String eventId;

  const EventDetailsScreen({
    Key? key,
    required this.eventId,
  }) : super(key: key);

  @override
  ConsumerState<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends ConsumerState<EventDetailsScreen> {
  late final Future<void> _loadEventFuture;

  @override
  void initState() {
    super.initState();
    _loadEventFuture = _loadEventDetails();
  }

  Future<void> _loadEventDetails() async {
    await ref.read(eventDetailsProvider(widget.eventId).notifier).loadEventDetails();
  }

  @override
  Widget build(BuildContext context) {
    final eventDetailsState = ref.watch(eventDetailsProvider(widget.eventId));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          eventDetailsState.event?.name ?? 'Event Details',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          if (eventDetailsState.isCreator)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/edit-event',
                  arguments: eventDetailsState.event,
                );
              },
            ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: _loadEventFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: LoadingIndicator());
            }

            if (eventDetailsState.error != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${eventDetailsState.error}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        ref.read(eventDetailsProvider(widget.eventId).notifier).loadEventDetails();
                      },
                      child: const Text('Try again'),
                    ),
                  ],
                ),
              );
            }

            if (eventDetailsState.event == null) {
              return const Center(child: Text('Event not found'));
            }

            final event = eventDetailsState.event!;

            return _buildEventDetails(context, event, eventDetailsState);
          },
        ),
      ),
      bottomNavigationBar: eventDetailsState.event != null
          ? _buildActionButton(context, eventDetailsState)
          : null,
    );
  }

  Widget _buildEventDetails(
      BuildContext context, Event event, EventDetailsState eventDetailsState) {
    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(eventDetailsProvider(widget.eventId).notifier).loadEventDetails(refresh: true);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Card with basic event info
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Event date/time
                      _buildDateTimeInfo(event),
                      const Divider(height: 24),
                      
                      // Event details
                      if (event.description != null && event.description!.isNotEmpty)
                        Text(
                          event.description!,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      
                      const SizedBox(height: 16),
                      
                      // Event details tags
                      _buildEventTags(event),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Organizer information
              ExpandablePanel(
                title: 'Organizer',
                initiallyExpanded: true,
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      (eventDetailsState.creatorName?.isNotEmpty ?? false)
                          ? eventDetailsState.creatorName![0].toUpperCase()
                          : 'U',
                    ),
                  ),
                  title: Text(eventDetailsState.creatorName ?? 'Unknown'),
                  subtitle: const Text('Event Organizer'),
                  trailing: IconButton(
                    icon: const Icon(Icons.message),
                    onPressed: () {
                      // Implement messaging functionality
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Messaging coming soon')),
                      );
                    },
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Participants list
              ExpandablePanel(
                title: 'Participants (${eventDetailsState.participantCount})',
                initiallyExpanded: true,
                child: EventParticipantList(eventId: widget.eventId),
              ),
              
              const SizedBox(height: 16),
              
              // Event stages
              if (eventDetailsState.hasStages)
                ExpandablePanel(
                  title: 'Event Schedule',
                  initiallyExpanded: true,
                  child: EventStagesList(eventId: widget.eventId),
                ),
              
              const SizedBox(height: 16),
              
              // Required items
              if (eventDetailsState.hasRequiredItems)
                ExpandablePanel(
                  title: 'Required Equipment',
                  child: _buildRequiredItemsList(event),
                ),
              
              const SizedBox(height: 16),
              
              // Event activities
              if (eventDetailsState.hasActivities)
                ExpandablePanel(
                  title: 'Activities',
                  child: _buildActivitiesList(event),
                ),
              
              const SizedBox(height: 80), // Extra space at bottom for FAB
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateTimeInfo(Event event) {
    final startDate = event.startDateTime;
    final endDate = event.endDateTime;
    
    if (startDate == null) {
      return const Text('Date: Not specified');
    }
    
    final dateFormat = DateFormat('E, MMM d, y');
    final timeFormat = DateFormat('h:mm a');
    
    final startDateStr = dateFormat.format(startDate);
    final startTimeStr = timeFormat.format(startDate);
    
    if (endDate == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            startDateStr,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text('Starting at $startTimeStr'),
        ],
      );
    }
    
    // Check if multi-day event
    final isMultiDay = startDate.day != endDate.day || 
                       startDate.month != endDate.month || 
                       startDate.year != endDate.year;
                       
    if (isMultiDay) {
      final endDateStr = dateFormat.format(endDate);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'From $startDateStr',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            'To $endDateStr',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text('Starting at ${timeFormat.format(startDate)}'),
          Text('Ending at ${timeFormat.format(endDate)}'),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            startDateStr,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text('${timeFormat.format(startDate)} - ${timeFormat.format(endDate)}'),
        ],
      );
    }
  }

  Widget _buildEventTags(Event event) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        if (event.isPublic == true)
          _buildTag('Public', Icons.public),
        if (event.isPublic == false)
          _buildTag('Private', Icons.lock),
        if (event.requiresApproval == true)
          _buildTag('Approval Required', Icons.check_circle),
      ],
    );
  }

  Widget _buildTag(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 4),
          Text(text, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildRequiredItemsList(Event event) {
    final items = event.requiredItems.toList();
    if (items.isEmpty) {
      return const ListTile(title: Text('No required equipment'));
    }
    
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          leading: const Icon(Icons.check_box_outline_blank),
          title: Text(item.itemName ?? 'Unnamed item'),
          subtitle: item.description != null ? Text(item.description!) : null,
        );
      },
    );
  }

  Widget _buildActivitiesList(Event event) {
    final activities = event.eventActivities.toList();
    if (activities.isEmpty) {
      return const ListTile(title: Text('No activities planned'));
    }
    
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: activities.length,
      itemBuilder: (context, index) {
        final activity = activities[index];
        return ListTile(
          leading: const Icon(Icons.directions_bike),
          title: Text(activity.activityType?.name ?? 'Unnamed activity'),
        );
      },
    );
  }

  Widget _buildActionButton(BuildContext context, EventDetailsState state) {
    if (state.isCreator) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () async {
                  final result = await showDialog<bool>(
                    context: context,
                    builder: (context) => const ConfirmationDialog(
                      title: 'Cancel Event',
                      content: 'Are you sure you want to cancel this event? This cannot be undone.',
                    ),
                  );
                  
                  if (result == true) {
                    await ref.read(eventDetailsProvider(widget.eventId).notifier)
                        .cancelEvent();
                    if (mounted) Navigator.pop(context);
                  }
                },
                child: const Text('Cancel Event'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: FilledButton(
                onPressed: () {
                  // Implement manage participants functionality
                },
                child: const Text('Manage Participants'),
              ),
            ),
          ],
        ),
      );
    } else if (state.isParticipant) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: FilledButton(
          onPressed: () async {
            final result = await showDialog<bool>(
              context: context,
              builder: (context) => const ConfirmationDialog(
                title: 'Leave Event',
                content: 'Are you sure you want to leave this event?',
              ),
            );
            
            if (result == true) {
              await ref.read(eventDetailsProvider(widget.eventId).notifier)
                  .leaveEvent();
            }
          },
          style: FilledButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: const Text('Leave Event'),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: FilledButton(
          onPressed: () async {
            await ref.read(eventDetailsProvider(widget.eventId).notifier)
                .joinEvent();
          },
          child: Text(
            state.event?.requiresApproval == true
                ? 'Request to Join'
                : 'Join Event',
          ),
        ),
      );
    }
  }
}
