import 'package:flutter/material.dart';
import 'package:hzy_common_module/hzy_common_module.dart';
import 'package:flutter_foodhub_app/flutter_foodhub_app.dart';

class ReviewCardWidget extends StatelessWidget {
  final String name;
  final String review;
  final String date;

  const ReviewCardWidget({
    super.key,
    required this.name,
    required this.review,
    required this.date,
  });

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
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: theme.textTheme.headlineMedium!.copyWith(
                    fontSize: 15,
                    color: orangeColor,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  review,
                  style: theme.textTheme.headlineMedium!.copyWith(
                    fontSize: 13,
                    color: preferenceSettingsProvider.isDarkTheme
                        ? grayColor50
                        : blackColor50,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  date,
                  style: theme.textTheme.headlineMedium!.copyWith(
                    fontSize: 12,
                    color: preferenceSettingsProvider.isDarkTheme
                        ? grayColor
                        : blackColor20,
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
