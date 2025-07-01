import 'package:flutter/material.dart';
import 'package:ocean_common_module/ocean_common_module.dart';

class OPOrderMessageView extends StatelessWidget {
  final Map floor;
  const OPOrderMessageView({
    Key? key,
    this.floor = const {},
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? message = floor["message"];
    String? messageTime = floor["messageTime"];

    if (OceanTextTools.isEmpty(message)) {
      return Container();
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        decoration: BoxDecoration(
          color: const Color(0xFFEEEEEE),
          border: Border.all(width: 1, color: Colors.transparent),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              OceanTextTools.safeStr("$message"),
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
            Text(
              OceanTextTools.safeStr("$messageTime"),
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
