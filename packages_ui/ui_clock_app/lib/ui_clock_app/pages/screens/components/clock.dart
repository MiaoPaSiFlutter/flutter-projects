import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ocean_common_module/ocean_common_module.dart';
import '../../helper/helper_index.dart';
import '../../models/my_theme_provider.dart';
import '../../constants.dart';
import '../../size_config.dart';
import 'clock_painter.dart';

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  DateTime _dateTime = DateTime.now();
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _dateTime = DateTime.now();
        });
      } else {}
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 0),
                    color: kShadowColor.withOpacity(0.14),
                    blurRadius: 64,
                  ),
                ],
              ),
              child: Transform.rotate(
                angle: -pi / 2,
                child: CustomPaint(
                  painter: ClockPainter(context, _dateTime),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 50,
          left: 0,
          right: 0,
          child: Consumer<MyThemeModel>(
            builder: (context, theme, child) => GestureDetector(
              onTap: () => theme.changeTheme(),
              child: SvgPicture.asset(
                theme.isLightTheme
                    ? Utils.assets("images/Sun.svg")
                    : Utils.assets("images/Moon.svg"),
                height: 24,
                width: 24,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
