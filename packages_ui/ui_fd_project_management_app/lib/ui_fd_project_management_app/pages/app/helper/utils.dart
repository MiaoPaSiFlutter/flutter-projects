import 'package:ocean_common_module/ocean_common_module.dart';

class Utils {
  static String assets(String assetsPath) {
    String assetsFullPath = NormalModuleUtils.configPackagesImage(
        packagename: "ui_fd_project_management_app",
        name: "assets/$assetsPath");
    return assetsFullPath;
  }
}
