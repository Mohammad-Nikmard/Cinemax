import 'package:cinemax/bloc/authentication/authentication_bloc.dart';
import 'package:cinemax/bloc/authentication/authentication_event.dart';
import 'package:cinemax/bloc/authentication/authentication_state.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/ui/dashobard_screen.dart';
import 'package:cinemax/ui/onboarding_screen.dart';
import 'package:cinemax/ui/privacy_screen.dart';
import 'package:cinemax/widgets/back_label.dart';
import 'package:cinemax/widgets/loading_indicator.dart';
import 'package:cinemax/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

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
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthInitState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        const Text(
                          "Sign Up",
                          style: TextStyle(
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
                    const Text(
                      "let's get started",
                      style: TextStyle(
                        fontFamily: "MSB",
                        fontSize: 24,
                        color: TextColors.whiteText,
                      ),
                    ),
                    const SizedBox(
                      width: 183,
                      child: Text(
                        "the latest movies ans series are here",
                        textAlign: TextAlign.center,
                        style: TextStyle(
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
                      text: "Full Name",
                      controller: nameController,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    MyTextField(
                      text: "Email Address",
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
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 10, right: 40),
                            labelText: "Password",
                            labelStyle: TextStyle(
                                color: TextColors.greyText, fontSize: 15),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: TextColors.greyText,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(27),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: TextColors.greyText,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(27),
                              ),
                            ),
                          ),
                          validator: (value) => value!.length < 8
                              ? "Password is too short"
                              : null,
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
                          style: const TextStyle(
                              color: TextColors.greyText,
                              fontFamily: "MM",
                              fontSize: 14),
                          obscureText: _obsecureText,
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 10, right: 40),
                            labelText: "Password Confirm",
                            labelStyle: TextStyle(
                                color: TextColors.greyText, fontSize: 15),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: TextColors.greyText,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(27),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: TextColors.greyText,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(27),
                              ),
                            ),
                          ),
                          validator: (value) => value!.length < 8
                              ? "Password is too short"
                              : null,
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
                                  "I agree to the ",
                                  style: TextStyle(
                                    fontFamily: "MM",
                                    fontSize:
                                        (screenSize.width < 350) ? 10 : 12,
                                    color: TextColors.greyText,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    "Terms and Services",
                                    style: TextStyle(
                                      fontFamily: "MM",
                                      fontSize:
                                          (screenSize.width < 350) ? 10 : 12,
                                      color: PrimaryColors.blueAccentColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "and ",
                                  style: TextStyle(
                                    fontFamily: "MM",
                                    fontSize:
                                        (screenSize.width < 350) ? 10 : 12,
                                    color: TextColors.greyText,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    PersistentNavBarNavigator.pushNewScreen(
                                      context,
                                      screen: const PrivacyPolicyScreen(),
                                      withNavBar:
                                          false, // OPTIONAL VALUE. True by default.
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.cupertino,
                                    );
                                  },
                                  child: Text(
                                    "Privacy Policy",
                                    style: TextStyle(
                                      fontFamily: "MM",
                                      fontSize:
                                          (screenSize.width < 350) ? 10 : 12,
                                      color: PrimaryColors.blueAccentColor,
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
                      height: 50,
                    ),
                    SizedBox(
                      height: 56,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(
                                AuthRegisterEvent(
                                  nameController.text.trim(),
                                  emailController.text.trim(),
                                  pwController.text.trim(),
                                  pwConfirmController.text.trim(),
                                ),
                              );
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            fontFamily: "MM",
                            fontSize: 16,
                            color: TextColors.whiteText,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is AuthLoadingState) {
            return const AppLoadingIndicator();
          }
          if (state is AuthRegisterResponseState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        const Text(
                          "Sign Up",
                          style: TextStyle(
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
                    const Text(
                      "let's get started",
                      style: TextStyle(
                        fontFamily: "MSB",
                        fontSize: 24,
                        color: TextColors.whiteText,
                      ),
                    ),
                    const SizedBox(
                      width: 183,
                      child: Text(
                        "the latest movies ans series are here",
                        textAlign: TextAlign.center,
                        style: TextStyle(
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
                      text: "Full Name",
                      controller: nameController,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    MyTextField(
                      text: "Email Address",
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
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 10, right: 40),
                            labelText: "Password",
                            labelStyle: TextStyle(
                                color: TextColors.greyText, fontSize: 15),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: TextColors.greyText,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(27),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: TextColors.greyText,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(27),
                              ),
                            ),
                          ),
                          validator: (value) => value!.length < 8
                              ? "Password is too short"
                              : null,
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
                          style: const TextStyle(
                              color: TextColors.greyText,
                              fontFamily: "MM",
                              fontSize: 14),
                          obscureText: _obsecureText,
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 10, right: 40),
                            labelText: "Password Confirm",
                            labelStyle: TextStyle(
                                color: TextColors.greyText, fontSize: 15),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: TextColors.greyText,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(27),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: TextColors.greyText,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(27),
                              ),
                            ),
                          ),
                          validator: (value) => value!.length < 8
                              ? "Password is too short"
                              : null,
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
                                  "I agree to the ",
                                  style: TextStyle(
                                    fontFamily: "MM",
                                    fontSize:
                                        (screenSize.width < 350) ? 10 : 12,
                                    color: TextColors.greyText,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    "Terms and Services",
                                    style: TextStyle(
                                      fontFamily: "MM",
                                      fontSize:
                                          (screenSize.width < 350) ? 10 : 12,
                                      color: PrimaryColors.blueAccentColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "and ",
                                  style: TextStyle(
                                    fontFamily: "MM",
                                    fontSize:
                                        (screenSize.width < 350) ? 10 : 12,
                                    color: TextColors.greyText,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    PersistentNavBarNavigator.pushNewScreen(
                                      context,
                                      screen: const PrivacyPolicyScreen(),
                                      withNavBar:
                                          false, // OPTIONAL VALUE. True by default.
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.cupertino,
                                    );
                                  },
                                  child: Text(
                                    "Privacy Policy",
                                    style: TextStyle(
                                      fontFamily: "MM",
                                      fontSize:
                                          (screenSize.width < 350) ? 10 : 12,
                                      color: PrimaryColors.blueAccentColor,
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
                      height: 10,
                    ),
                    state.response.fold(
                      (exceptionMessage) {
                        return Text(exceptionMessage);
                      },
                      (rsponse) {
                        return Text(rsponse);
                      },
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      height: 56,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(
                                AuthRegisterEvent(
                                  nameController.text.trim(),
                                  emailController.text.trim(),
                                  pwController.text.trim(),
                                  pwConfirmController.text.trim(),
                                ),
                              );
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            fontFamily: "MM",
                            fontSize: 16,
                            color: TextColors.whiteText,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Text("");
        },
        listener: (context, state) {
          if (state is AuthRegisterResponseState) {
            nameController.text = "";
            pwConfirmController.text = "";
            pwController.text = "";
            emailController.text = "";
            return state.response.fold(
              (l) {},
              (r) {
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
    );
  }
}
