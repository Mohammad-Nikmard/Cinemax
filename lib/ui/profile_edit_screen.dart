import 'dart:io';
import 'dart:ui';
import 'package:cinemax/bloc/profile/profile_bloc.dart';
import 'package:cinemax/bloc/profile/profile_event.dart';
import 'package:cinemax/bloc/profile/profile_state.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/constants/string_constants.dart';
import 'package:cinemax/data/model/user.dart';
import 'package:cinemax/util/auth_manager.dart';
import 'package:cinemax/widgets/back_label.dart';
import 'package:cinemax/widgets/cached_image.dart';
import 'package:cinemax/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key, required this.user});
  final UserApp user;

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  late final TextEditingController emailController;
  late final TextEditingController phoneNumberController;
  late final TextEditingController nameController;
  File? imageFile;

  @override
  void initState() {
    emailController = TextEditingController(text: AuthManager.readEmail());
    phoneNumberController = TextEditingController(text: AuthManager.readNum());
    nameController = TextEditingController(text: widget.user.name);
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    phoneNumberController.dispose();
    nameController.dispose();
    super.dispose();
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final directory = await getApplicationDocumentsDirectory();
      final name = basename(image.path);
      final pathImage = File("${directory.path}/$name");
      final newImage = await File(image.path).copy(pathImage.path);

      setState(() {
        imageFile = newImage;
      });
    } on PlatformException {
      // print(ex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 20,
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
                            style: TextStyle(
                              fontFamily: StringConstants.setBoldPersianFont(),
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
                                    return modalProfileSheet(context);
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
                                      child: (imageFile == null &&
                                              widget.user.profile.isEmpty)
                                          ? SvgPicture.asset(
                                              'assets/images/icon_user.svg',
                                              colorFilter:
                                                  const ColorFilter.mode(
                                                TextColors.whiteText,
                                                BlendMode.srcIn,
                                              ),
                                            )
                                          : (imageFile == null)
                                              ? CachedImage(
                                                  imageUrl:
                                                      widget.user.imagePath,
                                                  radius: 100)
                                              : Image.file(
                                                  imageFile!,
                                                ),
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
                            widget.user.name,
                            style: TextStyle(
                              fontFamily: StringConstants.setBoldPersianFont(),
                              fontSize: 16,
                              color: TextColors.whiteText,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            AuthManager.readEmail(),
                            style: TextStyle(
                              fontFamily:
                                  StringConstants.setMediumPersionFont(),
                              fontSize: 14,
                              color: TextColors.greyText,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      TextField(
                        controller: nameController,
                        style: TextStyle(
                          color: TextColors.greyText,
                          fontFamily: StringConstants.setSmallPersionFont(),
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.fullName,
                          labelStyle: TextStyle(
                            color: TextColors.whiteText,
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
                      ),
                      const SizedBox(height: 35),
                      TextField(
                        controller: emailController,
                        readOnly: true,
                        style: TextStyle(
                            color: TextColors.greyText,
                            fontFamily: StringConstants.setSmallPersionFont(),
                            fontSize: 14),
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.email,
                          labelStyle: TextStyle(
                              color: TextColors.whiteText,
                              fontSize: 15,
                              fontFamily:
                                  StringConstants.setMediumPersionFont()),
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
                        style: TextStyle(
                            color: TextColors.greyText,
                            fontFamily: StringConstants.setSmallPersionFont(),
                            fontSize: 14),
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.phoneNumber,
                          labelStyle: TextStyle(
                            color: TextColors.whiteText,
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
                      ),
                    ],
                  ),
                  BlocConsumer<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      if (state is ProfileIniState) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 35, top: 30),
                          child: SizedBox(
                            height: 56,
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: () {
                                eventsCondition(context);
                              },
                              child: Text(
                                AppLocalizations.of(context)!.saveChanges,
                                style: TextStyle(
                                  fontFamily:
                                      StringConstants.setMediumPersionFont(),
                                  fontSize: 16,
                                  color: TextColors.whiteText,
                                ),
                              ),
                            ),
                          ),
                        );
                      } else if (state is ProfileLoadingState) {
                        return const AppLoadingIndicator();
                      } else if (state is ProfileResponseState) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 35, top: 30),
                          child: SizedBox(
                            height: 56,
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                AppLocalizations.of(context)!.saveChanges,
                                style: TextStyle(
                                  fontFamily:
                                      StringConstants.setMediumPersionFont(),
                                  fontSize: 16,
                                  color: TextColors.whiteText,
                                ),
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
                        Navigator.pop(
                          context,
                          "true",
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

  eventsCondition(BuildContext context) {
    if (imageFile != null) {
      AuthManager.saveNum(phoneNumberController.text);
      context.read<ProfileBloc>().add(SendFileEvent(
            AuthManager.readRecordID(),
            imageFile,
          ));
    } else if (nameController.text.isNotEmpty) {
      AuthManager.saveNum(phoneNumberController.text);

      context.read<ProfileBloc>().add(SendNameEvent(
          AuthManager.readRecordID(), nameController.text.trim()));
    } else if (imageFile != null && nameController.text.isNotEmpty) {
      AuthManager.saveNum(phoneNumberController.text);

      context.read<ProfileBloc>().add(SendNameEvent(
          AuthManager.readRecordID(), nameController.text.trim()));
      context.read<ProfileBloc>().add(SendFileEvent(
            AuthManager.readRecordID(),
            imageFile,
          ));
    }
  }

  Widget modalProfileSheet(BuildContext context) {
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
                onTap: () {
                  pickImage(ImageSource.camera);

                  Navigator.pop(context);
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
                          Text(
                            "Capture",
                            style: TextStyle(
                              fontFamily: StringConstants.setSmallPersionFont(),
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
                onTap: () {
                  pickImage(ImageSource.gallery);
                  Navigator.pop(context);
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
                          Text(
                            "Gallery",
                            style: TextStyle(
                              fontFamily: StringConstants.setSmallPersionFont(),
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
