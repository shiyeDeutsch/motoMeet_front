import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../models/route.dart' as app_models;
import '../../routing/routes.dart';

class RouteCard extends StatelessWidget {
  final app_models.Route route;

  const RouteCard({
    Key? key,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          Routes.routeDetails,
          arguments: {'route': route},
        );
      },
      child: Container(
        width: 200,
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
                route.imageUrl ?? 'https://static.motiffcontent.com/private/resource/image/19691ae8bb09fb4-84be62fe-2e2b-4978-ae96-9c72bdd6db64.jpeg', // Use route image or placeholder
                height: 120,
                width: 200,
                fit: BoxFit.cover,
                 errorBuilder: (context, error, stackTrace) => Image.network(
                  'https://static.motiffcontent.com/private/resource/image/19691ae8bb09fb4-84be62fe-2e2b-4978-ae96-9c72bdd6db64.jpeg',
                   height: 120,
                   width: 200,
                   fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 14, 12, 0),
              child: Text(
                route.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 7),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${route.length?.toStringAsFixed(1) ?? 'N/A'} km',
                    style: const TextStyle(fontSize: 14, color: Color(0xFF757575)),
                  ),
                  Text(
                    route.difficultyLevel?.level ?? 'Easy',
                    style: const TextStyle(fontSize: 14, color: Color(0xFF757575)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 3),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: _buildRatingStars(route.rating ?? 0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingStars(double rating) {
    int numberOfStars = rating.round();
    return Row(
      children: List.generate(5, (index) {
        return SvgPicture.network(
          'https://static.motiffcontent.com/private/resource/image/1980dd8a47cd066-817733c7-2588-4925-8e0a-110791d9358f.svg',
          width: 16,
          height: 16,
          colorFilter: ColorFilter.mode(
            index < numberOfStars ? const Color(0xFF2196F3) : Colors.grey.shade300,
            BlendMode.srcIn,
          ),
        );
      }),
    );
  }
}
