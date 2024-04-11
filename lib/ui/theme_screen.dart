import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/constants/string_constants.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/back_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const BackLabel(),
                    ),
                    Text(
                      AppLocalizations.of(context)!.themes,
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
              ),
              Container(
                height: 137,
                width: MediaQueryHandler.screenWidth(context),
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  border: Border.all(
                    width: 1.2,
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.availableThemes,
                        style: TextStyle(
                          fontFamily: StringConstants.setBoldPersianFont(),
                          fontSize: 12,
                          color: TextColors.greyText,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 77,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return _ThemeChip(
                              themeName: AppLocalizations.of(context)!.cinemax,
                              selectedIndex: selectedIndex,
                              index: index,
                              dividerVisible: false,
                            );
                          },
                          itemCount: 1,
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
    );
  }
}

class _ThemeChip extends StatelessWidget {
  const _ThemeChip(
      {required this.themeName,
      required this.index,
      required this.selectedIndex,
      required this.dividerVisible});
  final String themeName;
  final int index;
  final int selectedIndex;
  final bool dividerVisible;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 77,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: Image.asset('assets/icon/icon.png'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    themeName,
                    style: TextStyle(
                      fontFamily: StringConstants.setBoldPersianFont(),
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: selectedIndex == index ? true : false,
                child: SvgPicture.asset(
                  'assets/images/tick_image.svg',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Visibility(
            visible: dividerVisible,
            child: Divider(
              thickness: 1.3,
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}
