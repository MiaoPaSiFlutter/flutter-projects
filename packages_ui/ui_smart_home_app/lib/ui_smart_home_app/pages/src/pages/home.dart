import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import 'home/home_page.dart';
import '../pages/power_user.dart';
import '../pages/profile.dart';
import '../widgets/hex_color.dart';
import 'smart_home.dart';

class Home extends StatelessWidget {
  List<PersistentTabConfig> _tabs() {
    return [
      PersistentTabConfig(
        screen: HomePage(),
        item: ItemConfig(
          icon: const Icon(EvaIcons.home),
          title: ("Home"),
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
          activeForegroundColor: HexColor('#ffffff'),
          activeColorSecondary: HexColor('#4C7380'),
          inactiveForegroundColor: CupertinoColors.white,
          inactiveBackgroundColor: Colors.red,
        ),
      ),
      PersistentTabConfig(
        screen: SmartHome(),
        item: ItemConfig(
          icon: const Icon(EvaIcons.optionsOutline),
          title: ("Smart"),
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
          activeForegroundColor: HexColor('#ffffff'),
          activeColorSecondary: HexColor('#4C7380'),
          inactiveForegroundColor: CupertinoColors.white,
          inactiveBackgroundColor: Colors.red,
        ),
      ),
      PersistentTabConfig(
        screen: PowerUser(),
        item: ItemConfig(
          icon: const Icon(EvaIcons.optionsOutline),
          title: ("Usage"),
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
          activeForegroundColor: HexColor('#ffffff'),
          activeColorSecondary: HexColor('#4C7380'),
          inactiveForegroundColor: CupertinoColors.white,
          inactiveBackgroundColor: Colors.red,
        ),
      ),
      PersistentTabConfig(
        screen: ProfilePage(),
        item: ItemConfig(
          icon: const Icon(EvaIcons.optionsOutline),
          title: ("Profile"),
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
          activeForegroundColor: HexColor('#ffffff'),
          activeColorSecondary: HexColor('#4C7380'),
          inactiveForegroundColor: CupertinoColors.white,
          inactiveBackgroundColor: Colors.red,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;
    _controller = PersistentTabController(initialIndex: 0);

    return PersistentTabView(
      // context,
      controller: _controller,
      // screens: _buildScreens(),
      // items: _navBarsItems(),
      // confineInSafeArea: true,
      backgroundColor: HexColor('#4C7380'),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      // hideNavigationBarWhenKeyboardShows: true,
      // decoration: NavBarDecoration(
      //   borderRadius: BorderRadius.circular(10.0),
      //   colorBehindNavBar: Colors.white,
      // ),
      // popAllScreensOnTapOfSelectedTab: true,
      // popActionScreens: PopActionScreensType.all,
      // itemAnimationProperties: const ItemAnimationProperties(
      //   duration: Duration(milliseconds: 200),
      //   curve: Curves.ease,
      // ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      // navBarStyle: NavBarStyle.style10,
      tabs: _tabs(),
      navBarBuilder: (config) {
        return Container();
      },
    );
  }
}
