import 'package:flutter/material.dart';
import 'package:ocean_common_module/ocean_common_module.dart';
import 'package:flutter_foodhub_app/flutter_foodhub_app.dart';

class HeaderWidget extends StatelessWidget {
  final RestaurantListProvider restaurantListProvider;

  const HeaderWidget({
    super.key,
    required this.restaurantListProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferenceSettingsProvider>(
      builder: (context, preferenceSettingsProvider, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => Navigator.pushNamed(context, Routes.profileScreen),
              enableFeedback: false,
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                Utils.assets('icons/user.png'),
                width: 40,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      'Deliver to',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: preferenceSettingsProvider.isDarkTheme
                                ? whiteColor
                                : grayColor,
                            fontSize: 14,
                          ),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 22,
                      color: preferenceSettingsProvider.isDarkTheme
                          ? whiteColor
                          : grayColor,
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                Text(
                  'Rukan CBD Greenlake City',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: orangeColor,
                        fontSize: 14,
                      ),
                ),
              ],
            ),
            InkWell(
              onTap: () =>
                  Navigator.pushNamed(context, Routes.restaurantFavoriteScreen)
                      .then((value) => restaurantListProvider.refreshData),
              enableFeedback: false,
              splashColor: grayColor,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: preferenceSettingsProvider.isDarkTheme
                        ? blackColor80
                        : whiteColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: preferenceSettingsProvider.isDarkTheme
                            ? blackColor80
                            : Colors.grey.withOpacity(0.3),
                        spreadRadius: 0,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 2,
                    vertical: 2,
                  ),
                  child: Icon(
                    Icons.favorite,
                    size: 20,
                    color: orangeColor,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
