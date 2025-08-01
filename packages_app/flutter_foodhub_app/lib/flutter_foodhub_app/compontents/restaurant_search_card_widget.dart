import 'package:flutter/material.dart';
import 'package:flutter_foodhub_app/flutter_foodhub_app.dart';

import 'package:ocean_common_module/ocean_common_module.dart';

class RestaurantSearchCardWidget extends StatefulWidget {
  final String name;
  final String pictureId;
  final String city;
  final dynamic rating;

  const RestaurantSearchCardWidget({
    super.key,
    required this.name,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  @override
  State<RestaurantSearchCardWidget> createState() =>
      _RestaurantSearchCardWidgetState();
}

class _RestaurantSearchCardWidgetState
    extends State<RestaurantSearchCardWidget> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Consumer<PreferenceSettingsProvider>(
      builder: (context, preferenceSettingsProvider, _) {
        return Card(
          color: preferenceSettingsProvider.isDarkTheme
              ? blackColor80
              : whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: FadeInImage.assetNetwork(
                      placeholder: Utils.assets('images/foodhub.png'),
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                      image:
                          '${ApiRestaurant.baseUrl}${ApiRestaurant.getImageUrl}${widget.pictureId}',
                      imageErrorBuilder: (context, error, stackTrace) =>
                          Image.asset(Utils.assets('images/foodhub.png')),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                widget.name,
                                style: theme.textTheme.headlineMedium!
                                    .copyWith(fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Image.asset(
                              Utils.assets('icons/verif.png'),
                              width: 13,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on_rounded,
                              color: orangeColor,
                              size: 15,
                              shadows: [
                                BoxShadow(
                                  blurRadius: 5,
                                  spreadRadius: 5,
                                  color: yellowColor50,
                                  offset: const Offset(0, 3),
                                )
                              ],
                            ),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                widget.city,
                                style: theme.textTheme.headlineMedium!
                                    .copyWith(fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: yellowColor,
                              size: 15,
                              shadows: [
                                BoxShadow(
                                  blurRadius: 10,
                                  spreadRadius: 5,
                                  color: preferenceSettingsProvider.isDarkTheme
                                      ? blackColor20
                                      : yellowColor50,
                                  offset: const Offset(0, 3),
                                )
                              ],
                            ),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                widget.rating.toString(),
                                style: theme.textTheme.headlineMedium!
                                    .copyWith(fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.only(left: 3),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                Utils.assets('icons/delivery.png'),
                                width: 14,
                              ),
                              const SizedBox(width: 4.0),
                              Flexible(
                                child: Text(
                                  'Free delivery',
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    fontSize: 12,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Image.asset(
                                Utils.assets('icons/timer.png'),
                                width: 10,
                              ),
                              const SizedBox(width: 4.0),
                              Flexible(
                                child: Text(
                                  '10-15 mins',
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    fontSize: 12,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
