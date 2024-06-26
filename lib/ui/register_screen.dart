import 'package:cinemax/bloc/authentication/authentication_bloc.dart';
import 'package:cinemax/bloc/authentication/authentication_event.dart';
import 'package:cinemax/bloc/authentication/authentication_state.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/constants/string_constants.dart';
import 'package:cinemax/ui/dashobard_screen.dart';
import 'package:cinemax/ui/onboarding_screen.dart';
import 'package:cinemax/ui/privacy_screen.dart';
import 'package:cinemax/util/app_manager.dart';
import 'package:cinemax/util/auth_manager.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/back_label.dart';
import 'package:cinemax/widgets/loading_indicator.dart';
import 'package:cinemax/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final pwController = TextEditingController();
  final pwConfirmController = TextEditingController();

  bool _obsecureText = true;

  @override
  void dispose() {
    emailController.dispose();
    pwController.dispose();
    nameController.dispose();
    pwConfirmController.dispose();
    super.dispose();
  }

  bool isTermsChecked = false;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const OnBoardingScreen(),
                            ),
                          );
                        },
                        child: const BackLabel(),
                      ),
                      Text(
                        AppLocalizations.of(context)!.signUp,
                        style: TextStyle(
                          fontFamily: StringConstants.setBoldPersianFont(),
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      const SizedBox(
                        width: 32,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    AppLocalizations.of(context)!.getStarted,
                    style: TextStyle(
                      fontFamily: StringConstants.setBoldPersianFont(),
                      fontSize: 24,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  SizedBox(
                    width: 183,
                    child: Text(
                      AppLocalizations.of(context)!.getStartedCap,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: StringConstants.setMediumPersionFont(),
                        fontSize: 12,
                        color: TextColors.wihteGreyText,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 90,
                  ),
                  MyTextField(
                    text: AppLocalizations.of(context)!.fullName,
                    controller: nameController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  MyTextField(
                    text: AppLocalizations.of(context)!.emailAd,
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Stack(
                    alignment: AlignmentDirectional.centerEnd,
                    children: [
                      TextFormField(
                        controller: pwController,
                        style: TextStyle(
                            color: TextColors.greyText,
                            fontFamily: StringConstants.setMediumPersionFont(),
                            fontSize: 14),
                        obscureText: _obsecureText,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              left: 10, right: 40, bottom: 20, top: 20),
                          labelText: AppLocalizations.of(context)!.password,
                          labelStyle: TextStyle(
                            color: TextColors.greyText,
                            fontSize: 15,
                            fontFamily: StringConstants.setMediumPersionFont(),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: TextColors.greyText,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(27),
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: TextColors.greyText,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(27),
                            ),
                          ),
                        ),
                        validator: (value) =>
                            value!.length < 8 ? "Password is too short" : null,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _obsecureText = !_obsecureText;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.only(right: 10),
                          child: _obsecureText
                              ? SvgPicture.asset(
                                  "assets/images/icon_eye_off.svg",
                                )
                              : const Icon(
                                  Icons.remove_red_eye,
                                  color: TextColors.greyText,
                                ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Stack(
                    alignment: AlignmentDirectional.centerEnd,
                    children: [
                      TextFormField(
                        controller: pwConfirmController,
                        style: TextStyle(
                            color: TextColors.greyText,
                            fontFamily: StringConstants.setMediumPersionFont(),
                            fontSize: 14),
                        obscureText: _obsecureText,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              left: 10, right: 40, bottom: 20, top: 20),
                          labelText: AppLocalizations.of(context)!.pwConfirm,
                          labelStyle: TextStyle(
                            color: TextColors.greyText,
                            fontSize: 15,
                            fontFamily: StringConstants.setMediumPersionFont(),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: TextColors.greyText,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(27),
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: TextColors.greyText,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(27),
                            ),
                          ),
                        ),
                        validator: (value) =>
                            value!.length < 8 ? "Password is too short" : null,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _obsecureText = !_obsecureText;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.only(right: 10),
                          child: _obsecureText
                              ? SvgPicture.asset(
                                  "assets/images/icon_eye_off.svg",
                                )
                              : const Icon(
                                  Icons.remove_red_eye,
                                  color: TextColors.greyText,
                                ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Transform.scale(
                        scale: 1.3,
                        child: Checkbox(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                          side: const BorderSide(
                            width: 1.3,
                            color: TextColors.greyText,
                          ),
                          checkColor: Colors.transparent,
                          activeColor: TextColors.greyText,
                          value: isTermsChecked,
                          onChanged: (value) {
                            setState(() {
                              isTermsChecked = value!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.agree,
                                style: TextStyle(
                                  fontFamily:
                                      StringConstants.setMediumPersionFont(),
                                  fontSize: (screenSize.width < 350) ? 10 : 12,
                                  color: TextColors.greyText,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  AppLocalizations.of(context)!.terms,
                                  style: TextStyle(
                                    fontFamily:
                                        StringConstants.setMediumPersionFont(),
                                    fontSize:
                                        (screenSize.width < 350) ? 10 : 12,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.and,
                                style: TextStyle(
                                  fontFamily:
                                      StringConstants.setMediumPersionFont(),
                                  fontSize: (screenSize.width < 350) ? 10 : 12,
                                  color: TextColors.greyText,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  PersistentNavBarNavigator.pushNewScreen(
                                    context,
                                    screen: const PrivacyPolicyScreen(),
                                    withNavBar: false,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino,
                                  );
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.policy,
                                  style: TextStyle(
                                    fontFamily:
                                        StringConstants.setMediumPersionFont(),
                                    fontSize:
                                        (screenSize.width < 350) ? 10 : 12,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  BlocConsumer<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthInitState) {
                        return SizedBox(
                          height: 56,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () {
                              AuthManager.saveName(nameController.text);
                              _eventHandler();
                            },
                            child: Text(
                              AppLocalizations.of(context)!.signUp,
                              style: TextStyle(
                                fontFamily:
                                    StringConstants.setMediumPersionFont(),
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                          ),
                        );
                      } else if (state is AuthLoadingState) {
                        return const AppLoadingIndicator();
                      } else if (state is AuthRegisterResponseState) {
                        return SizedBox(
                          height: 56,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () {
                              AuthManager.saveName(nameController.text.trim());
                              _eventHandler();
                            },
                            child: Text(
                              AppLocalizations.of(context)!.signUp,
                              style: TextStyle(
                                fontFamily:
                                    StringConstants.setMediumPersionFont(),
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                          ),
                        );
                      }
                      return const Text("There seem to be errors Getting data");
                    },
                    listener: (context, state) {
                      if (state is AuthRegisterResponseState) {
                        nameController.text = "";
                        pwConfirmController.text = "";
                        pwController.text = "";
                        emailController.text = "";
                        return state.registerRespnse.fold(
                          (exceptionMessage) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                elevation: 0,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                backgroundColor: Colors.transparent,
                                content: _SnackFailMessage(
                                    error: AppLocalizations.of(context)!
                                        .userExists),
                                duration: const Duration(seconds: 5),
                              ),
                            );
                          },
                          (registerResponse) async {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DashboardScreen(),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget snackBarMessage(bool isTermsChecked) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Container(
        width: MediaQueryHandler.screenWidth(context),
        height: 60,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 15, left: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                (isTermsChecked)
                    ? AppLocalizations.of(context)!.pwNotMatch
                    : AppLocalizations.of(context)!.agreement,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 12,
                  fontFamily: StringConstants.setBoldPersianFont(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _eventHandler() {
    if (pwConfirmController.text.trim() == pwController.text.trim() &&
        isTermsChecked) {
      context.read<AuthBloc>().add(
            AuthRegisterEvent(
              nameController.text.trim(),
              emailController.text.trim(),
              pwController.text.trim(),
              pwConfirmController.text.trim(),
            ),
          );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          backgroundColor: Colors.transparent,
          content: snackBarMessage(isTermsChecked),
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }
}

class _SnackFailMessage extends StatelessWidget {
  const _SnackFailMessage({required this.error});
  final String error;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Directionality(
        textDirection: AppManager.getLnag() == 'fa'
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: Container(
          width: MediaQueryHandler.screenWidth(context),
          height: 60,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant,
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 15, left: 15),
            child: Center(
              child: Text(
                error,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 12,
                  fontFamily: StringConstants.setBoldPersianFont(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
