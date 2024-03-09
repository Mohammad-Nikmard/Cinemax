import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/ui/home_screen.dart';
import 'package:cinemax/ui/profile_screen.dart';
import 'package:cinemax/ui/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      navBarHeight: 60,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: PrimaryColors.darkColor,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.decelerate,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.decelerate,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style9,
    );
  }

  List<Widget> _buildScreens() {
    return const [
      HomeScreen(),
      SearchScreen(),
      ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        inactiveIcon: Image.asset(
          'assets/images/icon_home.png',
          color: TextColors.greyText,
        ),
        icon: Image.asset(
          'assets/images/icon_home.png',
          color: PrimaryColors.blueAccentColor,
        ),
        title: ("Home"),
        textStyle: const TextStyle(fontFamily: "MM", fontSize: 12),
        activeColorPrimary: PrimaryColors.blueAccentColor,
        inactiveColorPrimary: TextColors.greyText,
      ),
      PersistentBottomNavBarItem(
        inactiveIcon: Image.asset(
          'assets/images/icon_search.png',
          color: TextColors.greyText,
        ),
        icon: Image.asset(
          'assets/images/icon_search.png',
          color: PrimaryColors.blueAccentColor,
        ),
        title: ("Search"),
        textStyle: const TextStyle(fontFamily: "MM", fontSize: 12),
        activeColorPrimary: PrimaryColors.blueAccentColor,
        inactiveColorPrimary: TextColors.greyText,
      ),
      PersistentBottomNavBarItem(
        inactiveIcon: Image.asset(
          'assets/images/icon_profile.png',
          color: TextColors.greyText,
        ),
        icon: Image.asset(
          'assets/images/icon_profile.png',
          color: PrimaryColors.blueAccentColor,
        ),
        title: ("Profile"),
        textStyle: const TextStyle(fontFamily: "MM", fontSize: 12),
        activeColorPrimary: PrimaryColors.blueAccentColor,
        inactiveColorPrimary: TextColors.greyText,
      ),
    ];
  }
}
