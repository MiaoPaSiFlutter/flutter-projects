
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:ocean_utils/ocean_utils.dart';

import '../../config/normal_configs.dart';
import '../../utils/screenutil_tools.dart';
import '../../utils/theme_tool.dart';
import '../common_place_holder_widget.dart';

abstract class CommonState<T extends StatefulWidget>
    extends OceanAbsLifeCycleState<T> {
  /// 配置缺省页状态值
  CommonPlaceHoldType placeHoldType = CommonPlaceHoldType.nothing;

  /// 导航栏背景颜色
  @override
  Color? get navBackgroudColor => PageNormalConfig().navBackgroundColor;
  @override
  bool get isAddPopScope => PageNormalConfig().canPopScope;
  @override
  bool get safeAreaBottom => false;

  /// 创建缺省页
  @override
  Widget? createEmptyWidget() {
    return CommonPlaceHoldPage(
      placeHoldType: placeHoldType,
      msg: errMsg,
      ontap: () {
        tapPlaceHoldWidgetMethod(placeHoldType: placeHoldType);
      },
    );
  }

  @override
  bool configIsNeedLayout() {
    return kIsWeb == true ? false : isNeedLayout;
  }

  /// 是否使用脚手架
  @override
  bool configIsNeedScaffol() {
    return isNeedScaffol;
  }

  /// 配置AppBar 字体颜色
  @override
  Color? createAppBarTextColor() {
    return PageNormalConfig().appBarTextColor;
  }

  /// 配置AppBar 返回按钮icon 颜色
  @override
  Color? createLeadingIconColor() {
    return PageNormalConfig().leadingIconColor;
  }

  /// 配置状态栏的高度
  @override
  configPrferredheight() {
    return PageNormalConfig().preferredHeight ??
        SizeMacro.navh - SizeMacro.statusBarHeight;
  }

  /// 配置加载动画
  @override
  Widget? createLoadingWidget() {
    return PageNormalConfig().loadingWidget;
  }

  /// 配置导航栏 背景视图
  @override
  Widget? createFlexBleSpace() {
    return PageNormalConfig().flexBleSpace;
  }

  /// =============== 网络事件 =============== ///

  /// =============== 触发事件 =============== ///
  ///
  //  点击缺省页触发事件
  tapPlaceHoldWidgetMethod({required CommonPlaceHoldType placeHoldType}) {}

  @override
  configPlatformBrightness() {
    ThemeTool.changeTheme(isUserCache: true);
  }
}
