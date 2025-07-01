import 'package:ocean_common_module/utils/utils.dart';

class NormalImagePathConfit {
  /// 第一种 图片加载失败
  static String imageFail = NormalModuleUtils.normalModuleImagePath(
    name: "assets/image_failed.jpg",
  );

  /// 第二种 图片加载失败
  static String imageError = NormalModuleUtils.normalModuleImagePath(
    name: "assets/image_error.png",
  );
}
