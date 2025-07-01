extension OceanStringExtensions on String? {
  /// 检查字符串是否为 null 或空
  bool get isNullOrEmpty => this?.isEmpty ?? true;

  /// 如果为 null 或空，则返回默认值
  String orElse({String placeholder = ""}) =>
      this!.isNullOrEmpty ? placeholder : this!;
}
