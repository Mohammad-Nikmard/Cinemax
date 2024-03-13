import 'package:cinemax/DI/service_locator.dart';
import 'package:cinemax/bloc/home/home_event.dart';
import 'package:cinemax/bloc/home/homebloc.dart';
import 'package:cinemax/bloc/search/search_bloc.dart';
import 'package:cinemax/bloc/search/search_event.dart';
import 'package:cinemax/bloc/upcomings/upcomings_bloc.dart';
import 'package:cinemax/bloc/upcomings/upcomings_event.dart';
import 'package:cinemax/bloc/wishlist/wishlist_bloc.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/ui/home_screen.dart';
import 'package:cinemax/ui/profile_screen.dart';
import 'package:cinemax/ui/search_screen.dart';
import 'package:cinemax/ui/upcomings_screen.dart';
import 'package:cinemax/ui/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    return [
      BlocProvider(
        create: (context) {
          var bloc = HomeBloc(locator.get(), locator.get());
          bloc.add(HomeDataRequestEvent());
          return bloc;
        },
        child: const HomeScreen(),
      ),
      BlocProvider(
        create: (context) {
          var bloc = UpcomingsBloc(locator.get());
          bloc.add(UpcomingsDataRequestEvent());
          return bloc;
        },
        child: const UpcomingsScreen(),
      ),
      BlocProvider(
        create: (context) {
          var bloc = SearhcBloc(locator.get(), locator.get());
          bloc.add(SearchFetchDataEvent());
          return bloc;
        },
        child: const SearchScreen(),
      ),
      BlocProvider<WishlistBloc>(
        create: (context) => locator.get(),
        child: const WishlistScreen(),
      ),
      const ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        inactiveIcon: SvgPicture.asset(
          "assets/images/icon_home.svg",
          color: TextColors.greyText,
        ),
        icon: SvgPicture.asset(
          "assets/images/icon_home.svg",
          color: PrimaryColors.blueAccentColor,
        ),
        title: (AppLocalizations.of(context)!.home),
        textStyle: const TextStyle(fontFamily: "MM", fontSize: 12),
        activeColorPrimary: PrimaryColors.blueAccentColor,
        inactiveColorPrimary: TextColors.greyText,
      ),
      PersistentBottomNavBarItem(
        inactiveIcon: SvgPicture.asset(
          "assets/images/icon_film.svg",
          color: TextColors.greyText,
        ),
        icon: SvgPicture.asset(
          "assets/images/icon_film.svg",
          color: PrimaryColors.blueAccentColor,
        ),
        title: (AppLocalizations.of(context)!.upcomings),
        textStyle: const TextStyle(fontFamily: "MM", fontSize: 12),
        activeColorPrimary: PrimaryColors.blueAccentColor,
        inactiveColorPrimary: TextColors.greyText,
      ),
      PersistentBottomNavBarItem(
        inactiveIcon: SvgPicture.asset(
          "assets/images/icon_search.svg",
          color: TextColors.greyText,
        ),
        icon: SvgPicture.asset(
          "assets/images/icon_search.svg",
          color: PrimaryColors.blueAccentColor,
        ),
        title: (AppLocalizations.of(context)!.search),
        textStyle: const TextStyle(fontFamily: "MM", fontSize: 12),
        activeColorPrimary: PrimaryColors.blueAccentColor,
        inactiveColorPrimary: TextColors.greyText,
      ),
      PersistentBottomNavBarItem(
        inactiveIcon: SvgPicture.asset(
          "assets/images/icon_save_star.svg",
          color: TextColors.greyText,
        ),
        icon: SvgPicture.asset(
          "assets/images/icon_save_star.svg",
          color: PrimaryColors.blueAccentColor,
        ),
        title: (AppLocalizations.of(context)!.wishlist),
        textStyle: const TextStyle(fontFamily: "MM", fontSize: 12),
        activeColorPrimary: PrimaryColors.blueAccentColor,
        inactiveColorPrimary: TextColors.greyText,
      ),
      PersistentBottomNavBarItem(
        inactiveIcon: SvgPicture.asset(
          "assets/images/icon_profile.svg",
          color: TextColors.greyText,
        ),
        icon: SvgPicture.asset(
          "assets/images/icon_profile.svg",
          color: PrimaryColors.blueAccentColor,
        ),
        title: (AppLocalizations.of(context)!.profile),
        textStyle: const TextStyle(fontFamily: "MM", fontSize: 12),
        activeColorPrimary: PrimaryColors.blueAccentColor,
        inactiveColorPrimary: TextColors.greyText,
      ),
    ];
  }
}
