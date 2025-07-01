import 'package:flutter/services.dart';

/// 界面通用属性
mixin class OceanAbsAttribute {
  /// 电池栏颜色
  final SystemUiOverlayStyle uiOverlayStyle = SystemUiOverlayStyle.dark;
}

// 配置网络请求规范
mixin class OceanAbstractNetWork {
  /// 配置网络请求参数
  /// mark 区分不同请求
  Map<String, dynamic>? configNetWorkParmas({
    String? mark,
    Map<String, dynamic>? params,
  }) {
    return null;
  }
}
