import 'package:flutter/material.dart';
import '../layout/adaptive.dart';
import '../values/values.dart';

import 'animated_indicator.dart';
import 'selected_indicator.dart';

const double indicatorWidth = Sizes.WIDTH_60;

class NavItemData {
  final String name;
  final GlobalKey key;
  bool isSelected;

  NavItemData({
    required this.name,
    required this.key,
    this.isSelected = false,
  });
}

class NavItem extends StatefulWidget {
  NavItem({
    super.key,
    required this.title,
    this.titleColor = AppColors.black,
    this.isSelected = false,
    this.isMobile = false,
    this.titleStyle,
    this.onTap,
  });

  final String title;
  final TextStyle? titleStyle;
  final Color titleColor;
  final bool isSelected;
  final bool isMobile;
  final GestureTapCallback? onTap;

  @override
  _NavItemState createState() => _NavItemState();
}

class _NavItemState extends State<NavItem> with SingleTickerProviderStateMixin {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double textSize = responsiveSize(
      context,
      Sizes.TEXT_SIZE_14,
      Sizes.TEXT_SIZE_16,
      md: Sizes.TEXT_SIZE_15,
    );

    return MouseRegion(
      onEnter: (e) => _mouseEnter(true),
      onExit: (e) => _mouseEnter(false),
      child: InkWell(
        onTap: widget.onTap,
        child: Stack(
          children: [
            if (!widget.isMobile)
              widget.isSelected
                  ? const Positioned(
                      top: Sizes.SIZE_12,
                      child: SelectedIndicator(
                        width: indicatorWidth,
                      ),
                    )
                  : Positioned(
                      top: Sizes.SIZE_12,
                      child: AnimatedHoverIndicator(
                        isHover: _hovering,
                        width: indicatorWidth,
                      ),
                    ),
            Text(
              widget.title,
              style: widget.titleStyle ??
                  textTheme.titleMedium?.copyWith(
                    fontSize: textSize,
                    color: widget.titleColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  void _mouseEnter(bool hovering) {
    setState(() {
      _hovering = hovering;
    });
  }
}
