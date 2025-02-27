import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motomeetfront/common/theme/colors.dart';
import 'package:motomeetfront/models/event.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final VoidCallback? onTap;

  const EventCard({
    Key? key,
    required this.event,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: SizedBox(
          width: 280,
          height: 150,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Date column
              _buildDateColumn(context),
              
              // Divider
              const VerticalDivider(width: 1, thickness: 1, indent: 8, endIndent: 8),
              
              // Event details column
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Event name
                      Text(
                        event.name ?? 'Unnamed Event',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      const SizedBox(height: 4),
                      
                      // Event description
                      if (event.description != null)
                        Expanded(
                          child: Text(
                            event.description!,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      
                      const SizedBox(height: 8),
                      
                      // Event stats
                      Row(
                        children: [
                          // Event time
                          _buildStat(
                            Icons.access_time,
                            _formatTime(event.startDateTime),
                          ),
                          
                          const SizedBox(width: 12),
                          // Participants count
                          _buildStat(
                            Icons.people,
                            '${event.participantIds.length} joined',
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 4),
                      
                      // Event tags
                      Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: [
                          // Event type tags
                          if (event.eventActivities.isNotEmpty)
                            ...event.eventActivities.take(2).map((activity) => _buildTag(
                              activity.activityType?.name ?? 'Activity',
                              Icons.directions_bike,
                            )),
                            
                          // Show more tag if there are more activities
                          if (event.eventActivities.length > 2)
                            _buildTag('+${event.eventActivities.length - 2} more', Icons.more_horiz),
                          
                          // Public/Private tag
                          _buildTag(
                            event.isPublic ? 'Public' : 'Private',
                            event.isPublic ? Icons.public : Icons.lock,
                          ),
                          
                          // Approval tag if required
                          if (event.requiresApproval)
                            _buildTag('Approval Required', Icons.check_circle_outline),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateColumn(BuildContext context) {
    if (event.startDateTime == null) {
      return Container(
        width: 60,
        color: Colors.grey[200],
        child: const Center(
          child: Text('TBD', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      );
    }
    
    final now = DateTime.now();
    final eventDate = event.startDateTime!;
    final isToday = eventDate.year == now.year && 
                   eventDate.month == now.month && 
                   eventDate.day == now.day;
    final isTomorrow = DateTime(now.year, now.month, now.day + 1).day == eventDate.day &&
                      now.month == eventDate.month &&
                      now.year == eventDate.year;
                      
    final bgColor = isToday ? AppColors.primary : 
                  isTomorrow ? AppColors.primaryLight : 
                  Colors.grey[200];
                  
    final textColor = isToday || isTomorrow ? Colors.white : Colors.black87;
    
    return Container(
      width: 60,
      color: bgColor,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            isToday ? 'TODAY' : 
            isTomorrow ? 'TMRW' : 
            DateFormat('MMM').format(eventDate).toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          Text(
            DateFormat('d').format(eventDate),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          Text(
            isToday || isTomorrow ? '' : DateFormat('E').format(eventDate),
            style: TextStyle(
              fontSize: 12,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(IconData icon, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.primaryDark),
        const SizedBox(width: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildTag(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 10, color: Colors.grey[700]),
          const SizedBox(width: 2),
          Text(
            text,
            style: TextStyle(fontSize: 10, color: Colors.grey[800]),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime? dateTime) {
    if (dateTime == null) return 'TBD';
    return DateFormat('h:mm a').format(dateTime);
  }
}
