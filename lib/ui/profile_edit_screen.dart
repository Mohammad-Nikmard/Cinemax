import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/widgets/back_label.dart';
import 'package:flutter/material.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  late final TextEditingController emailController;
  late final TextEditingController pwController;
  late final TextEditingController phoneNumberController;
  late final TextEditingController nameController;

  @override
  void initState() {
    emailController = TextEditingController(text: "mnikmard1344@gmail.com");
    pwController = TextEditingController(text: "mohammadNIkmard");
    phoneNumberController = TextEditingController(text: "+98 9377964183");
    nameController = TextEditingController(text: "Mohammad Bruh");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: const BackLabel(),
                    ),
                    const Text(
                      "Edit Profile",
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
                  height: 30,
                ),
                const _UserDetail(),
                const SizedBox(height: 25),
                TextField(
                  controller: nameController,
                  style: const TextStyle(
                      color: TextColors.greyText,
                      fontFamily: "MR",
                      fontSize: 14),
                  decoration: const InputDecoration(
                    labelText: "Full Name",
                    labelStyle:
                        TextStyle(color: TextColors.whiteText, fontSize: 15),
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
                ),
                const SizedBox(height: 35),
                TextField(
                  controller: emailController,
                  readOnly: true,
                  style: const TextStyle(
                      color: TextColors.greyText,
                      fontFamily: "MR",
                      fontSize: 14),
                  decoration: const InputDecoration(
                    labelText: "Email",
                    labelStyle:
                        TextStyle(color: TextColors.whiteText, fontSize: 15),
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
                ),
                const SizedBox(height: 35),
                TextField(
                  controller: pwController,
                  readOnly: true,
                  obscureText: true,
                  style: const TextStyle(
                      color: TextColors.greyText,
                      fontFamily: "MR",
                      fontSize: 14),
                  decoration: const InputDecoration(
                    labelText: "Password",
                    labelStyle:
                        TextStyle(color: TextColors.whiteText, fontSize: 15),
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
                ),
                const SizedBox(height: 35),
                TextField(
                  controller: phoneNumberController,
                  style: const TextStyle(
                      color: TextColors.greyText,
                      fontFamily: "MR",
                      fontSize: 14),
                  decoration: const InputDecoration(
                    labelText: "Phone Number",
                    labelStyle:
                        TextStyle(color: TextColors.whiteText, fontSize: 15),
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
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 35),
              child: SizedBox(
                height: 56,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Save Changes",
                    style: TextStyle(
                      fontFamily: "MM",
                      fontSize: 16,
                      color: TextColors.whiteText,
                    ),
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

class _UserDetail extends StatelessWidget {
  const _UserDetail();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          clipBehavior: Clip.none,
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: PrimaryColors.blueAccentColor,
            ),
            Positioned(
              bottom: -8,
              right: -8,
              child: Container(
                height: 32,
                width: 32,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: PrimaryColors.softColor,
                ),
                child: Image.asset(
                  'assets/images/icon_edit.png',
                  color: PrimaryColors.blueAccentColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Text(
          "Mohammad",
          style: TextStyle(
            fontFamily: "MSB",
            fontSize: 16,
            color: TextColors.whiteText,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "mnikmard1344@gmail.com",
          style: TextStyle(
            fontFamily: "MM",
            fontSize: 14,
            color: TextColors.greyText,
          ),
        ),
      ],
    );
  }
}
