import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:hzy_normal_tool/hzy_normal_tool.dart';

import '../normal_abstract/normal_abstract_index.dart';

abstract class OceanAbsLessWidget extends StatelessWidget
    with
        OceanAbsWidget,
        OceanAbsAttribute,
        OceanAbstractNetWork,
        HzyAbsAttribute,
        HzyAbstractNetWork,
        WidgetsBindingObserver {
  OceanAbsLessWidget({super.key});
  @override
  Widget build(BuildContext context) {
    Widget body = createBuild(context: context);
    return body;
  }

  /// =============== UI配置 =============== ///

  /// 是否使用Layout
  @override
  bool configIsNeedLayout() {
    return isNeedLayout;
  }

  /// 创建根视图装饰器
  @override
  configBoxDecoreation() {
    return null;
  }

  /// 是否使用脚手架
  @override
  bool configIsNeedScaffol() {
    return isNeedScaffol;
  }

  @override
  SystemUiOverlayStyle configUiOverlayStyle() {
    return uiOverlayStyle;
  }

  ///是否形变
  @override
  bool? configResizeToAvoidBottomInset() {
    return resizeToAvoidBottomInset;
  }

  /// 脚手架背景颜色
  @override
  Color? configScallBackgroundColor() {
    return scallBackGroundColor;
  }

  /// 是否关闭右滑返回
  @override
  bool configIsAddPopScope() {
    return isAddPopScope;
  }

  /// 是否关闭顶部安全区域
  @override
  bool configSafeAreaTop() {
    return safeAreaTop;
  }

  /// 是否关闭底部安全区域
  @override
  bool configSafeAreaBottom() {
    return safeAreaBottom;
  }

  /// 是否显示加载动画
  @override
  bool configIsShowLoading() {
    return false;
  }

  /// 是否关闭右滑返回
  @override
  bool configOnWillPop() {
    return true;
  }

  @override
  bool configIsShowAppBar() {
    return isShowAppBar;
  }

  /// 配置导航栏标题
  @override
  String? createAppBarTitleStr() {
    return appBarTitle;
  }

  /// 配置导航栏背景颜色
  @override
  Color? createAppBarNavBackColor() {
    return navBackgroudColor;
  }

  /// =============== 网络事件 =============== ///
  @override
  Map<String, dynamic>? configNetWorkParmas({
    String? mark,
    Map<String, dynamic>? params,
  }) {
    return null;
  }

  @override
  getNetWorkData({int? type, Map<String, dynamic>? info}) async {}

  /// =============== 触发事件 =============== ///
}
