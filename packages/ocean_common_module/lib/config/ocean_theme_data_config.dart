import 'package:flutter/material.dart';

/// 亮色主题
ThemeData oceanThemeDataLight = ThemeData(
  brightness: Brightness.light,

  /// scaffold 背景色
  // scaffoldBackgroundColor: HzyNormalColorS.colffffff,

  /// 点击水波纹动画效果
  /// 这里我们把水波纹动画去掉
  splashFactory: NoSplash.splashFactory,

  /// 水波纹颜色
  splashColor: Colors.white.withAlpha(0),
);

/// 暗黑主题
ThemeData oceanThemeDataDark = ThemeData(
  brightness: Brightness.dark,

  /// scaffold 背景色
  // scaffoldBackgroundColor: const Color.fromRGBO(27, 27, 27, 1),

  /// 点击水波纹动画效果
  /// 这里我们把水波纹动画去掉
  splashFactory: NoSplash.splashFactory,

  /// 水波纹颜色
  splashColor: Colors.white.withAlpha(0),
);
