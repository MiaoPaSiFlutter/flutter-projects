import 'package:flutter/material.dart';

class OceanNormalTools {
  ///计算页数
  static int getPageCount(int? totalCount, int? pageSize) {
    if (totalCount != null && pageSize != null) {
      return (totalCount + pageSize - 1) ~/ pageSize;
    } else {
      return 0;
    }
  }

  ///分割数组
  static List splitList(List? items, int? subSize) {
    if (items != null && subSize != null) {
      int index = 0;
      var bigRes = [];

      for (var i = 0; i < items.length; i++) {
        if (i % subSize == 0 && i != 0) {
          // 可以被 size 整除
          bigRes.add(items.sublist(index, i));
          index = i;
        }
        if ((i + 1) == items.length) {
          bigRes.add(items.sublist(index, (i + 1)));
        }
      }
      return bigRes;
    } else {
      return [];
    }
  }

  ///设置item圆角
  static BorderRadius buildFeedCellRadius(
    int? items,
    int? index, {
    double radius = 12,
  }) {
    if (items != null && index != null) {
      Radius topLeft = Radius.zero;
      Radius topRight = Radius.zero;
      Radius bottomLeft = Radius.zero;
      Radius bottomRight = Radius.zero;
      if (index == 0) {
        ///第一个
        topLeft = topRight = Radius.circular(radius);
      } else if (index == items - 1) {
        ///最后一个
        bottomLeft = bottomRight = Radius.circular(radius);
      } else {
        ///位于中间
      }

      ///if only one item
      if (index == items - 1) {
        bottomLeft = bottomRight = Radius.circular(radius);
      }
      BorderRadius borderRadius = BorderRadius.only(
        topLeft: topLeft,
        topRight: topRight,
        bottomLeft: bottomLeft,
        bottomRight: bottomRight,
      );

      return borderRadius;
    } else {
      return BorderRadius.all(Radius.circular(radius));
    }
  }

  static showDig({
    required BuildContext context,
    required Widget widget,
    bool barrierDismissible = true,
    Color? barrierColor = Colors.black54,
  }) async {
    return await showDialog(
      barrierColor: barrierColor,
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (context) {
        return widget;
      },
    );
  }
}
