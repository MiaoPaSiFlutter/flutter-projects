import 'package:flutter/material.dart';
import 'package:ocean_common_module/ocean_common_module.dart';

class HorizontalSpacer extends StatelessWidget {
  const HorizontalSpacer({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
    );
  }
}
