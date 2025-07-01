import 'package:ocean_utils/ocean_utils.dart';

import '../utils/theme_tool.dart';

abstract class HzyImageAbs extends AbsThemeImagePathConfig {
  @override
  bool loadThemeModel() {
    return ThemeTool.isdark();
  }
}

abstract class HzyColorAbs extends AbsThemeColorConfig {
  @override
  bool loadThemeModel() {
    return ThemeTool.isdark();
  }
}
