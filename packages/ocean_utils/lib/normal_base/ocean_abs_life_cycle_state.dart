import 'package:flutter/material.dart';
import 'package:hzy_normal_tool/hzy_normal_tool.dart';

import 'ocean_abs_state.dart';

abstract class OceanAbsLifeCycleState<T extends StatefulWidget>
    extends OceanAbsState<T>
    implements HzyNormalLifeCycleAbs {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
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
    configPlatformBrightness();
  }

  /// 当前系统语言发生改变回调
  @override
  void didChangeLocales(List<Locale>? locales) {
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
  configPlatformBrightness() {}

  /// 语言发生改变回调
  @override
  configChangeLocales(List<Locale>? locales) {}
}
