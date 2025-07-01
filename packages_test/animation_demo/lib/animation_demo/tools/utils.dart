import 'package:ocean_common_module/ocean_common_module.dart';

class Utils {
  static String assets(String assetsPath) {
    String assetsFullPath = NormalModuleUtils.configPackagesImage(
        packagename: "animation_demo", name: "assets/$assetsPath");
    return assetsFullPath;
  }
}
