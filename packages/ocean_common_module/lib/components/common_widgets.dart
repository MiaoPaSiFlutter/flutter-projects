import 'package:flutter/material.dart';
import 'package:ocean_common_module/ocean_common_module.dart';
import '../config/ocean_common_image_config.dart';

/// 创建加载动画
Widget configLoadWidget({Size? size}) {
  return SizedBox(
    width: size?.width ?? 100,
    height: size?.height ?? 100,
    child: Image.asset(
      NormalModuleUtils.normalModuleImagePath(name: "assets/loadingg.gif"),
      fit: BoxFit.scaleDown,
    ),
  );
}

// 创建通用关闭按钮
createNormalCloseBtnWidget({
  required BuildContext context,
  double? size = 24,
  Color? iconColor = const Color.fromRGBO(71, 83, 109, 1),
  Function? onTapClose,
  bool isPosition = true,
}) {
  Widget body = Icon(Icons.close, size: size, color: iconColor);
  body = InkWell(
    onTap: () {
      currentGoback();
      if (onTapClose != null) {
        onTapClose();
      }
    },
    child: SizedBox(width: 40, height: 40, child: body),
  );
  if (isPosition) {
    body = Positioned(right: 0, top: 0, child: body);
  }
  return body;
}

// 创建设备网络图片
Widget creatDeviceNetWorkImage({
  required bool isNocarObu,
  required double width,
  required double height,
}) {
  return Image.network(isNocarObu ? '' : '', width: width, height: height);
}

/// 创建通用Card 内边距 12.w
Widget createNormalCardWidget({
  required Widget body,
  double? paddingW,
  double? marginW,
  Color bgColor = Colors.white,
  Decoration? decoration,
  double radius = 12,
  EdgeInsetsGeometry? padding,
  EdgeInsetsGeometry? margin,
}) {
  return Container(
    decoration:
        decoration ??
        BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius.r),
        ),
    width: SizeMacro.screenWidth,
    padding:
        padding ??
        EdgeInsets.only(
          left: paddingW ?? 16.w,
          right: paddingW ?? 16.w,
          top: paddingW ?? 16.w,
        ),
    margin:
        margin ??
        EdgeInsets.only(
          left: marginW ?? 12.w,
          right: marginW ?? 12.w,
          top: marginW ?? 12.w,
        ),
    child: body,
  );
}

// 空数据动图
Widget createNoDataWidget() {
  return Container(
    width: 200,
    height: 200,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
    child: Image.asset(
      NormalModuleUtils.normalModuleImagePath(name: "assets/img_record.png"),
      fit: BoxFit.scaleDown,
    ),
  );
}

/// 创建主题色阴影
BoxShadow configThemeShadow({int opacity = 204}) {
  return BoxShadow(
    color: OceanCommonColor().colthemes.withAlpha(opacity),
    offset: const Offset(0, 3),
    blurRadius: 10,
    spreadRadius: 0,
  );
}

/// 创建灰色阴影
BoxShadow configShadow({int opacity = 102}) {
  return BoxShadow(
    color: OceanCommonColor().colc3c3c3.withAlpha(opacity),
    offset: const Offset(0, 0),
    blurRadius: 10.0,
    spreadRadius: 0,
  );
}

/// 创建通用nav 背景图
Widget configNavImageBg() {
  Widget body = Image.asset(
    OceanCommonImagePathConfig().configImagePath(
      pathkey: OceanCommonImageIdConfig.navBgImg,
    ),
    fit: BoxFit.fill,
    width: SizeMacro.screenWidth,
    height: SizeMacro.navh,
  );
  return body;
}

/// 创建包含深色模式Item
Widget configNormalDarkItemWidget({
  required HzyNormalItemModel itemModel,
  int? index,
  int? allNum,
  double radius = 16,
  bool isShowLine = true,
  ItemTapCallback? onOtherTap,
  ItemTapCallback? onTap,
}) {
  itemModel.leftMsgColor = OceanCommonColor().wbgblacktextcolor;
  if (itemModel.isHintWidget == false) {
    itemModel.backGroudColor = OceanCommonColor().whitebackgroundColor;
  } else {
    itemModel.backGroudColor = OceanCommonColor().backgroudgrey;
  }
  if (index == 0 && radius != 0) {
    itemModel.borderRadius = BorderRadius.vertical(
      top: Radius.circular(radius),
    );
  }
  itemModel.isShowLine = isShowLine;
  if (index != null && allNum != null) {
    if (index == allNum - 1) {
      itemModel.isShowLine = false;
      if (radius != 0) {
        itemModel.borderRadius = BorderRadius.vertical(
          bottom: Radius.circular(radius),
        );
      }
    }
  }
  if (index == 0 && allNum == 1 && radius != 0) {
    itemModel.borderRadius = BorderRadius.circular(radius);
  }
  itemModel.lineColor = OceanCommonColor().linecolor;
  Widget body = HzyNormalItemWidget(
    itemModel: itemModel,
    tapItemCallback: (itemModel, iex) {
      if (itemModel.tapType == 1 && itemModel.router != null) {
        if (onTap != null) {
          onTap(itemModel, iex);
        } else {
          currentToPage(itemModel.router!, arguments: itemModel);
        }
      } else {
        if (onOtherTap != null) {
          onOtherTap(itemModel, iex);
        }
      }
    },
  );
  return body;
}

/// 创建通用勾选按钮
configNormalCheckBoxWidget({
  bool isSelcet = false,
  double? size,
  Color? color,
}) {
  IconData? icon = Icons.radio_button_unchecked;

  if (isSelcet) icon = Icons.check_circle_rounded;
  Widget body = Icon(icon, size: size, color: color);
  return body;
}
