import 'dart:ui';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/constants/string_constants.dart';
import 'package:cinemax/data/model/movie.dart';
import 'package:cinemax/util/func_util.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RelatedSeachWidget extends StatelessWidget {
  const RelatedSeachWidget({super.key, required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        routeCondition(context, movie);
      },
      child: SizedBox(
        height: 147,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                  child: SizedBox(
                    height: 147,
                    width: 112,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: CachedImage(
                        imageUrl: movie.thumbnail,
                        radius: 8,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                            child: ColoredBox(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer
                                  .withOpacity(0.3),
                              child: SizedBox(
                                height: 24,
                                width: 55,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/icon_star.svg',
                                      height: 16,
                                      width: 16,
                                      colorFilter: ColorFilter.mode(
                                        Theme.of(context)
                                            .colorScheme
                                            .secondaryContainer,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      movie.rate,
                                      style: TextStyle(
                                        fontFamily: StringConstants
                                            .setMediumPersionFont(),
                                        fontSize: 12,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondaryContainer,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 170,
                  child: Text(
                    movie.name,
                    style: TextStyle(
                      fontFamily: StringConstants.setMediumPersionFont(),
                      fontSize: (MediaQueryHandler.screenWidth(context) < 350)
                          ? 12
                          : 16,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/icon_calendar.svg',
                      height: (MediaQueryHandler.screenWidth(context) < 350)
                          ? 12
                          : 16,
                      width: (MediaQueryHandler.screenWidth(context) < 350)
                          ? 12
                          : 16,
                      colorFilter: const ColorFilter.mode(
                        TextColors.greyText,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      movie.year,
                      style: TextStyle(
                        fontFamily: StringConstants.setMediumPersionFont(),
                        fontSize: (MediaQueryHandler.screenWidth(context) < 350)
                            ? 10
                            : 12,
                        color: TextColors.greyText,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/icon_clock.svg',
                      height: (MediaQueryHandler.screenWidth(context) < 350)
                          ? 12
                          : 16,
                      width: (MediaQueryHandler.screenWidth(context) < 350)
                          ? 12
                          : 16,
                      colorFilter: const ColorFilter.mode(
                        TextColors.greyText,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      "${movie.timeLength} Minutes",
                      style: TextStyle(
                        fontFamily: StringConstants.setMediumPersionFont(),
                        fontSize: (MediaQueryHandler.screenWidth(context) < 350)
                            ? 10
                            : 12,
                        color: TextColors.greyText,
                      ),
                    ),
                    SizedBox(
                      width: (MediaQueryHandler.screenWidth(context) < 350)
                          ? 3
                          : 15,
                    ),
                    Container(
                      height: (MediaQueryHandler.screenWidth(context) < 350)
                          ? 15
                          : 20,
                      width: (MediaQueryHandler.screenWidth(context) < 350)
                          ? 21
                          : 43,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 1.4,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(3),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "PG-${movie.pg}",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize:
                                (MediaQueryHandler.screenWidth(context) < 350)
                                    ? 6
                                    : 12,
                            fontFamily: StringConstants.setMediumPersionFont(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 16,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/icon_film.svg',
                        height: (MediaQueryHandler.screenWidth(context) < 350)
                            ? 12
                            : 16,
                        width: (MediaQueryHandler.screenWidth(context) < 350)
                            ? 12
                            : 16,
                        colorFilter: const ColorFilter.mode(
                          TextColors.greyText,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        movie.genre,
                        style: TextStyle(
                          fontFamily: StringConstants.setMediumPersionFont(),
                          fontSize:
                              (MediaQueryHandler.screenWidth(context) < 350)
                                  ? 10
                                  : 12,
                          color: TextColors.greyText,
                        ),
                      ),
                      const SizedBox(width: 3),
                      const VerticalDivider(
                        thickness: 1.3,
                        color: TextColors.greyText,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        movie.category.toUpperCase(),
                        style: TextStyle(
                          fontFamily: StringConstants.setMediumPersionFont(),
                          fontSize:
                              (MediaQueryHandler.screenWidth(context) < 350)
                                  ? 10
                                  : 12,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
