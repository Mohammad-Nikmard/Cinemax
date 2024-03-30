import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/back_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    AppLocalizations.of(context)!.about,
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
              const SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.aboutCinemax,
                style: const TextStyle(
                  fontFamily: "MSB",
                  fontSize: 20,
                  color: TextColors.whiteText,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)!.aboutCinemaxCap,
                style: const TextStyle(
                  fontFamily: "MM",
                  fontSize: 16,
                  color: TextColors.whiteText,
                ),
              ),
              const SizedBox(height: 40),
              Text(
                AppLocalizations.of(context)!.contactMe,
                style: const TextStyle(
                  fontFamily: "MSB",
                  fontSize: 20,
                  color: TextColors.whiteText,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)!.contactmeCap,
                style: const TextStyle(
                  fontFamily: "MM",
                  fontSize: 16,
                  color: TextColors.whiteText,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.personalEmail,
                    style: TextStyle(
                      fontFamily: "MM",
                      fontSize: (MediaQueryHandler.screenWidth(context) < 290)
                          ? 10
                          : 12,
                      color: TextColors.whiteText,
                    ),
                  ),
                  Text(
                    " mnikmard2004@gmail.com",
                    style: TextStyle(
                      fontFamily: "MM",
                      fontSize: (MediaQueryHandler.screenWidth(context) < 290)
                          ? 10
                          : 12,
                      color: TextColors.greyText,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.personalPhone,
                    style: TextStyle(
                      fontFamily: "MM",
                      fontSize: (MediaQueryHandler.screenWidth(context) < 290)
                          ? 10
                          : 12,
                      color: TextColors.whiteText,
                    ),
                  ),
                  Text(
                    " +989377964183",
                    style: TextStyle(
                      fontFamily: "MM",
                      fontSize: (MediaQueryHandler.screenWidth(context) < 290)
                          ? 10
                          : 12,
                      color: TextColors.greyText,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () async {
                      await launchLink(
                          "https://www.linkedin.com/in/mohammad-nikmard/");
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.linkedin,
                      color: Colors.blue,
                      size: 40,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await launchLink("https://github.com/Mohammad-Nikmard");
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.github,
                      size: 40,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await launchLink("https://t.me//M_theSicko");
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.telegram,
                      color: Colors.blue,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> launchLink(String link) async {
    final Uri uri = Uri.parse(link);
    await launchUrl(
      uri,
    );
  }
}
