import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/widgets/back_label.dart';
import 'package:flutter/material.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  bool _pwObsecure = true;
  bool _pwConfirmObsecure = true;
  final pwController = TextEditingController();
  final pwConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                BackLabel(),
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            Text(
              "Create New Password",
              style: TextStyle(
                fontFamily: "MM",
                fontSize: 28,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Enter your new password",
              style: TextStyle(
                fontFamily: "MM",
                fontSize: 14,
                color: TextColors.greyText,
              ),
            ),
            const SizedBox(
              height: 50,
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
                  obscureText: _pwObsecure,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10, right: 40),
                    labelText: "New Password",
                    labelStyle:
                        TextStyle(color: TextColors.greyText, fontSize: 15),
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
                  validator: (value) =>
                      value!.length < 8 ? "Password is too short" : null,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _pwObsecure = !_pwObsecure;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.only(right: 10),
                    child: _pwObsecure
                        ? Image.asset(
                            'assets/images/icon_eye_off.png',
                            color: TextColors.greyText,
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
                  obscureText: _pwConfirmObsecure,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10, right: 40),
                    labelText: "Confirm Password",
                    labelStyle:
                        TextStyle(color: TextColors.greyText, fontSize: 15),
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
                  validator: (value) =>
                      value!.length < 8 ? "Password is too short" : null,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _pwConfirmObsecure = !_pwConfirmObsecure;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.only(right: 10),
                    child: _pwConfirmObsecure
                        ? Image.asset(
                            'assets/images/icon_eye_off.png',
                            color: TextColors.greyText,
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
              height: 50,
            ),
            SizedBox(
              height: 56,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Reset",
                  style: TextStyle(
                    fontFamily: "MM",
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
