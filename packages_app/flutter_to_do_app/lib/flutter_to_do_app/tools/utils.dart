import 'package:ocean_common_module/ocean_common_module.dart';

class Utils {
  static String assets(String assetsPath) {
    String assetsFullPath = NormalModuleUtils.configPackagesImage(
        packagename: "flutter_to_do_app", name: "assets/$assetsPath");
    return assetsFullPath;
  }
}
// Utils.assets('