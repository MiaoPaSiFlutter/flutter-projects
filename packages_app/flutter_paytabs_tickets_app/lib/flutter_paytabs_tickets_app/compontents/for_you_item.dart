import 'package:flutter/material.dart';
import 'package:flutter_paytabs_tickets_app/flutter_paytabs_tickets_app.dart';
import 'package:ocean_common_module/ocean_common_module.dart';

class ForYouItem extends StatelessWidget {
  final Event event;
  const ForYouItem({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: ExtendedExactAssetImageProvider(event.image),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: () => Navigator.of(context)
              .pushNamed(RouterNames.eventDetailsRoute, arguments: event),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${event.date}, ${event.time}',
                  style: const TextStyle(
                    color: AppColors.grey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  event.title,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Image(image: AssetImage(AssetImages.genre)),
                    const SizedBox(width: 5),
                    Text(
                      event.genre,
                      style: lightCollectionGenre,
                    ),
                    const SizedBox(width: 5),
                    Image(
                      image: AssetImage(AssetImages.ticketsActive),
                      color: AppColors.grey,
                      height: 12.5,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'Є${event.prices[0]} - Є${event.prices[event.prices.length - 1]}',
                      style: lightCollectionGenre,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
