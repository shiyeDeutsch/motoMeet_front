import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motomeetfront/models/event.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      child: Container(
        width: 240,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                'https://static.motiffcontent.com/private/resource/image/19691ae8bafdf6b-1b819afb-fd6c-4649-884b-7f1af2813f2a.jpeg', // Placeholder image from design
                height: 120,
                width: 240,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 14, 12, 0),
              child: Text(
                event.name ?? 'Event Name',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal, // Design uses normal weight
                  color: Colors.black,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 6), // Adjusted from 7 to 6 to fix overflow
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  SvgPicture.network(
                    'https://static.motiffcontent.com/private/resource/image/1980dd8a4766426-6773be93-fb54-4dc6-9c94-9c53a8bfd590.svg',
                    width: 16,
                    height: 16,
                    colorFilter: const ColorFilter.mode(Color(0xFF757575), BlendMode.srcIn),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    event.startDateTime != null
                        ? DateFormat('E, MMM d').format(event.startDateTime!)
                        : 'Date',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF757575),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 3),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                   SvgPicture.network(
                    'https://static.motiffcontent.com/private/resource/image/1980dd8a4776688-36bbbb6f-c761-4412-901c-233f06a13d65.svg',
                     width: 16,
                    height: 16,
                     colorFilter: const ColorFilter.mode(Color(0xFF757575), BlendMode.srcIn),

                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Mountain Park', // Placeholder from design
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF757575),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
