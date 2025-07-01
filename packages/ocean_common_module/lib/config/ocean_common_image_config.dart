import 'package:ocean_common_module/config/ocean_theme_abs.dart';
import 'package:ocean_common_module/utils/utils.dart';

class OceanCommonImageIdConfig {
  static String navBgImg = "navBgImg";
}

class OceanCommonImagePathConfig extends OceanImageAbs {
  @override
  Map<String, String> get lightInfo => {
    OceanCommonImageIdConfig.navBgImg: NormalModuleUtils.normalModuleImagePath(
      name: "assets/common_nav.png",
    ),
  };

  @override
  Map<String, String> get darkInfo => {
    OceanCommonImageIdConfig.navBgImg: NormalModuleUtils.normalModuleImagePath(
      name: "assets/dark_common_nav.png",
    ),
  };
}
