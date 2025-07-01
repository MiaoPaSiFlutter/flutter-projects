import 'package:flutter/material.dart';
import 'package:ocean_common_module/ocean_common_module.dart';

const kDuration = Duration(milliseconds: 600);

Future<void> openUrlLink(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(
      Uri.parse(url),
      // forceSafariVC: false,
      // forceWebView: false,
    );
  } else {
    throw 'Could not launch $url';
  }
}

scrollToSection(BuildContext context) {
  Scrollable.ensureVisible(
    context,
    duration: kDuration,
  );
}
