import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:motomeetfront/models/event.dart';
import 'package:motomeetfront/providers/event_details_provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

class EventStagesList extends ConsumerWidget {
  final String eventId;
  
  const EventStagesList({
    Key? key,
    required this.eventId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventDetailsState = ref.watch(eventDetailsProvider(eventId));
    final stages = eventDetailsState.event?.eventStages.toList() ?? [];
    
    if (stages.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text('No stages defined for this event'),
        ),
      );
    }
    
    // Sort stages by start time
    stages.sort((a, b) {
      if (a.stageStartTime == null && b.stageStartTime == null) return 0;
      if (a.stageStartTime == null) return 1;
      if (b.stageStartTime == null) return -1;
      return a.stageStartTime!.compareTo(b.stageStartTime!);
    });
    
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: stages.length,
      itemBuilder: (context, index) {
        final stage = stages[index];
        return _buildTimelineTile(
          context,
          stage,
          isFirst: index == 0,
          isLast: index == stages.length - 1,
        );
      },
    );
  }

  Widget _buildTimelineTile(
    BuildContext context,
    EventStage stage,
    {required bool isFirst, required bool isLast}
  ) {
    final now = DateTime.now();
    bool isPast = stage.stageStartTime != null && stage.stageStartTime!.isBefore(now);
    bool isCurrent = stage.stageStartTime != null && 
                    stage.stageStartTime!.isBefore(now) && 
                    (stage.stageEndTime == null || stage.stageEndTime!.isAfter(now));
    
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.2,
      isFirst: isFirst,
      isLast: isLast,
      indicatorStyle: IndicatorStyle(
        width: 20,
        color: isCurrent 
            ? Theme.of(context).colorScheme.primary 
            : isPast 
                ? Colors.grey 
                : Colors.grey[300],
        padding: const EdgeInsets.all(6),
        iconStyle: IconStyle(
          color: Colors.white,
          iconData: isCurrent 
              ? Icons.play_arrow 
              : isPast 
                  ? Icons.check 
                  : Icons.circle,
          fontSize: 16,
        ),
      ),
      beforeLineStyle: LineStyle(
        color: isPast ? Colors.grey : Colors.grey[300],
      ),
      afterLineStyle: LineStyle(
        color: isPast ? Colors.grey : Colors.grey[300],
      ),
      endChild: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              stage.title ?? 'Unnamed Stage',
              style: TextStyle(
                fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                fontSize: 16,
                color: isCurrent 
                    ? Theme.of(context).colorScheme.primary 
                    : Colors.black,
              ),
            ),
            if (stage.description != null && stage.description!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  stage.description!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ),
          ],
        ),
      ),
      startChild: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: stage.stageStartTime != null
            ? Text(
                DateFormat('HH:mm').format(stage.stageStartTime!),
                style: TextStyle(
                  fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                  color: isCurrent 
                      ? Theme.of(context).colorScheme.primary 
                      : Colors.black,
                ),
              )
            : const Text('--:--'),
      ),
    );
  }
}
