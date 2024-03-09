import 'dart:ui';

import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/ui/language_screen.dart';
import 'package:cinemax/ui/notifications_screen.dart';
import 'package:cinemax/ui/privacy_screen.dart';
import 'package:cinemax/ui/profile_edit_screen.dart';
import 'package:cinemax/ui/reset_password_screen.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

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
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(bottom: 20, top: 20),
                child: Center(
                  child: Text(
                    "Profile",
                    style: TextStyle(
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
                    child: const Text(
                      "Log Out",
                      style: TextStyle(
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
                Image.asset(
                  'assets/images/question_image.png',
                  height: 125,
                  width: 125,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Are you sure?",
                  style: TextStyle(
                    fontFamily: "MSB",
                    fontSize: 18,
                    color: TextColors.whiteText,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "you will be signing out if click on logout",
                  style: TextStyle(
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
                          onPressed: () {},
                          child: const Text(
                            "Log Out",
                            style: TextStyle(
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
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
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
            child: Image.asset(
              image,
              color: color,
              height: 20,
              width: 20,
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
        Image.asset(
          'assets/images/icon_arrow_right.png',
          color: PrimaryColors.blueAccentColor,
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
              const Text(
                "General",
                style: TextStyle(
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
                child: const _OptionChip(
                  title: "Notification",
                  image: "assets/images/icon_bell.png",
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
                child: const _OptionChip(
                  title: "Language",
                  image: "assets/images/icon_globe.png",
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
              const _OptionChip(
                title: "Country",
                image: "assets/images/icon_flag.png",
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
              const _OptionChip(
                title: "Clear Cache",
                image: "assets/images/icon_bin.png",
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
              const Text(
                "More",
                style: TextStyle(
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
                child: const _OptionChip(
                  title: "Legal and Policies",
                  image: "assets/images/icon_shield.png",
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
              const _OptionChip(
                title: "Help & Feedback",
                image: "assets/images/icon_question.png",
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
              const _OptionChip(
                title: "About Us",
                image: "assets/images/icon_alert.png",
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
              const Text(
                "Account",
                style: TextStyle(
                  fontFamily: "MSB",
                  fontSize: 18,
                  color: TextColors.whiteText,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const _OptionChip(
                title: "Member",
                image: "assets/images/icon_profile.png",
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
                child: const _OptionChip(
                  title: "Change Password",
                  image: "assets/images/icon_lock.png",
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
            withNavBar: true, // OPTIONAL VALUE. True by default.
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
                      "Mohammad",
                      style: TextStyle(
                        fontFamily: "MSB",
                        fontSize: (MediaQueryHandler.screenWidth(context) < 350)
                            ? 12
                            : 16,
                        color: TextColors.whiteText,
                      ),
                    ),
                    Text(
                      "mnikmard1344@gmail.com",
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
                Image.asset(
                  'assets/images/icon_edit_light.png',
                  color: PrimaryColors.blueAccentColor,
                  height:
                      (MediaQueryHandler.screenWidth(context) < 350) ? 14 : 24,
                  width:
                      (MediaQueryHandler.screenWidth(context) < 350) ? 14 : 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
