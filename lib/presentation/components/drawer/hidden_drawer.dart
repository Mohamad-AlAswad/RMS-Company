// not used
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import '../../pages/jobs/jobs.dart';
import '../../pages/profile/profile.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({Key? key}) : super(key: key);

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  List <ScreenHiddenDrawer> _pages = [];

  TextStyle textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 22,
  );


  @override
  void initState() {
    super.initState();
    _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Jobs',
          baseStyle: textStyle,
          selectedStyle: textStyle.copyWith(fontWeight: FontWeight.bold),
          colorLineSelected: Colors.redAccent,
        ),
        Jobs(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Profile',
          baseStyle: textStyle,
          selectedStyle: textStyle,
          colorLineSelected: Colors.redAccent,
        ),
        Profile(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'MailBox',
          baseStyle: textStyle,
          selectedStyle: textStyle,
          colorLineSelected: Colors.redAccent,
        ),
        Profile(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Reports',
          baseStyle: textStyle,
          selectedStyle: textStyle,
          colorLineSelected: Colors.redAccent,
        ),
        Profile(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'About',
          baseStyle: textStyle,
          selectedStyle: textStyle,
          colorLineSelected: Colors.redAccent,
        ),
        Profile(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Log-Out',
          baseStyle: textStyle,
          selectedStyle: textStyle,
          colorLineSelected: Colors.redAccent,
        ),
        Profile(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      curveAnimation: Curves.easeInExpo,
      disableAppBarDefault: true,
      slidePercent: 40,
      screens: _pages,
      backgroundColorMenu: Colors.red.shade200,
      initPositionSelected: 0,
    );
  }

}
