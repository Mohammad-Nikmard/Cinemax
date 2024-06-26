import 'dart:ui';
import 'package:cinemax/DI/service_locator.dart';
import 'package:cinemax/bloc/authentication/authentication_bloc.dart';
import 'package:cinemax/bloc/comments/comment_bloc.dart';
import 'package:cinemax/bloc/comments/comment_event.dart';
import 'package:cinemax/bloc/profile/profile_bloc.dart';
import 'package:cinemax/bloc/profile/profile_event.dart';
import 'package:cinemax/bloc/profile/profile_state.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/constants/string_constants.dart';
import 'package:cinemax/data/model/user.dart';
import 'package:cinemax/ui/about_us_screen.dart';
import 'package:cinemax/ui/language_screen.dart';
import 'package:cinemax/ui/notifications_screen.dart';
import 'package:cinemax/ui/onboarding_screen.dart';
import 'package:cinemax/ui/privacy_screen.dart';
import 'package:cinemax/ui/profile_edit_screen.dart';
import 'package:cinemax/ui/reset_password_screen.dart';
import 'package:cinemax/ui/theme_screen.dart';
import 'package:cinemax/ui/your_comments_screen.dart';
import 'package:cinemax/util/auth_manager.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20, top: 20),
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.profile,
                        style: TextStyle(
                          fontFamily: StringConstants.setBoldPersianFont(),
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ),
                  ),
                ),
                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileIniState) {
                      return _ProfileChip(
                        user: UserApp(
                          "",
                          "",
                          AuthManager.readName(),
                          AuthManager.readImage(),
                          AuthManager.readImage(),
                        ),
                      );
                    }

                    if (state is UserResponseState) {
                      return state.user.fold(
                        (exceptionMessage) {
                          return SliverToBoxAdapter(
                            child: Text(exceptionMessage),
                          );
                        },
                        (user) {
                          return SliverPadding(
                            padding: const EdgeInsets.only(bottom: 25),
                            sliver: _ProfileChip(user: user),
                          );
                        },
                      );
                    }
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text(AppLocalizations.of(context)!.state),
                      ),
                    );
                  },
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
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16,
                            fontFamily: StringConstants.setBoldPersianFont(),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
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
                  style: TextStyle(
                    fontFamily: StringConstants.setBoldPersianFont(),
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  AppLocalizations.of(context)!.sureCap,
                  style: TextStyle(
                    fontFamily: StringConstants.setSmallPersionFont(),
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
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 16,
                              fontFamily: StringConstants.setSmallPersionFont(),
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
                            style: TextStyle(
                              fontFamily: StringConstants.setSmallPersionFont(),
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.tertiary,
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
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.secondary,
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
          style: TextStyle(
            fontFamily: StringConstants.setMediumPersionFont(),
            fontSize: 14,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        const Spacer(),
        SvgPicture.asset(
          'assets/images/icon_arrow_right.svg',
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.primary,
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
        height: 322,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.2,
            color: Theme.of(context).colorScheme.primaryContainer,
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
                style: TextStyle(
                  fontFamily: StringConstants.setBoldPersianFont(),
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.tertiary,
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
              Divider(
                thickness: 1.3,
                color: Theme.of(context).colorScheme.primaryContainer,
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
              Divider(
                thickness: 1.3,
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: BlocProvider(
                      create: (context) =>
                          CommentsBloc(locator.get(), locator.get())
                            ..add(
                              FetchUserComments(
                                AuthManager.readRecordID(),
                              ),
                            ),
                      child: const YourCommentsScreen(),
                    ),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                child: _OptionChip(
                  title: AppLocalizations.of(context)!.yourComments,
                  image: "assets/images/icon_comment.svg",
                  color: TextColors.greyText,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1.3,
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const ThemeScreen(),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                child: _OptionChip(
                  title: AppLocalizations.of(context)!.themes,
                  image: "assets/images/icon_theme.svg",
                  color: TextColors.greyText,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MoreChip extends StatefulWidget {
  const _MoreChip();

  @override
  State<_MoreChip> createState() => _MoreChipState();
}

class _MoreChipState extends State<_MoreChip> {
  double rate = 2;
  final TextEditingController feedbackController = TextEditingController();

  @override
  void dispose() {
    feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 259,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.2,
            color: Theme.of(context).colorScheme.primaryContainer,
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
                style: TextStyle(
                  fontFamily: StringConstants.setBoldPersianFont(),
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.tertiary,
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
              Divider(
                thickness: 1.3,
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    barrierColor: Colors.transparent,
                    context: context,
                    builder: (context) => BlocProvider(
                      create: (context) => ProfileBloc(locator.get()),
                      child: helpFeedbackPage(context),
                    ),
                  );
                },
                child: _OptionChip(
                  title: AppLocalizations.of(context)!.help,
                  image: "assets/images/icon_question.svg",
                  color: TextColors.greyText,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1.3,
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const AboutUsScreen(),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                child: _OptionChip(
                  title: AppLocalizations.of(context)!.about,
                  image: "assets/images/icon_alert.svg",
                  color: TextColors.greyText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget helpFeedbackPage(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
      child: Container(
        height: 500,
        width: MediaQueryHandler.screenWidth(context),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 25, right: 15, left: 15),
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.help,
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.tertiary,
                  fontFamily: StringConstants.setBoldPersianFont(),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                AppLocalizations.of(context)!.yourOpinion,
                style: TextStyle(
                  fontFamily: StringConstants.setSmallPersionFont(),
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                glow: true,
                glowColor: Theme.of(context).colorScheme.secondaryContainer,
                glowRadius: 0.3,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    rate = rating;
                  });
                },
              ),
              const SizedBox(height: 10),
              TextField(
                maxLines: 8,
                controller: feedbackController,
                style: TextStyle(
                  fontFamily: StringConstants.setMediumPersionFont(),
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.infromText,
                  hintStyle: TextStyle(
                    fontSize: 12,
                    color: TextColors.greyText,
                    fontFamily: StringConstants.setSmallPersionFont(),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    borderSide: BorderSide(
                      width: 1.5,
                      color: TextColors.greyText,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    borderSide: BorderSide(
                      width: 1.5,
                      color: TextColors.darkGreyText,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              BlocConsumer<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileIniState) {
                    return SizedBox(
                      height: 52,
                      width: MediaQueryHandler.screenWidth(context),
                      child: ElevatedButton(
                        onPressed: () {
                          if (feedbackController.text.isNotEmpty) {
                            context.read<ProfileBloc>().add(SendFeedbackEvent(
                                rate, feedbackController.text.trim()));
                          }
                        },
                        child: Text(
                          AppLocalizations.of(context)!.submit,
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.tertiary,
                            fontFamily: StringConstants.setMediumPersionFont(),
                          ),
                        ),
                      ),
                    );
                  } else if (state is ProfileLoadingState) {
                    return Center(
                      child: SizedBox(
                        height: 55,
                        width: 55,
                        child: LoadingIndicator(
                          indicatorType: Indicator.pacman,
                          colors: [Theme.of(context).colorScheme.primary],
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    );
                  } else if (state is ProfileResponseState) {
                    return SizedBox(
                      height: 52,
                      width: MediaQueryHandler.screenWidth(context),
                      child: ElevatedButton(
                        onPressed: () {
                          if (feedbackController.text.isNotEmpty) {
                            context.read<ProfileBloc>().add(SendFeedbackEvent(
                                rate, feedbackController.text.trim()));
                          }
                        },
                        child: Text(
                          AppLocalizations.of(context)!.submit,
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.tertiary,
                            fontFamily: StringConstants.setMediumPersionFont(),
                          ),
                        ),
                      ),
                    );
                  }
                  return Center(
                    child: Text(AppLocalizations.of(context)!.state),
                  );
                },
                listener: (context, state) {
                  if (state is ProfileResponseState) {
                    feedbackController.text = "";
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AccountChip extends StatelessWidget {
  const AccountChip({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 138,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.2,
            color: Theme.of(context).colorScheme.primaryContainer,
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
                style: TextStyle(
                  fontFamily: StringConstants.setBoldPersianFont(),
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1.3,
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: BlocProvider(
                      create: (context) => AuthBloc(
                        locator.get(),
                      ),
                      child: const ResetPasswordScreen(),
                    ),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
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

class _ProfileChip extends StatefulWidget {
  const _ProfileChip({required this.user});
  final UserApp user;

  @override
  State<_ProfileChip> createState() => _ProfileChipState();
}

class _ProfileChipState extends State<_ProfileChip> {
  String? result;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () async {
          result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => ProfileBloc(locator.get()),
                child: ProfileEditScreen(
                  user: widget.user,
                ),
              ),
            ),
          );
          if (result != null) {
            if (context.mounted) {
              context.read<ProfileBloc>().add(GetuserEvent());
            }
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 86,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.2,
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(100),
                  ),
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: (widget.user.profile.isEmpty)
                          ? SvgPicture.asset(
                              'assets/images/icon_user.svg',
                              colorFilter: ColorFilter.mode(
                                Theme.of(context).colorScheme.tertiary,
                                BlendMode.srcIn,
                              ),
                            )
                          : CachedImage(
                              imageUrl: widget.user.imagePath,
                              radius: 100,
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.user.name,
                      style: TextStyle(
                        fontFamily: StringConstants.setBoldPersianFont(),
                        fontSize: (MediaQueryHandler.screenWidth(context) < 350)
                            ? 12
                            : 16,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    SizedBox(
                      width: 230,
                      child: Text(
                        AuthManager.readEmail(),
                        style: TextStyle(
                          fontFamily: StringConstants.setMediumPersionFont(),
                          fontSize:
                              (MediaQueryHandler.screenWidth(context) < 350)
                                  ? 10
                                  : 14,
                          color: TextColors.greyText,
                        ),
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
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.primary,
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
