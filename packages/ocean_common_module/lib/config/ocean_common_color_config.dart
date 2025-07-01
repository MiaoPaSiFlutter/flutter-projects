import 'package:flutter/material.dart';

import 'ocean_theme_color_config.dart';

class OceanCommonColor {
  /// 白色背景 黑色字体颜色
  Color wbgblacktextcolor = OceanThemeColorConfig().configColor(
    colkey: OceanColorSring.whitebgblacktextcolor,
  );

  /// 白色背景颜色
  Color whitebackgroundColor = OceanThemeColorConfig().configColor(
    colkey: OceanColorSring.colffffff,
  );

  /// 禁用按钮背景颜色
  Color disableBtnBackGroudColor = OceanThemeColorConfig().configColor(
    colkey: OceanColorSring.disableBtnBackGroudColor,
  );

  /// 禁用按钮字体颜色
  Color disableBtnTitleColor = OceanThemeColorConfig().configColor(
    colkey: OceanColorSring.disableBtnTitleColor,
  );

  /// 主题色
  Color colthemes = OceanThemeColorConfig().configColor(
    colkey: OceanColorSring.coltheme,
  );

  /// 纯黑色
  Color col000000 = OceanThemeColorConfig().configColor(
    colkey: OceanColorSring.col000000,
  );

  ///
  Color colefedf3 = OceanThemeColorConfig().configColor(
    colkey: OceanColorSring.colefedf3,
  );
  Color col666666 = OceanThemeColorConfig().configColor(
    colkey: OceanColorSring.col666666,
  );
  Color col999999 = OceanThemeColorConfig().configColor(
    colkey: OceanColorSring.col999999,
  );
  Color colc3c3c3 = OceanThemeColorConfig().configColor(
    colkey: OceanColorSring.colc3c3c3,
  );

  Color coldddddd = OceanThemeColorConfig().configColor(
    colkey: OceanColorSring.coldddddd,
  );

  /// 二级灰色字体颜色
  Color col5a5a5a = OceanThemeColorConfig().configColor(
    colkey: OceanColorSring.col5a5a5a,
  );

  /// 输入框 place 字体颜色
  Color colplacetextcolor = OceanThemeColorConfig().configColor(
    colkey: OceanColorSring.cola6a6a6,
  );

  /// 纯白色背景
  Color colonlywhite = OceanThemeColorConfig().configColor(
    colkey: OceanColorSring.colonlywhite,
  );

  /// 灰色背景颜色
  Color backgroudgrey = OceanThemeColorConfig().configColor(
    colkey: OceanColorSring.backGroupColor,
    // OceanColorSring.colf5f5f5,
  );

  /// 分割线颜色
  Color linecolor = OceanThemeColorConfig().configColor(
    colkey: OceanColorSring.colline,
  );

  Color colore9e9e9 = OceanThemeColorConfig().configColor(
    colkey: OceanColorSring.cole9e9e9,
  );

  /// 发布文章 背景颜色
  Color pusbulishbackgroundColor = const Color(0xff181818);

  /// 协议字体颜色
  Color agreementtextcolor = OceanThemeColorConfig().configColor(
    colkey: OceanColorSring.agreementtextcolor,
  );

  /// 三级说明字体灰色
  Color colb0b0b0 = OceanThemeColorConfig().configColor(
    colkey: OceanColorSring.colb0b0b0,
  );
}
