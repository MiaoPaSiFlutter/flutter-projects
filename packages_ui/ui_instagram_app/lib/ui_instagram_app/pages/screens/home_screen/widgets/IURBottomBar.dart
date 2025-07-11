import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helpers/helpers_index.dart';
import '../../controller/screens_handler_controller.dart';

class IURBottomBar extends StatelessWidget {
  const IURBottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ScreensHandlerController>(
      builder: (controller) {
        return BottomNavigationBar(
          key: const Key('bottomNavigationBar'),
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (index) {
            controller.showScreenWithIndexOf(index);
          },
          items: <BottomNavigationBarItem>[
            ...List.generate(
              bottomNavigationItems.length,
              (index) => BottomNavigationBarItem(
                label: bottomNavigationItems[index]['label'],
                icon: bottomNavigationItems[index]['profileImg'] != null
                    ? CircleAvatar(
                        radius:
                            bottomNavigationItems[index]['radius'] as double,
                        backgroundImage: AssetImage(
                            bottomNavigationItems[index]['profileImg']),
                      )
                    : SvgIconsHelper.fromSvg(
                        svgPath: bottomNavigationItems[index]['svgPath'],
                        semanticLabel: bottomNavigationItems[index]
                            ['semanticLabel'],
                        color: bottomNavigationItems[index]['color'],
                      ),
              ),
            )
          ],
        );
      },
    );
  }
}
