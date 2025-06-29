import 'package:flutter/material.dart';
import 'package:hzy_common_module/hzy_common_module.dart';

import 'mpsf_discover_page.dart';

class DiscoverView extends CommonGetXWidget<DiscoverController> {
  DiscoverView({Key? key}) : super(key: key);
  @override
  bool configIsShowAppBar() => false;
  @override
  DiscoverController get controller => Get.put(DiscoverController());
  @override
  Widget createScallBody(
      {required BuildContext context, BoxConstraints? constraints}) {
    return const MpsfDiscoverPage();
  }
}

class DiscoverController extends CommonGetXController {
  final count = 0.obs;

  void increment() => count.value++;
}
