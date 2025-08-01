import 'package:flutter/material.dart';
import 'package:ocean_common_module/ocean_common_module.dart';

import 'models.dart';

class Utils {
  static String getImgPath(String name, {String format = 'png'}) {
    return NormalModuleUtils.configPackagesImage(
        packagename: 'flutter_jd',
        name: 'assets/azlistview/images/$name.$format');
  }

  static void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  static Widget getSusItem(BuildContext context, String tag,
      {double susHeight = 40}) {
    if (tag == '★') {
      tag = '★ 热门城市';
    }
    return Container(
      height: susHeight,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 16.0),
      color: const Color(0xFFF3F4F5),
      alignment: Alignment.centerLeft,
      child: Text(
        tag,
        softWrap: false,
        style: const TextStyle(
          fontSize: 14.0,
          color: Color(0xFF666666),
        ),
      ),
    );
  }

  static Widget getListItem(BuildContext context, CityModel model,
      {double susHeight = 40}) {
    return ListTile(
      title: Text(model.name),
      onTap: () {
        print("onItemClick : $model");
        Utils.showSnackBar(context, 'onItemClick : ${model.name}');
      },
    );
  }
}
