import 'package:flutter/material.dart';
import 'package:ocean_common_module/ocean_common_module.dart';

class MidInfoHeaderView extends StatelessWidget {
  final String labelName;
  final String? rightIconText;
  const MidInfoHeaderView({
    super.key,
    required this.labelName,
    this.rightIconText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(child: Text(labelName, style: FontConfig().fontBold14Black)),
          OceanTextTools.isEmpty(rightIconText)
              ? Container()
              : Text(rightIconText!, style: FontConfig().fontBold12Black),
          const Icon(Icons.arrow_forward_ios, size: 10),
        ],
      ),
    );
  }
}
