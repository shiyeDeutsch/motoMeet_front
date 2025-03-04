import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motomeetfront/models/activity.dart';

class ActivityFeedItem extends StatelessWidget {
  final UserRecentActivity activity;
  final VoidCallback onTap;

  const ActivityFeedItem({
    Key? key, 
    required this.activity, 
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Format timestamp to a readable format
    final formattedDate = DateFormat('MMM d, h:mm a').format(activity.timestamp);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User avatar
              CircleAvatar(
                radius: 24,
                backgroundImage: activity.user.value?.profileImageUrl != null 
                    ? NetworkImage(activity.user.value!.profileImageUrl!)
                    : null,
                child: activity.user.value?.profileImageUrl == null
                    ? Icon(Icons.person, size: 24, color: theme.colorScheme.onSurface)
                    : null,
              ),
              const SizedBox(width: 12),
              
              // Activity content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User name and action text
                    RichText(
                      text: TextSpan(
                        style: theme.textTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: activity.user.value?.username ?? 'User',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: ' ${activity.activityTypeString}',
                          ),
                        ],
                      ),
                    ),
                    
                    // Activity message if available
                    if (activity.message != null && activity.message!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          activity.message!,
                          style: theme.textTheme.bodyMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    
                    // Timestamp
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        formattedDate,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Activity image if available
              if (activity.imageUrl != null && activity.imageUrl!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      activity.imageUrl!,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 60,
                          height: 60,
                          color: Colors.grey[300],
                          child: Icon(Icons.broken_image, color: Colors.grey[600]),
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}