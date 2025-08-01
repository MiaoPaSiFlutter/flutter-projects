import 'package:flutter/material.dart';
import 'package:ocean_common_module/ocean_common_module.dart';

class TabHeader extends StatelessWidget {
  const TabHeader({
    Key? key,
    required this.label,
    required this.tabIndex,
    required this.activeTabs,
    required this.inactiveTabColor,
  }) : super(key: key);

  final List<int> activeTabs;
  final Color inactiveTabColor;
  final String label;
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 18.h),
      child: Text(
        label,
        style: TextStyle(
            color:
                activeTabs.contains(tabIndex) ? Colors.black : inactiveTabColor,
            fontSize: 18.sp),
      ),
    );
  }
}
