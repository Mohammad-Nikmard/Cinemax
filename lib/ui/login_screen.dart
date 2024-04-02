import 'package:cinemax/bloc/authentication/authentication_bloc.dart';
import 'package:cinemax/bloc/authentication/authentication_event.dart';
import 'package:cinemax/bloc/authentication/authentication_state.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/ui/dashobard_screen.dart';
import 'package:cinemax/ui/onboarding_screen.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/back_label.dart';
import 'package:cinemax/widgets/loading_indicator.dart';
import 'package:cinemax/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final pwController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    pwController.dispose();
    super.dispose();
  }

  bool _obsecureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
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
                      AppLocalizations.of(context)!.login,
                      style: const TextStyle(
                        fontFamily: "MSB",
                        fontSize: 16,
                        color: TextColors.whiteText,
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
                  AppLocalizations.of(context)!.hiThere,
                  style: const TextStyle(
                    fontFamily: "MSB",
                    fontSize: 24,
                    color: TextColors.whiteText,
                  ),
                ),
                SizedBox(
                  width: 183,
                  child: Text(
                    AppLocalizations.of(context)!.welcomeBack,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: "MM",
                      fontSize: 12,
                      color: TextColors.wihteGreyText,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 90,
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
                      style: const TextStyle(
                          color: TextColors.greyText,
                          fontFamily: "MM",
                          fontSize: 14),
                      obscureText: _obsecureText,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            left: 10, right: 40, top: 20, bottom: 20),
                        labelText: AppLocalizations.of(context)!.password,
                        labelStyle: const TextStyle(
                            color: TextColors.greyText, fontSize: 15),
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 8.0),
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => BlocProvider(
                    //             create: (context) => AuthBloc(
                    //               locator.get(),
                    //             ),
                    //             child: const ResetPasswordScreen(),
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //     child: Text(
                    //       AppLocalizations.of(context)!.forgotPw,
                    //       style: const TextStyle(
                    //         fontFamily: "MM",
                    //         fontSize: 12,
                    //         color: PrimaryColors.blueAccentColor,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 50,
                ),
                BlocConsumer<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthInitState) {
                      return SizedBox(
                        height: 56,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(
                                  AuthLoginEvent(
                                    emailController.text.trim(),
                                    pwController.text.trim(),
                                  ),
                                );
                          },
                          child: Text(
                            AppLocalizations.of(context)!.login,
                            style: const TextStyle(
                              fontFamily: "MM",
                              fontSize: 16,
                              color: TextColors.whiteText,
                            ),
                          ),
                        ),
                      );
                    }
                    if (state is AuthLoadingState) {
                      return const AppLoadingIndicator();
                    }
                    if (state is AuthLoginResponseState) {
                      return SizedBox(
                        height: 56,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(
                                  AuthLoginEvent(
                                    emailController.text.trim(),
                                    pwController.text.trim(),
                                  ),
                                );
                          },
                          child: Text(
                            AppLocalizations.of(context)!.login,
                            style: const TextStyle(
                              fontFamily: "MM",
                              fontSize: 16,
                              color: TextColors.whiteText,
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
                    if (state is AuthLoginResponseState) {
                      pwController.text = "";
                      emailController.text = "";

                      return state.loginResponse.fold(
                        (exceptionMessage) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              elevation: 0,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              backgroundColor: Colors.transparent,
                              content: _SnackFailMessage(
                                  error: AppLocalizations.of(context)!.wrongPW),
                              duration: const Duration(seconds: 5),
                            ),
                          );
                        },
                        (loginResponse) {
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
    );
  }
}

class _SnackFailMessage extends StatelessWidget {
  const _SnackFailMessage({required this.error});
  final String error;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Container(
        width: MediaQueryHandler.screenWidth(context),
        height: 60,
        decoration: const BoxDecoration(
          color: SecondaryColors.redColor,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 15, left: 15),
          child: Center(
            child: Text(
              error,
              style: const TextStyle(
                color: TextColors.whiteText,
                fontSize: 12,
                fontFamily: "MSB",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
