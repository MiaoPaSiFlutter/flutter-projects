import 'package:flutter/material.dart';
import 'package:ocean_utils/ocean_utils.dart';

import 'ocean_theme_abs.dart';

class OceanColorSring {
  static String coltheme = "theme";
  static String colffffff = "ffffff";
  static String col000000 = "000000";
  static String colefedf3 = "efedf3";
  static String col666666 = "666666";
  static String col999999 = "999999";
  static String colc3c3c3 = "c3c3c3";
  static String coldddddd = "dddddd";
  static String cole8e8e8 = "e8e8e8";
  static String cola6a6a6 = 'a6a6a6';
  static String cole3e3e3 = "e3e3e3";
  static String colonlywhite = "colonlywhite";
  static String colababab = "ababab";
  static String col5a5a5a = "5a5a5a";
  static String coldadada = "dadada";
  static String cole9e9e9 = "e9e9e9";
  static String colb0b0b0 = "b0b0b0";
  static String backGroupColor = "f4f5f9";

  /// boss 背景色
  static String colf5f5f5 = "f5f5f5";

  /// 细线颜色
  static String colline = 'lineColor';

  /// 白色背景 黑色字体
  static String whitebgblacktextcolor = "whiteback";

  /// 协议字体颜色
  static String agreementtextcolor = 'agreementextcolor';

  /// 禁用按钮背景颜色
  static String disableBtnBackGroudColor = "disableBtnBackGroudColor";

  /// 禁用按钮字体颜色
  static String disableBtnTitleColor = "disableBtnTitleColor";
}

class OceanColors {
  /// 白色背景 黑色字体
  static const Color col181818 = Color(0xff181818);
  static const Color coldddde6 = Color(0xffdddde6);

  /// 协议字体颜色
  static const Color col61678b = Color(0xff61678b);
  static const Color col8b8ca8 = Color(0xff8b8ca8);

  /// 三级灰色
  static const Color colb0b0b0 = Color(0xffb0b0b0);
  static const Color col606060 = Color(0xff606060);
}

class OceanThemeColorConfig extends OceanColorAbs {
  OceanThemeColorConfig._internal();
  factory OceanThemeColorConfig() => _instance;
  static final OceanThemeColorConfig _instance =
      OceanThemeColorConfig._internal();

  @override
  Map<String, Color?> get lightInfo => {
    OceanColorSring.coltheme: HzyNormalColorS.col2865ff,
    OceanColorSring.colffffff: HzyNormalColorS.colffffff,
    OceanColorSring.col000000: HzyNormalColorS.col000000,
    OceanColorSring.colefedf3: HzyNormalColorS.colefedf3,
    OceanColorSring.col666666: HzyNormalColorS.col666666,
    OceanColorSring.col999999: HzyNormalColorS.col999999,
    OceanColorSring.colc3c3c3: HzyNormalColorS.colc3c3c3,
    OceanColorSring.cola6a6a6: HzyNormalColorS.cola6a6a6,
    OceanColorSring.colonlywhite: HzyNormalColorS.colffffff,
    OceanColorSring.coldddddd: HzyNormalColorS.coldddddd,
    OceanColorSring.cole8e8e8: HzyNormalColorS.cole8e8e8,
    OceanColorSring.cole3e3e3: HzyNormalColorS.cole3e3e3,
    OceanColorSring.colababab: HzyNormalColorS.colababab,
    OceanColorSring.col5a5a5a: HzyNormalColorS.col5a5a5a,
    OceanColorSring.coldadada: HzyNormalColorS.coldadada,
    OceanColorSring.cole9e9e9: HzyNormalColorS.cole9e9e9,
    OceanColorSring.colb0b0b0: OceanColors.colb0b0b0,
    OceanColorSring.colf5f5f5: const Color.fromRGBO(245, 245, 245, 1),
    OceanColorSring.backGroupColor: HzyNormalColorS.colf4f5f9,
    OceanColorSring.whitebgblacktextcolor: OceanColors.col181818,
    OceanColorSring.agreementtextcolor: OceanColors.col61678b,
    OceanColorSring.colline: HzyNormalColorS.coldddddd,
    OceanColorSring.disableBtnBackGroudColor: HzyNormalColorS.colf0f0f0,
    OceanColorSring.disableBtnTitleColor: HzyNormalColorS.colbdbdbd,
  };
  @override
  Map<String, Color?> get darkInfo => {
    OceanColorSring.coltheme: HzyNormalColorS.col2865ff,
    OceanColorSring.colffffff: const Color.fromRGBO(27, 27, 27, 1),
    OceanColorSring.col000000: HzyNormalColorS.colffffff,
    OceanColorSring.colefedf3: HzyNormalColorS.col151515,
    OceanColorSring.col666666: HzyNormalColorS.colCACACA,
    OceanColorSring.col999999: HzyNormalColorS.col7C7C7C,
    OceanColorSring.colc3c3c3: HzyNormalColorS.col101010,
    OceanColorSring.cola6a6a6: HzyNormalColorS.col4d4d4d,
    OceanColorSring.colonlywhite: HzyNormalColorS.colffffff,
    OceanColorSring.coldddddd: HzyNormalColorS.col2d2d2d,
    OceanColorSring.cole8e8e8: HzyNormalColorS.col0e0e0e,
    OceanColorSring.cole3e3e3: HzyNormalColorS.col252525,
    OceanColorSring.colababab: HzyNormalColorS.col505050,
    OceanColorSring.col5a5a5a: HzyNormalColorS.col909090,
    OceanColorSring.coldadada: HzyNormalColorS.coldadada,
    OceanColorSring.cole9e9e9: HzyNormalColorS.col0e0e0e,
    OceanColorSring.colb0b0b0: OceanColors.col606060,
    OceanColorSring.colf5f5f5: const Color.fromRGBO(20, 20, 20, 1),
    OceanColorSring.whitebgblacktextcolor: OceanColors.coldddde6,
    OceanColorSring.agreementtextcolor: OceanColors.col8b8ca8,
    OceanColorSring.backGroupColor: HzyNormalColorS.col0e0e0e,
    OceanColorSring.colline: HzyNormalColorS.col2d2d2d,
    OceanColorSring.disableBtnBackGroudColor: HzyNormalColorS.colf0f0f0,
    OceanColorSring.disableBtnTitleColor: HzyNormalColorS.colbdbdbd,
  };
}
