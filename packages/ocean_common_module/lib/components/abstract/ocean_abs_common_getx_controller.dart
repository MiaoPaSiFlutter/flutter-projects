import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import '/ocean_common_module.dart';

abstract class OceanAbsCommonGetXController extends GetxController
    with
        OceanAbstractNetWork,
        HzyAbstractNetWork,
        HzyNormalLifeCycleAbs,
        WidgetsBindingObserver {
  /// 项目中 使用的失败界面的标识,用于使用者 显示不同的界面
  /// 具体 使用,一般是通过网络请求,进行逻辑处理
  CommonPlaceHoldType placeHoldType = CommonPlaceHoldType.nonetwork;

  /// 缺省页 描述语
  String? placeMsg;

  /// 配置界面状态
  /// PageState.initializedState 初始化中 默认状态
  var pageState = PageState.initializedState.obs;

  /// 是否显示导航栏
  var isShowAppBar = true.obs;

  /// 导航栏标题
  var appBarTitle = "".obs;

  /// 默认安全区顶部 忽略
  var safeAreatop = true.obs;

  /// 默认安全区底部 忽略
  var safeAreabottm = false.obs;

  /// 是否显示Scaffol脚手架
  var isNeedScaffol = true.obs;

  var isNeedRootContation = false.obs;

  /// 是否需要layout
  bool isNeedLayout = false;

  /// 滚动属性
  bool? resizeToAvoidBottomInset;

  /// 添加右滑返回拦截器
  bool isAddPopScope = false;
  // 配置界面是否显示 加载界面
  var isShowLoadWidget = false.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      configWidgetRenderingCompleted();
    });
    configDefault();
  }

  @override
  onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  /// 界面渲染完成
  Future<bool> configWidgetRenderingCompleted() async {
    return true;
  }

  /// 配置默认选项
  configDefault() {}
  // 点击缺省页触发事件
  tapPlaceHoldWidgetMethod({required CommonPlaceHoldType placeHoldType}) {}

  @override
  Map<String, dynamic>? configNetWorkParmas({
    String? mark,
    Map<String, dynamic>? params,
  }) {
    return null;
  }

  @override
  getNetWorkData({int? type, Map<String, dynamic>? info}) {}

  @override
  Future<bool> didPopRoute() {
    debugLog("idPopRoute");
    return super.didPopRoute();
  }

  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
    debugLog("didPushRoute");
    return super.didPushRouteInformation(routeInformation);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      debugLog("app进入前台");
      configAppLifeCycleResumed();
    } else if (state == AppLifecycleState.inactive) {
      debugLog("app在前台但不响应事件，比如电话，touch id等");
      configAppLifeCycleInactive();
    } else if (state == AppLifecycleState.paused) {
      debugLog("app进入后台");
      configAppLifeCyclePaused();
    } else if (state == AppLifecycleState.detached) {
      debugLog("没有宿主视图但是flutter引擎仍然有效");
      configAppLifeCycleDetached();
    }
  }

  ///当前系统改主题改变回调
  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    configPlatformBrightness();
  }

  /// 当前系统语言发生改变回调
  @override
  void didChangeLocales(List<Locale>? locales) {
    super.didChangeLocales(locales);
    configChangeLocales(locales);
  }

  /// ------------- 配置监听事件 ---------------- ///
  ///
  ///

  /// app进入前台
  @override
  configAppLifeCycleResumed() {}

  /// app在前台但不响应事件，比如电话，touch id等"
  @override
  configAppLifeCycleInactive() {}

  /// app进入后台
  @override
  configAppLifeCyclePaused() {}

  /// 没有宿主视图但是flutter引擎仍然有效
  @override
  configAppLifeCycleDetached() {}

  /// 主题变更事件回调
  @override
  configPlatformBrightness() {
    ThemeTool.changeTheme(isUserCache: true);
  }

  /// 语言发生改变回调
  @override
  configChangeLocales(List<Locale>? locales) {}
}

abstract class CommonGetXListController extends OceanAbsCommonGetXController
    with HzyAbstracRefreshMehod {
  EasyRefreshController? refreshController;
  bool controlFinishRefresh = true;
  bool controlFinishLoad = true;

  @override
  configDefault() {
    configRefreshController();
  }

  @override
  void configRefreshController() {
    refreshController = EasyRefreshController(
      controlFinishLoad: controlFinishLoad,
      controlFinishRefresh: controlFinishRefresh,
    );
  }

  // 上啦加载
  @override
  void configLoading() {
    page++;
    getNetWorkData(type: 2, info: configNetWorkParmas());
  }

  // 下啦刷新
  @override
  void configRefresh() {
    page = 1;
    getNetWorkData(type: 1, info: configNetWorkParmas());
  }

  // 配置结束刷新操作
  PageState configRefreshPageState({
    int? allNum,
    int? netWorkNum,
    required int type,
  }) {
    return endRefresh(
      type: type,
      state: determinePageState(
        totalCount: allNum ?? 0,
        currentPageCount: netWorkNum ?? 0,
      ),
    );
  }

  @override
  PageState endRefresh({required int type, required PageState state}) {
    return configEndRefresh(
      type: type,
      state: state,
      refreshController: refreshController,
    );
  }
}
