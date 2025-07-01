import 'package:flutter/material.dart';
import 'package:ocean_common_module/ocean_common_module.dart';

import 'listpage.dart';

class FlutterWeatherApp extends GetView<FlutterWeatherAppController> {
  const FlutterWeatherApp({super.key});

  @override
  FlutterWeatherAppController get controller =>
      Get.put(FlutterWeatherAppController());

  @override
  Widget build(BuildContext context) {
    return MyAppWrapper();
  }
}

class FlutterWeatherAppController extends GetxController {
  FlutterWeatherAppController();

  /// give access to currentContext
  BuildContext? get context => Get.context;
}

class MyAppWrapper extends StatelessWidget {
  const MyAppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        home: const CityList());
  }
}
