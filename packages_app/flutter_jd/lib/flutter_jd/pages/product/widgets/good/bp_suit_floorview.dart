import 'package:flutter/material.dart';
import 'package:ocean_common_module/ocean_common_module.dart';

class BpSuitFloorView extends StatelessWidget {
  final Map? floor;
  const BpSuitFloorView({Key? key, this.floor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.red),
      ),
      child: Text(OceanTextTools.safeStr(floor?["mId"])),
    );
  }
}
