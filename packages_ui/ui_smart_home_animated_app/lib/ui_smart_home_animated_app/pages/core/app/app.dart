import 'package:flutter/material.dart';
import 'package:ocean_common_module/ocean_common_module.dart';

import '../../features/home/presentation/screens/home_screen.dart';
import '../theme/theme.dart';

class SmartHomeApp extends StatelessWidget {
  const SmartHomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'TheFlutterWay Smart Home Animated App',
          theme: SHTheme.dark,
          home: const HomeScreen(),
        );
      },
    );
  }
}
