
import 'package:flutter/material.dart';

import 'stick_render.dart';

class CommonStickWidget extends MultiChildRenderObjectWidget {
  ///顺序添加 stickHeader 和 stickContent
  CommonStickWidget({
    super.key,
    required stickHeader,
    required stickContent,
  }) : super(
          ///如果反过来，会有意想不到的效果哦
          children: [stickContent, stickHeader],
        );

  @override
  StickRender createRenderObject(BuildContext context) {
    ///传入 ScrollableState
    return StickRender(scrollable: Scrollable.of(context));
  }

  @override
  void updateRenderObject(BuildContext context, StickRender renderObject) {
    renderObject.scrollable = Scrollable.of(context);
  }
}
