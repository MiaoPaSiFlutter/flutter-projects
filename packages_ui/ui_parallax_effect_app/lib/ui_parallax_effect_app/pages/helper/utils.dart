import 'package:ocean_common_module/ocean_common_module.dart';

class Utils {
  static String assets(String assetsPath) {
    String assetsFullPath = NormalModuleUtils.configPackagesImage(
        packagename: "ui_parallax_effect_app", name: "assets/$assetsPath");
    return assetsFullPath;
  }
}
