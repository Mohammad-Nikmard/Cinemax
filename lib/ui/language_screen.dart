import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/widgets/back_label.dart';
import 'package:flutter/material.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  int selectedIndex = 0;
  List<String> languages = [
    "English (UK)",
    "English",
    "Persian",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
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
                    Navigator.pop(context);
                  },
                  child: const BackLabel(),
                ),
                const Text(
                  "Language",
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Suggested Languages",
                      style: TextStyle(
                        fontFamily: "MM",
                        fontSize: 12,
                        color: TextColors.greyText,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 160,
                      child: ListView.builder(
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          if (index == 2) {
                            return SizedBox(
                              height: 25,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  },
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
                                        visible: selectedIndex == index,
                                        child: Image.asset(
                                          'assets/images/Icon_checkmark.png',
                                          height: 20,
                                          width: 24,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return SizedBox(
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Row(
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
                                            visible: selectedIndex == index,
                                            child: Image.asset(
                                              'assets/images/Icon_checkmark.png',
                                              height: 20,
                                              width: 24,
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
    );
  }
}
