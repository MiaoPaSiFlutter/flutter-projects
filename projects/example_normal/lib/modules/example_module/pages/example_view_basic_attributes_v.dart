/*
 * @Descripttion: 
 * @version: 
 * @Author: TT
 * @Date: 2023-05-11 14:10:38
 * @LastEditors: TT
 * @LastEditTime: 2023-05-11 14:15:59
 */

import 'package:flutter/material.dart';
import 'package:ocean_common_module/ocean_common_module.dart';

class ExampleViewBasicAttributesV
    extends OceanAbsCommonGetXWidget<ExampleViewBasicAttributesC> {
  ExampleViewBasicAttributesV({super.key});
  @override
  ExampleViewBasicAttributesC get controller =>
      Get.put(ExampleViewBasicAttributesC());

  @override
  Widget createScallBody(
      {required BuildContext context, BoxConstraints? constraints}) {
    Widget body = Container();
    return body;
  }
}

class ExampleViewBasicAttributesC extends OceanAbsCommonGetXController{
  // --------- 属性 --------- //

  // --------- 生命周期  --------- //

  // --------- 数据处理  --------- //

  // --------- 触发事件  --------- //
}
