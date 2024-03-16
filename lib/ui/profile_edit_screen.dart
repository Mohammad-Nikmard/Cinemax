import 'dart:io';
import 'dart:ui';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/util/auth_manager.dart';
import 'package:cinemax/widgets/back_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

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
  File? image;

  @override
  void initState() {
    emailController = TextEditingController(text: AuthManager.readEmail());
    pwController = TextEditingController(text: "mohammadNIkmard");
    phoneNumberController = TextEditingController(text: "+98 9377964183");
    nameController = TextEditingController(text: AuthManager.readId());
    super.initState();
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imagePermenant = await seavePermenantImage(image.path);
      setState(() {
        this.image = imagePermenant;
      });
    } on PlatformException {
      // print(ex);
    }
  }

  Future<File> seavePermenantImage(String imagepath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagepath);
    final image = File("${directory.path}/$name");

    return File(imagepath).copy(image.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
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
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const BackLabel(),
                        ),
                        Text(
                          AppLocalizations.of(context)!.editProf,
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
                      height: 30,
                    ),
                    Column(
                      children: [
                        InkWell(
                          customBorder: const CircleBorder(eccentricity: 1.0),
                          onTap: () {
                            showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                barrierColor: Colors.transparent,
                                context: context,
                                builder: (context) {
                                  return modalProfileSheet();
                                });
                          },
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            clipBehavior: Clip.none,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(100),
                                ),
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: (image != null)
                                        ? Image.file(
                                            image!,
                                            fit: BoxFit.cover,
                                          )
                                        : const FlutterLogo(),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: -8,
                                right: -8,
                                child: Container(
                                  height: 32,
                                  width: 32,
                                  padding: const EdgeInsets.all(7.0),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: PrimaryColors.softColor,
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/images/icon_edit_pen.svg',
                                    colorFilter: const ColorFilter.mode(
                                      PrimaryColors.blueAccentColor,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          AuthManager.readId(),
                          style: const TextStyle(
                            fontFamily: "MSB",
                            fontSize: 16,
                            color: TextColors.whiteText,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          AuthManager.readEmail(),
                          style: const TextStyle(
                            fontFamily: "MM",
                            fontSize: 14,
                            color: TextColors.greyText,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    TextField(
                      controller: nameController,
                      style: const TextStyle(
                        color: TextColors.greyText,
                        fontFamily: "MR",
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.fullName,
                        labelStyle: const TextStyle(
                            color: TextColors.whiteText, fontSize: 15),
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
                    ),
                    const SizedBox(height: 35),
                    TextField(
                      controller: emailController,
                      readOnly: true,
                      style: const TextStyle(
                          color: TextColors.greyText,
                          fontFamily: "MR",
                          fontSize: 14),
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.email,
                        labelStyle: const TextStyle(
                            color: TextColors.whiteText, fontSize: 15),
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
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.password,
                        labelStyle: const TextStyle(
                            color: TextColors.whiteText, fontSize: 15),
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
                    ),
                    const SizedBox(height: 35),
                    TextField(
                      controller: phoneNumberController,
                      style: const TextStyle(
                          color: TextColors.greyText,
                          fontFamily: "MR",
                          fontSize: 14),
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.pwConfirm,
                        labelStyle: const TextStyle(
                            color: TextColors.whiteText, fontSize: 15),
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
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 35, top: 30),
                  child: SizedBox(
                    height: 56,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.saveChanges,
                        style: const TextStyle(
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
        ),
      ),
    );
  }

  Widget modalProfileSheet() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 200,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 52, 56, 71),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () async {
                  await pickImage(ImageSource.camera);
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  child: SizedBox(
                    width: 150,
                    height: 100,
                    child: ColoredBox(
                      color: PrimaryColors.darkColor,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: SvgPicture.asset(
                              'assets/images/icon_camera.svg',
                              height: 40,
                              width: 40,
                              colorFilter: const ColorFilter.mode(
                                TextColors.whiteText,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Capture",
                            style: TextStyle(
                              fontFamily: "MR",
                              fontSize: 16,
                              color: TextColors.whiteText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await pickImage(ImageSource.gallery);
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  child: SizedBox(
                    width: 150,
                    height: 100,
                    child: ColoredBox(
                      color: PrimaryColors.darkColor,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: SvgPicture.asset(
                              'assets/images/icon_gallery.svg',
                              height: 40,
                              width: 40,
                              colorFilter: const ColorFilter.mode(
                                TextColors.whiteText,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Gallery",
                            style: TextStyle(
                              fontFamily: "MR",
                              fontSize: 16,
                              color: TextColors.whiteText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
