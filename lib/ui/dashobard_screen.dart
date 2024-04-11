import 'package:cinemax/DI/service_locator.dart';
import 'package:cinemax/bloc/home/home_event.dart';
import 'package:cinemax/bloc/home/homebloc.dart';
import 'package:cinemax/bloc/profile/profile_bloc.dart';
import 'package:cinemax/bloc/profile/profile_event.dart';
import 'package:cinemax/bloc/search/search_bloc.dart';
import 'package:cinemax/bloc/search/search_event.dart';
import 'package:cinemax/bloc/upcomings/upcomings_bloc.dart';
import 'package:cinemax/bloc/upcomings/upcomings_event.dart';
import 'package:cinemax/bloc/wishlist/wishlist_bloc.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/constants/string_constants.dart';
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
    return Directionality(
      textDirection: TextDirection.ltr,
      child: PersistentTabView(
        context,
        controller: _controller,
        navBarHeight: 60,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Theme.of(context).colorScheme.background,
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
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      BlocProvider(
        create: (context) =>
            HomeBloc(locator.get(), locator.get(), locator.get(), locator.get())
              ..add(HomeDataRequestEvent()),
        child: const HomeScreen(),
      ),
      BlocProvider(
        create: (context) =>
            UpcomingsBloc(locator.get())..add(UpcomingsDataRequestEvent()),
        child: const UpcomingsScreen(),
      ),
      BlocProvider(
        create: (context) => SearchBloc(locator.get(), locator.get())
          ..add(SearchFetchDataEvent()),
        child: const SearchScreen(),
      ),
      BlocProvider<WishlistBloc>(
        create: (context) => locator.get(),
        child: const WishlistScreen(),
      ),
      BlocProvider(
        create: (context) => ProfileBloc(locator.get())..add(GetuserEvent()),
        child: const ProfileScreen(),
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        inactiveIcon: SvgPicture.asset(
          "assets/images/icon_home.svg",
          colorFilter:
              const ColorFilter.mode(TextColors.greyText, BlendMode.srcIn),
        ),
        icon: SvgPicture.asset(
          "assets/images/icon_home.svg",
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.primary,
            BlendMode.srcIn,
          ),
        ),
        title: (AppLocalizations.of(context)!.home),
        textStyle: TextStyle(
          fontFamily: StringConstants.setMediumPersionFont(),
          fontSize: 12,
        ),
        activeColorPrimary: Theme.of(context).colorScheme.primary,
        inactiveColorPrimary: TextColors.greyText,
      ),
      PersistentBottomNavBarItem(
        inactiveIcon: SvgPicture.asset(
          "assets/images/icon_film.svg",
          colorFilter:
              const ColorFilter.mode(TextColors.greyText, BlendMode.srcIn),
        ),
        icon: SvgPicture.asset(
          "assets/images/icon_film.svg",
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.primary,
            BlendMode.srcIn,
          ),
        ),
        title: (AppLocalizations.of(context)!.upcomings),
        textStyle: TextStyle(
          fontFamily: StringConstants.setMediumPersionFont(),
          fontSize: 12,
        ),
        activeColorPrimary: Theme.of(context).colorScheme.primary,
        inactiveColorPrimary: TextColors.greyText,
      ),
      PersistentBottomNavBarItem(
        inactiveIcon: SvgPicture.asset(
          "assets/images/icon_search.svg",
          colorFilter:
              const ColorFilter.mode(TextColors.greyText, BlendMode.srcIn),
        ),
        icon: SvgPicture.asset(
          "assets/images/icon_search.svg",
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.primary,
            BlendMode.srcIn,
          ),
        ),
        title: (AppLocalizations.of(context)!.search),
        textStyle: TextStyle(
          fontFamily: StringConstants.setMediumPersionFont(),
          fontSize: 12,
        ),
        activeColorPrimary: Theme.of(context).colorScheme.primary,
        inactiveColorPrimary: TextColors.greyText,
      ),
      PersistentBottomNavBarItem(
        inactiveIcon: SvgPicture.asset(
          "assets/images/icon_save_star.svg",
          colorFilter:
              const ColorFilter.mode(TextColors.greyText, BlendMode.srcIn),
        ),
        icon: SvgPicture.asset(
          "assets/images/icon_save_star.svg",
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.primary,
            BlendMode.srcIn,
          ),
        ),
        title: (AppLocalizations.of(context)!.wishlist),
        textStyle: TextStyle(
          fontFamily: StringConstants.setMediumPersionFont(),
          fontSize: 12,
        ),
        activeColorPrimary: Theme.of(context).colorScheme.primary,
        inactiveColorPrimary: TextColors.greyText,
      ),
      PersistentBottomNavBarItem(
        inactiveIcon: SvgPicture.asset(
          "assets/images/icon_profile.svg",
          colorFilter:
              const ColorFilter.mode(TextColors.greyText, BlendMode.srcIn),
        ),
        icon: SvgPicture.asset(
          "assets/images/icon_profile.svg",
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.primary,
            BlendMode.srcIn,
          ),
        ),
        title: (AppLocalizations.of(context)!.profile),
        textStyle: TextStyle(
          fontFamily: StringConstants.setMediumPersionFont(),
          fontSize: 12,
        ),
        activeColorPrimary: Theme.of(context).colorScheme.primary,
        inactiveColorPrimary: TextColors.greyText,
      ),
    ];
  }
}
