import 'package:flutter/material.dart';
import 'package:ocean_common_module/ocean_common_module.dart';

class SmsloginView extends OceanAbsCommonGetXWidget<SmsloginController> {
  SmsloginView({super.key});

  @override
  String? createAppBarTitleStr() => "短信登录";

  @override
  Widget createScallBody({
    required BuildContext context,
    BoxConstraints? constraints,
  }) {
    return const Center(
      child: Text('SmsloginView is working', style: TextStyle(fontSize: 20)),
    );
  }
}

class SmsloginController extends OceanAbsCommonGetXController{
  //TODO: Implement SmsloginController

  final count = 0.obs;

  void increment() => count.value++;
}
