import 'package:ocean_common_module/ocean_common_module.dart';

class Utils {
  static String assets(String assetsPath) {
    String assetsFullPath = NormalModuleUtils.configPackagesImage(
        packagename: "flutter_foodhub_app", name: "assets/$assetsPath");
    return assetsFullPath;
  }
}

// Utils.assets("