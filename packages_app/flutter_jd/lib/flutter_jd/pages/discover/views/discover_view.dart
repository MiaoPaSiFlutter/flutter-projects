import 'package:flutter/material.dart';
import 'package:ocean_common_module/ocean_common_module.dart';

import 'mpsf_discover_page.dart';

class DiscoverView extends OceanAbsCommonGetXWidget<DiscoverController> {
  DiscoverView({super.key});
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

class DiscoverController extends OceanAbsCommonGetXController{
  final count = 0.obs;

  void increment() => count.value++;
}
