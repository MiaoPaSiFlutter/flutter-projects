import 'package:flutter/material.dart';
import 'package:ocean_utils/ocean_utils.dart';

import '../config/hzy_common_color_config.dart';

class CommonIconLableWidget extends StatelessWidget {
  final String? text;
  final int? maxLines;
  final TextOverflow? overflow;
  final Widget? iconWidget;
  final TextStyle? style;
  const CommonIconLableWidget({
    super.key,
    this.text,
    this.maxLines,
    this.overflow,
    this.iconWidget,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    if (OceanTextTools.isEmpty(text)) {
      return Container();
    }
    List<InlineSpan> children = [];

    if (iconWidget != null) {
      WidgetSpan iconSpan = WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: iconWidget!,
      );
      children.add(iconSpan);
    }

    TextSpan textSpan = TextSpan(text: OceanTextTools.safeStr(text));
    children.add(textSpan);

    return RichText(
      maxLines: maxLines ?? 1,
      overflow: overflow ?? TextOverflow.ellipsis,
      text: TextSpan(
        style:
            style ?? TextStyle(color: HzyCommonColor().col000000, fontSize: 13),
        children: children,
      ),
    );
  }
}
