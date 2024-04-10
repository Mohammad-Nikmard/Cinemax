import 'package:cinemax/bloc/language/language_bloc.dart';
import 'package:cinemax/bloc/language/language_event.dart';
import 'package:cinemax/bloc/language/language_state.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/constants/string_constants.dart';
import 'package:cinemax/data/model/language.dart';
import 'package:cinemax/widgets/back_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  int selectedIndex = 0;
  List<String> languages = [
    "English",
    "فارسی",
    "Français",
    "Español",
    "中国人",
    "हिंदी",
    "عربي",
    "Русский",
    "português",
    "Deutsch",
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
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
                          AppLocalizations.of(context)!.language,
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
                    const SizedBox(height: 25),
                    Container(
                      width: MediaQuery.of(context).size.width,
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.suggestedLang,
                              style: TextStyle(
                                fontFamily:
                                    StringConstants.setBoldPersianFont(),
                                fontSize: 12,
                                color: TextColors.greyText,
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 550,
                              child: ListView.builder(
                                itemCount: languages.length,
                                itemBuilder: (context, index) {
                                  if (index == 9) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(
                                          () {
                                            context.read<LanguageBloc>().add(
                                                  ChangeLanguage(
                                                    selectedLanguage:
                                                        Language.values[index],
                                                  ),
                                                );
                                          },
                                        );
                                      },
                                      child: SizedBox(
                                        height: 25,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                languages[index],
                                                style: const TextStyle(
                                                  fontFamily: "MSB",
                                                  fontSize: 16,
                                                  color: TextColors.whiteText,
                                                ),
                                              ),
                                              Visibility(
                                                visible:
                                                    Language.values[index] ==
                                                        state.selectedLanguage,
                                                child: SvgPicture.asset(
                                                  'assets/images/tick_image.svg',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          context.read<LanguageBloc>().add(
                                                ChangeLanguage(
                                                  selectedLanguage:
                                                      Language.values[index],
                                                ),
                                              );
                                        });
                                      },
                                      child: SizedBox(
                                        height: 60,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    languages[index],
                                                    style: const TextStyle(
                                                      fontFamily: "MSB",
                                                      fontSize: 16,
                                                      color:
                                                          TextColors.whiteText,
                                                    ),
                                                  ),
                                                  Visibility(
                                                    visible: Language
                                                            .values[index] ==
                                                        state.selectedLanguage,
                                                    child: SvgPicture.asset(
                                                      'assets/images/tick_image.svg',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              const Divider(
                                                thickness: 1.3,
                                                color: Color(0xff252836),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
