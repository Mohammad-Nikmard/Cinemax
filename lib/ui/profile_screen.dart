import 'dart:ui';

import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/ui/language_screen.dart';
import 'package:cinemax/ui/notifications_screen.dart';
import 'package:cinemax/ui/onboarding_screen.dart';
import 'package:cinemax/ui/privacy_screen.dart';
import 'package:cinemax/ui/profile_edit_screen.dart';
import 'package:cinemax/ui/reset_password_screen.dart';
import 'package:cinemax/util/auth_manager.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 20),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.profile,
                    style: const TextStyle(
                      fontFamily: "MSB",
                      fontSize: 16,
                      color: TextColors.whiteText,
                    ),
                  ),
                ),
              ),
            ),
            const SliverPadding(
              padding: EdgeInsets.only(bottom: 25),
              sliver: _ProfileChip(),
            ),
            const SliverPadding(
              padding: EdgeInsets.only(bottom: 25),
              sliver: _AccountChip(),
            ),
            const SliverPadding(
              padding: EdgeInsets.only(bottom: 25),
              sliver: _GeneralChip(),
            ),
            const SliverPadding(
              padding: EdgeInsets.only(bottom: 40),
              sliver: _MoreChip(),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 50),
              sliver: SliverToBoxAdapter(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 56,
                  child: OutlinedButton(
                    onPressed: () {
                      signoutDialog(context);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.logout,
                      style: const TextStyle(
                        color: PrimaryColors.blueAccentColor,
                        fontSize: 16,
                        fontFamily: "MSB",
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<void> signoutDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 30,
                ),
                SvgPicture.asset(
                  'assets/images/question_image.svg',
                  height: 125,
                  width: 125,
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  AppLocalizations.of(context)!.areSure,
                  style: const TextStyle(
                    fontFamily: "MSB",
                    fontSize: 18,
                    color: TextColors.whiteText,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  AppLocalizations.of(context)!.sureCap,
                  style: const TextStyle(
                    fontFamily: "MR",
                    fontSize: 12,
                    color: TextColors.greyText,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 60,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            AuthManager.logOut();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const OnBoardingScreen(),
                              ),
                            );
                          },
                          child: Text(
                            AppLocalizations.of(context)!.logout,
                            style: const TextStyle(
                              color: PrimaryColors.blueAccentColor,
                              fontSize: 16,
                              fontFamily: "MR",
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.cancel,
                            style: const TextStyle(
                              fontFamily: "MR",
                              fontSize: 16,
                              color: TextColors.whiteText,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class _OptionChip extends StatelessWidget {
  const _OptionChip({required this.title, required this.image, this.color});
  final String title;
  final String image;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 30,
          width: 30,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: PrimaryColors.softColor,
          ),
          child: Center(
            child: SvgPicture.asset(
              image,
              height: 20,
              width: 20,
              colorFilter: ColorFilter.mode(
                color!,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        const SizedBox(width: 15),
        Text(
          title,
          style: const TextStyle(
            fontFamily: "MM",
            fontSize: 14,
            color: TextColors.whiteText,
          ),
        ),
        const Spacer(),
        SvgPicture.asset(
          'assets/images/icon_arrow_right.svg',
          colorFilter: const ColorFilter.mode(
            PrimaryColors.blueAccentColor,
            BlendMode.srcIn,
          ),
        ),
      ],
    );
  }
}

class _GeneralChip extends StatelessWidget {
  const _GeneralChip();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 332,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.2,
            color: const Color(0xff252836),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.general,
                style: const TextStyle(
                  fontFamily: "MSB",
                  fontSize: 18,
                  color: TextColors.whiteText,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const NotificationsScreen(),
                    withNavBar: false, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                child: _OptionChip(
                  title: AppLocalizations.of(context)!.notif,
                  image: "assets/images/icon_bell.svg",
                  color: TextColors.greyText,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 1.3,
                color: Color(0xff252836),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const LanguageScreen(),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                child: _OptionChip(
                  title: AppLocalizations.of(context)!.language,
                  image: "assets/images/icon_globe.svg",
                  color: TextColors.greyText,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 1.3,
                color: Color(0xff252836),
              ),
              const SizedBox(
                height: 10,
              ),
              _OptionChip(
                title: AppLocalizations.of(context)!.country,
                image: "assets/images/icon_flag.svg",
                color: TextColors.greyText,
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 1.3,
                color: Color(0xff252836),
              ),
              const SizedBox(
                height: 10,
              ),
              _OptionChip(
                title: AppLocalizations.of(context)!.clearCache,
                image: "assets/images/icon_bin.svg",
                color: TextColors.greyText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MoreChip extends StatelessWidget {
  const _MoreChip();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 259,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.2,
            color: const Color(0xff252836),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.more,
                style: const TextStyle(
                  fontFamily: "MSB",
                  fontSize: 18,
                  color: TextColors.whiteText,
                ),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const PrivacyPolicyScreen(),
                    withNavBar: false, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                child: _OptionChip(
                  title: AppLocalizations.of(context)!.legal,
                  image: "assets/images/icon_shield.svg",
                  color: TextColors.greyText,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 1.3,
                color: Color(0xff252836),
              ),
              const SizedBox(
                height: 10,
              ),
              _OptionChip(
                title: AppLocalizations.of(context)!.help,
                image: "assets/images/icon_question.svg",
                color: TextColors.greyText,
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 1.3,
                color: Color(0xff252836),
              ),
              const SizedBox(
                height: 10,
              ),
              _OptionChip(
                title: AppLocalizations.of(context)!.about,
                image: "assets/images/icon_alert.svg",
                color: TextColors.greyText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AccountChip extends StatelessWidget {
  const _AccountChip();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 188,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.2,
            color: const Color(0xff252836),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.account,
                style: const TextStyle(
                  fontFamily: "MSB",
                  fontSize: 18,
                  color: TextColors.whiteText,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              _OptionChip(
                title: AppLocalizations.of(context)!.member,
                image: "assets/images/icon_profile.svg",
                color: PrimaryColors.blueAccentColor,
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 1.3,
                color: Color(0xff252836),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ResetPasswordScreen(),
                    ),
                  );
                },
                child: _OptionChip(
                  title: AppLocalizations.of(context)!.changePassword,
                  image: "assets/images/icon_lock.svg",
                  color: TextColors.greyText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileChip extends StatelessWidget {
  const _ProfileChip();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: const ProfileEditScreen(),
            withNavBar: true,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 86,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.2,
              color: const Color(0xff252836),
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                CircleAvatar(
                  radius:
                      (MediaQueryHandler.screenWidth(context) < 350) ? 15 : 25,
                  backgroundColor: PrimaryColors.blueAccentColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AuthManager.readId(),
                      style: TextStyle(
                        fontFamily: "MSB",
                        fontSize: (MediaQueryHandler.screenWidth(context) < 350)
                            ? 12
                            : 16,
                        color: TextColors.whiteText,
                      ),
                    ),
                    Text(
                      AuthManager.readEmail(),
                      style: TextStyle(
                        fontFamily: "MM",
                        fontSize: (MediaQueryHandler.screenWidth(context) < 350)
                            ? 10
                            : 14,
                        color: TextColors.greyText,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                SvgPicture.asset(
                  'assets/images/icon_edit_light.svg',
                  height:
                      (MediaQueryHandler.screenWidth(context) < 350) ? 14 : 24,
                  width:
                      (MediaQueryHandler.screenWidth(context) < 350) ? 14 : 24,
                  colorFilter: const ColorFilter.mode(
                    PrimaryColors.blueAccentColor,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
