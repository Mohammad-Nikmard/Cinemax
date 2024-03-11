import 'dart:ui';

import 'package:cinemax/DI/service_locator.dart';
import 'package:cinemax/bloc/movies/movies_bloc.dart';
import 'package:cinemax/bloc/movies/movies_event.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/data/model/movie.dart';
import 'package:cinemax/ui/movie_detail_screen.dart';
import 'package:cinemax/ui/series_detial_screen.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MovieWidget extends StatelessWidget {
  const MovieWidget({super.key, required this.showRate, required this.movie});
  final bool showRate;
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (movie.category == "movie") {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: BlocProvider(
              create: (context) {
                var bloc = MovieBloc(locator.get());
                bloc.add(MoviesDataRequestEvent(movie.id));
                return bloc;
              },
              child: MovieDetailScreen(
                movie: movie,
              ),
            ),
            withNavBar: true,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        } else if (movie.category == "series") {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: SeriesDetailScreen(
              series: movie,
            ),
            withNavBar: true,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        }
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
                        child: Container(
                          height: (MediaQueryHandler.screenWidth(context) < 350)
                              ? 19.2
                              : 24,
                          width: (MediaQueryHandler.screenWidth(context) < 350)
                              ? 44
                              : 55,
                          decoration: BoxDecoration(
                            color: const Color(0xff252836).withOpacity(0.3),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/icon_star.png',
                                color: SecondaryColors.orangeColor,
                                height: 16,
                                width: 16,
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
              ],
            ),
            Container(
              width: (MediaQueryHandler.screenWidth(context) < 350) ? 115 : 145,
              height: (MediaQueryHandler.screenWidth(context) < 350) ? 48 : 53,
              decoration: const BoxDecoration(
                color: PrimaryColors.softColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
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
                        fontSize: (MediaQueryHandler.screenWidth(context) < 350)
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
                        fontSize: (MediaQueryHandler.screenWidth(context) < 350)
                            ? 8
                            : 10,
                        color: TextColors.greyText,
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
