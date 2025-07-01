import 'package:flutter/material.dart';
import 'package:hzy_normal_tool/hzy_normal_tool.dart';

import 'ocean_abs_life_cycle_state.dart';

abstract class OceanAbsLisState<T extends StatefulWidget>
    extends OceanAbsLifeCycleState<T>
    with HzyAbstracRefreshWidget, HzyAbstracRefreshMehod {
  @override
  Widget createBody({
    required BuildContext context,
    BoxConstraints? constraints,
  }) {
    return createRefreshWidget(context);
  }

  /// 创建列表 item
  @override
  Widget createListitem(BuildContext context, int index) {
    return Container();
  }

  /// 创建缺省页界面
  @override
  Widget? createEmptyWidget();
}
