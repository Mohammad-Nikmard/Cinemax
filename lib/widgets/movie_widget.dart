import 'dart:ui';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/data/model/movie.dart';
import 'package:cinemax/util/func_util.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/cached_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class MovieWidget extends StatelessWidget {
  const MovieWidget({super.key, required this.showRate, required this.movie});
  final bool showRate;
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        routeCondition(context, movie);
      },
      child: SizedBox(
        height: (MediaQueryHandler.screenWidth(context) < 350) ? 185 : 231,
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: SizedBox(
                    width: (MediaQueryHandler.screenWidth(context) < 350)
                        ? 115
                        : 145,
                    height: (MediaQueryHandler.screenWidth(context) < 350)
                        ? 142
                        : 178,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: CachedImage(
                        imageUrl: movie.thumbnail,
                        radius: 0,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Visibility(
                    visible: showRate,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                          child: ColoredBox(
                            color: const Color(0xff252836).withOpacity(0.3),
                            child: SizedBox(
                              height:
                                  (MediaQueryHandler.screenWidth(context) < 350)
                                      ? 19.2
                                      : 24,
                              width:
                                  (MediaQueryHandler.screenWidth(context) < 350)
                                      ? 44
                                      : 55,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/icon_star.svg',
                                    height: 16,
                                    width: 16,
                                    colorFilter: const ColorFilter.mode(
                                      SecondaryColors.orangeColor,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    movie.rate,
                                    style: const TextStyle(
                                      fontFamily: "MM",
                                      fontSize: 12,
                                      color: SecondaryColors.orangeColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              child: ColoredBox(
                color: PrimaryColors.softColor,
                child: SizedBox(
                  width: (MediaQueryHandler.screenWidth(context) < 350)
                      ? 115
                      : 145,
                  height:
                      (MediaQueryHandler.screenWidth(context) < 350) ? 48 : 53,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          movie.name,
                          style: TextStyle(
                            fontFamily: "MM",
                            fontSize:
                                (MediaQueryHandler.screenWidth(context) < 350)
                                    ? 12
                                    : 14,
                            color: TextColors.whiteText,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          movie.genre,
                          style: TextStyle(
                            fontFamily: "MM",
                            fontSize:
                                (MediaQueryHandler.screenWidth(context) < 350)
                                    ? 8
                                    : 10,
                            color: TextColors.greyText,
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
    );
  }
}
