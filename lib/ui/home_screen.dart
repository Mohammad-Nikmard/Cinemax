import 'package:cinemax/DI/service_locator.dart';
import 'package:cinemax/bloc/home/home_state.dart';
import 'package:cinemax/bloc/home/homebloc.dart';
import 'package:cinemax/bloc/search/search_bloc.dart';
import 'package:cinemax/bloc/search/search_event.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/data/model/movie.dart';
import 'package:cinemax/data/model/usera.dart';
import 'package:cinemax/ui/category_search_screen.dart';
import 'package:cinemax/ui/search_screen.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/banner.dart';
import 'package:cinemax/widgets/cached_image.dart';
import 'package:cinemax/widgets/exception_message.dart';
import 'package:cinemax/widgets/loading_indicator.dart';
import 'package:cinemax/widgets/movie_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return const AppLoadingIndicator();
          }
          if (state is HomeResponseState) {
            return SafeArea(
              child: CustomScrollView(
                slivers: [
                  state.currentUser.fold(
                    (exceptionMessage) {
                      return SliverToBoxAdapter(
                        child: Text(exceptionMessage),
                      );
                    },
                    (user) {
                      return _HomeHeader(
                        user: user,
                      );
                    },
                  ),
                  const SearchBox(),
                  state.getBanners.fold(
                    (exceptionMessage) {
                      return const SliverToBoxAdapter(
                        child: ExceptionMessage(),
                      );
                    },
                    (bannerList) {
                      return SliverToBoxAdapter(
                        child: BannerContainer(
                          bannerList: bannerList,
                        ),
                      );
                    },
                  ),
                  state.getHottestMovies.fold(
                    (exceptionMessage) {
                      return const SliverToBoxAdapter(
                        child: ExceptionMessage(),
                      );
                    },
                    (movieList) {
                      return SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 30, left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.hotMovie,
                                style: const TextStyle(
                                  fontFamily: "MM",
                                  fontSize: 16,
                                  color: TextColors.whiteText,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              GestureDetector(
                                onTap: () {
                                  PersistentNavBarNavigator.pushNewScreen(
                                    context,
                                    screen: CategorySearchScreen(
                                      title: AppLocalizations.of(context)!
                                          .hotMovie,
                                      movieList: movieList,
                                    ),
                                    withNavBar: false,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino,
                                  );
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.seeAll,
                                  style: const TextStyle(
                                    fontFamily: "MM",
                                    fontSize: 14,
                                    color: PrimaryColors.blueAccentColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  state.getHottestMovies.fold(
                    (exceptionMessage) {
                      return const SliverToBoxAdapter(
                        child: ExceptionMessage(),
                      );
                    },
                    (movieList) {
                      return MovieListChip(movieList: movieList);
                    },
                  ),
                  state.getLatestMovies.fold(
                    (exceptionMessage) {
                      return const SliverToBoxAdapter(
                        child: ExceptionMessage(),
                      );
                    },
                    (movieList) {
                      return SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 30, left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.latestMovie,
                                style: const TextStyle(
                                  fontFamily: "MM",
                                  fontSize: 16,
                                  color: TextColors.whiteText,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              GestureDetector(
                                onTap: () {
                                  PersistentNavBarNavigator.pushNewScreen(
                                    context,
                                    screen: CategorySearchScreen(
                                      title: AppLocalizations.of(context)!
                                          .latestMovie,
                                      movieList: movieList,
                                    ),
                                    withNavBar: false,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino,
                                  );
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.seeAll,
                                  style: const TextStyle(
                                    fontFamily: "MM",
                                    fontSize: 14,
                                    color: PrimaryColors.blueAccentColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  state.getLatestMovies.fold(
                    (exceptionMessage) {
                      return const SliverToBoxAdapter(
                        child: ExceptionMessage(),
                      );
                    },
                    (movieList) {
                      return MovieListChip(movieList: movieList);
                    },
                  ),
                  state.getHottestSeries.fold(
                    (exceptionMessage) {
                      return const SliverToBoxAdapter(
                        child: ExceptionMessage(),
                      );
                    },
                    (seriesList) {
                      return SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 30, left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.hotSeries,
                                style: const TextStyle(
                                  fontFamily: "MM",
                                  fontSize: 16,
                                  color: TextColors.whiteText,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              GestureDetector(
                                onTap: () {
                                  PersistentNavBarNavigator.pushNewScreen(
                                    context,
                                    screen: CategorySearchScreen(
                                      title: AppLocalizations.of(context)!
                                          .hotSeries,
                                      movieList: seriesList,
                                    ),
                                    withNavBar: false,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino,
                                  );
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.seeAll,
                                  style: const TextStyle(
                                    fontFamily: "MM",
                                    fontSize: 14,
                                    color: PrimaryColors.blueAccentColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  state.getHottestSeries.fold(
                    (exceptionMessage) {
                      return const SliverToBoxAdapter(
                        child: ExceptionMessage(),
                      );
                    },
                    (seriesList) {
                      return SeriesList(movieList: seriesList);
                    },
                  ),
                  state.getForYouSeries.fold(
                    (exceptionMessage) {
                      return const SliverToBoxAdapter(
                        child: ExceptionMessage(),
                      );
                    },
                    (seriesList) {
                      return SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 30, left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.seriesForYou,
                                style: const TextStyle(
                                  fontFamily: "MM",
                                  fontSize: 16,
                                  color: TextColors.whiteText,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              GestureDetector(
                                onTap: () {
                                  PersistentNavBarNavigator.pushNewScreen(
                                    context,
                                    screen: CategorySearchScreen(
                                      title: AppLocalizations.of(context)!
                                          .seriesForYou,
                                      movieList: seriesList,
                                    ),
                                    withNavBar: false,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino,
                                  );
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.seeAll,
                                  style: const TextStyle(
                                    fontFamily: "MM",
                                    fontSize: 14,
                                    color: PrimaryColors.blueAccentColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  state.getForYouSeries.fold(
                    (exceptionMessage) {
                      return const SliverToBoxAdapter(
                        child: ExceptionMessage(),
                      );
                    },
                    (seriesList) {
                      return SeriesList(movieList: seriesList);
                    },
                  ),
                  state.getForYouMovies.fold(
                    (exceptionMessage) {
                      return const SliverToBoxAdapter(
                        child: ExceptionMessage(),
                      );
                    },
                    (movieList) {
                      return SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 30, left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.movieForYOu,
                                style: const TextStyle(
                                  fontFamily: "MM",
                                  fontSize: 16,
                                  color: TextColors.whiteText,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              GestureDetector(
                                onTap: () {
                                  PersistentNavBarNavigator.pushNewScreen(
                                    context,
                                    screen: CategorySearchScreen(
                                      title: AppLocalizations.of(context)!
                                          .movieForYOu,
                                      movieList: movieList,
                                    ),
                                    withNavBar: false,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino,
                                  );
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.seeAll,
                                  style: const TextStyle(
                                    fontFamily: "MM",
                                    fontSize: 14,
                                    color: PrimaryColors.blueAccentColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  state.getForYouMovies.fold(
                    (exceptionMessage) {
                      return const SliverToBoxAdapter(
                        child: ExceptionMessage(),
                      );
                    },
                    (movieList) {
                      return MovieListChip(movieList: movieList);
                    },
                  ),
                ],
              ),
            );
          }
          return Center(
            child: Text(AppLocalizations.of(context)!.state),
          );
        },
      ),
    );
  }
}

class _HomeHeader extends StatefulWidget {
  const _HomeHeader({required this.user});
  final UserApp user;

  @override
  State<_HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<_HomeHeader> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(100),
                  ),
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: (widget.user.imagePath == "")
                          ? SvgPicture.asset(
                              'assets/images/icon_user.svg',
                              colorFilter: const ColorFilter.mode(
                                TextColors.whiteText,
                                BlendMode.srcIn,
                              ),
                            )
                          : CachedImage(
                              imageUrl: widget.user.imagePath,
                              radius: 100,
                            ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${AppLocalizations.of(context)!.hello}, ${widget.user.name}",
                      style: TextStyle(
                        fontFamily: "MSB",
                        fontSize: (MediaQueryHandler.screenWidth(context) < 350)
                            ? 12
                            : 16,
                        color: TextColors.whiteText,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.findMovie,
                      style: TextStyle(
                        fontFamily: "MM",
                        fontSize: (MediaQueryHandler.screenWidth(context) < 350)
                            ? 8
                            : 12,
                        color: TextColors.greyText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              height: 32,
              width: 32,
              decoration: const ShapeDecoration(
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(40),
                  ),
                ),
                color: PrimaryColors.softColor,
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/images/icon_heart.svg',
                  colorFilter: const ColorFilter.mode(
                    SecondaryColors.redColor,
                    BlendMode.srcIn,
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

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
        child: GestureDetector(
          onTap: () {
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: BlocProvider(
                create: (context) => SearchBloc(locator.get(), locator.get())
                  ..add(SearchFetchDataEvent()),
                child: const SearchScreen(),
              ),
              withNavBar: true, // OPTIONAL VALUE. True by default.
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
          },
          child: Container(
            height: 41,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: PrimaryColors.softColor,
              borderRadius: BorderRadius.all(
                Radius.circular(24),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/icon_search.svg',
                        height: 16,
                        width: 16,
                        colorFilter: const ColorFilter.mode(
                          TextColors.greyText,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        AppLocalizations.of(context)!.searchAtitle,
                        style: const TextStyle(
                          fontFamily: "MM",
                          fontSize: 14,
                          color: TextColors.greyText,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: VerticalDivider(
                          color: TextColors.greyText,
                          thickness: 1.3,
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/images/icon_setters.svg',
                        height: 16,
                        width: 16,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MovieListChip extends StatelessWidget {
  const MovieListChip({super.key, required this.movieList});
  final List<Movie> movieList;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 25, left: 20),
        child: SizedBox(
          height: 231,
          child: ListView.builder(
            itemCount: movieList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 15),
                child: MovieWidget(
                  showRate: true,
                  movie: movieList[index],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class SeriesList extends StatelessWidget {
  const SeriesList({super.key, required this.movieList});
  final List<Movie> movieList;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 25, left: 20, bottom: 35),
        child: SizedBox(
          height: 231,
          child: ListView.builder(
            itemCount: movieList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 15),
                child: MovieWidget(
                  showRate: true,
                  movie: movieList[index],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
