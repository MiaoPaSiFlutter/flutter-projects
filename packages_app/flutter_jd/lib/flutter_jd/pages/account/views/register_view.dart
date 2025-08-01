import 'package:flutter/material.dart';
import 'package:ocean_common_module/ocean_common_module.dart';

class RegisterView extends OceanAbsCommonGetXWidget<RegisterController> {
  RegisterView({super.key});

  @override
  String? createAppBarTitleStr() => "注册";

  @override
  Widget createScallBody({
    required BuildContext context,
    BoxConstraints? constraints,
  }) {
    return const Center(
      child: Text('RegisterView is working', style: TextStyle(fontSize: 20)),
    );
  }
}

class RegisterController extends OceanAbsCommonGetXController{
  //TODO: Implement RegisterController

  final count = 0.obs;

  void increment() => count.value++;
}
