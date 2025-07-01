import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:ocean_utils/ocean_utils.dart';
import 'ocean_abs_common_getx_controller.dart';
import 'ocean_abs_common_getx_widget.dart';
import '../common_refresh_widgets.dart';

abstract class OceanAbsCommonGetXListWidget<T extends CommonGetXListController>
    extends OceanAbsCommonGetXWidget<T>
    with HzyAbstracRefreshWidget {
  OceanAbsCommonGetXListWidget({super.key});

  @override
  Widget createBody({
    required BuildContext context,
    BoxConstraints? constraints,
  }) {
    return createRefreshWidget(context);
  }

  @override
  Widget createRefreshWidget(BuildContext context) {
    Widget body = EasyRefresh(
      key: key,
      controller: controller.refreshController,
      onRefresh: () async {
        controller.configRefresh();
      },
      onLoad: () async {
        controller.configLoading();
      },
      header: createHeader(),
      footer: createFooter(),
      child: createListView(context),
    );
    return body;
  }

  /// 创建列表 item
  @override
  Widget createListitem(BuildContext context, int index) {
    return Container();
  }

  @override
  Header? createHeader() {
    return CommonRefreshWidget.configHeader();
  }

  @override
  Footer? createFooter() {
    return CommonRefreshWidget.configFooter();
  }
}
