import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ocean_utils/ocean_utils.dart';

import '../../utils/screenutil_tools.dart';
import '../../config/normal_configs.dart';
import '/components/common_place_holder_widget.dart';
import 'ocean_abs_common_getx_controller.dart';

abstract class OceanAbsCommonGetXWidget<T extends OceanAbsCommonGetXController>
    extends GetView<T>
    with OceanAbsWidget {
  OceanAbsCommonGetXWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Widget body = createBuild(context: context);
    return body;
  }

  @override
  Widget createBuild({required BuildContext context}) {
    return Obx(() => super.createBuild(context: context));
  }

  @override
  Widget? createEmptyWidget() {
    return CommonPlaceHoldPage(
      placeHoldType: controller.placeHoldType,
      msg: controller.placeMsg,
      ontap: () {
        controller.tapPlaceHoldWidgetMethod(
          placeHoldType: controller.placeHoldType,
        );
      },
    );
  }

  /// UI配置项
  ///
  ///

  @override
  bool configIsNeedLayout() {
    return kIsWeb == true ? false : controller.isNeedLayout;
  }

  /// 是否使用脚手架
  @override
  bool configIsNeedScaffol() {
    return controller.isNeedScaffol.value;
  }

  /// 是否需要根视图
  @override
  bool configIsNeedRootContatner() {
    return controller.isNeedRootContation.value;
  }

  ///是否形变
  @override
  bool? configResizeToAvoidBottomInset() {
    return controller.resizeToAvoidBottomInset;
  }

  /// 脚手架背景颜色
  @override
  Color? configScallBackgroundColor() {
    return PageNormalConfig().scallBackgroudColor;
  }

  /// 是否关闭右滑返回
  @override
  bool configIsAddPopScope() {
    return controller.isAddPopScope;
  }

  /// 是否关闭顶部安全区域
  @override
  bool configSafeAreaTop() {
    return controller.safeAreatop.value;
  }

  /// 是否关闭底部安全区域
  @override
  bool configSafeAreaBottom() {
    return controller.safeAreabottm.value;
  }

  /// 是否显示加载动画
  @override
  bool configIsShowLoading() {
    return controller.isShowLoadWidget.value;
  }

  @override
  configPageState() {
    return controller.pageState.value;
  }

  /// 是否关闭右滑返回
  @override
  bool configOnWillPop() {
    return controller.isAddPopScope;
  }

  @override
  bool configIsShowAppBar() {
    return controller.isShowAppBar.value;
  }

  /// 配置导航栏标题
  @override
  String? createAppBarTitleStr() {
    return controller.appBarTitle.value;
  }

  /// 配置导航栏背景颜色
  @override
  Color? createAppBarNavBackColor() {
    return PageNormalConfig().navBackgroundColor;
  }

  /// 配置导航栏背景视图
  @override
  Widget? createFlexBleSpace() {
    return PageNormalConfig().flexBleSpace;
  }

  /// 配置导航栏高度
  @override
  configPrferredheight() {
    return PageNormalConfig().preferredHeight ??
        SizeMacro.navh - SizeMacro.statusBarHeight;
  }

  /// 配置返回按钮
  @override
  Widget? createLoadingWidget() {
    return PageNormalConfig().loadingWidget;
  }

  /// 配置导航栏字体颜色
  @override
  Color? createAppBarTextColor() {
    return PageNormalConfig().appBarTextColor;
  }

  /// 配置icon返回颜色
  @override
  Color? createLeadingIconColor() {
    return PageNormalConfig().leadingIconColor;
  }
}
