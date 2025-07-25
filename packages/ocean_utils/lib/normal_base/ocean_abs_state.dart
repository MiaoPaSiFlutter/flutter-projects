import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hzy_normal_tool/hzy_normal_tool.dart';
import '../normal_abstract/normal_abstract_index.dart';

abstract class OceanAbsState<T extends StatefulWidget> extends State<T>
    with
        OceanAbsWidget,
        OceanAbsAttribute,
        OceanAbstractNetWork,
        HzyAbsAttribute,
        HzyAbstractNetWork,
        WidgetsBindingObserver {
  /// 失败描述语
  String? errMsg;

  /// 当前content
  late BuildContext? buildContext;
  bool isShowLoading = false;
  PageState pageState = PageState.initializedState;

  /// 界面初始化完成
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      initDefaultState();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      interfaceRenderingCompleted();
    });
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return createBuild(context: context);
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
    return isShowLoading;
  }

  /// 配置界面状态
  @override
  configPageState() {
    return pageState;
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

  /// ========== 界面生命周期 ========== ///
  /// 界面进入
  void initDefaultState() {}

  /// 界面渲染完成
  void interfaceRenderingCompleted() {}

  /// 界面销毁
  void initDefaultDispose() {}

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
  ///

  configSetState(void Function() fn) {
    if (mounted) {
      setState(fn);
    }
  }
}
