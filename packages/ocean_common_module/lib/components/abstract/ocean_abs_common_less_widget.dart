import 'package:flutter/material.dart';
import 'package:ocean_utils/ocean_utils.dart';

import '../../config/normal_configs.dart';
import '../../utils/screenutil_tools.dart';
import '../components_index.dart';

abstract class OceanAbsCommonLessWidget extends OceanAbsLessWidget {
  final CommonPlaceHoldType? placeHoldType;
  final String? placeMsg;

  OceanAbsCommonLessWidget({super.key, this.placeMsg, this.placeHoldType});

  @override
  bool get isAddPopScope => PageNormalConfig().canPopScope;
  @override
  Widget? createEmptyWidget() {
    return CommonPlaceHoldPage(
      placeHoldType: placeHoldType ?? CommonPlaceHoldType.nothing,
      msg: placeMsg,
      ontap: () {
        tapPlaceHoldWidgetMethod(
          placeHoldType: placeHoldType ?? CommonPlaceHoldType.nothing,
        );
      },
    );
  }

  @override
  Widget? createFlexBleSpace() {
    return PageNormalConfig().flexBleSpace;
  }

  @override
  Widget? createLoadingWidget() {
    return PageNormalConfig().loadingWidget;
  }

  @override
  configPrferredheight() {
    return PageNormalConfig().preferredHeight ??
        SizeMacro.navh - SizeMacro.statusBarHeight;
  }

  /// 脚手架背景颜色
  @override
  Color? configScallBackgroundColor() {
    return PageNormalConfig().scallBackgroudColor;
  }

  /// 配置导航栏背景颜色
  @override
  Color? createAppBarNavBackColor() {
    return PageNormalConfig().navBackgroundColor;
  }

  @override
  Color? createAppBarTextColor() {
    return PageNormalConfig().appBarTextColor;
  }

  @override
  Color? createLeadingIconColor() {
    return PageNormalConfig().leadingIconColor;
  }

  /// =============== 网络事件 =============== ///

  /// =============== 触发事件 =============== ///
  ///
  ///   // 点击缺省页触发事件
  tapPlaceHoldWidgetMethod({required CommonPlaceHoldType placeHoldType}) {}
}
