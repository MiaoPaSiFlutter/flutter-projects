import 'package:ocean_common_module/ocean_common_module.dart';

class Utils {
  static String assets(String assetsPath) {
    String assetsFullPath = NormalModuleUtils.configPackagesImage(
        packagename: "ui_smart_home_animated_app",
        name: "assets/$assetsPath");
    return assetsFullPath;
  }
}
//Utils.assets("