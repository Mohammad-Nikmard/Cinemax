import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/constants/string_constants.dart';
import 'package:cinemax/data/model/news.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/back_label.dart';
import 'package:cinemax/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewsDetailScreen extends StatelessWidget {
  const NewsDetailScreen({super.key, required this.news});
  final News news;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const BackLabel(),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                          child: SizedBox(
                            height: 185,
                            width: MediaQueryHandler.screenWidth(context),
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: CachedImage(
                                imageUrl: news.thumbnail,
                                radius: 15,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/icon_calendar.svg',
                                height: 16,
                                width: 16,
                                colorFilter: const ColorFilter.mode(
                                  TextColors.greyText,
                                  BlendMode.srcIn,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                news.date,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily:
                                      StringConstants.setSmallPersionFont(),
                                  color: TextColors.greyText,
                                ),
                              ),
                              const SizedBox(width: 15),
                              Text(
                                AppLocalizations.of(context)!.publisher,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily:
                                      StringConstants.setSmallPersionFont(),
                                  color: TextColors.greyText,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: CachedImage(
                                    imageUrl: news.publisher,
                                    radius: 0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 15),
                          child: Text(
                            news.title,
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: StringConstants.setBoldPersianFont(),
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 30),
                          child: Text(
                            news.subtitle,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: StringConstants.setSmallPersionFont(),
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
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
  }
}
