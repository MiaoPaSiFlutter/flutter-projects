import 'package:flutter/material.dart';
import 'package:ocean_common_module/ocean_common_module.dart';

class PwdloginView extends OceanAbsCommonGetXWidget<PwdloginController> {
  PwdloginView({super.key});

  @override
  String? createAppBarTitleStr() => "密码登录";

  @override
  Widget createScallBody({
    required BuildContext context,
    BoxConstraints? constraints,
  }) {
    return const Center(
      child: Text('PwdloginView is working', style: TextStyle(fontSize: 20)),
    );
  }
}

class PwdloginController extends OceanAbsCommonGetXController{
  final count = 0.obs;

  void increment() => count.value++;
}
