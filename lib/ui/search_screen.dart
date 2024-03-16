import 'package:cinemax/DI/service_locator.dart';
import 'package:cinemax/bloc/search/search_bloc.dart';
import 'package:cinemax/bloc/search/search_event.dart';
import 'package:cinemax/bloc/search/search_state.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/data/model/movie.dart';
import 'package:cinemax/ui/category_search_screen.dart';
import 'package:cinemax/ui/search_result_screen.dart';
import 'package:cinemax/widgets/exception_message.dart';
import 'package:cinemax/widgets/loading_indicator.dart';
import 'package:cinemax/widgets/movie_widget.dart';
import 'package:cinemax/widgets/related_search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchLoadingState) {
            return const AppLoadingIndicator();
          } else if (state is SearchResponseState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 40,
                                    decoration: const BoxDecoration(
                                      color: PrimaryColors.softColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(24),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Row(
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
                                          const SizedBox(width: 10.0),
                                          Expanded(
                                            child: TextField(
                                              readOnly: true,
                                              onTap: () {
                                                PersistentNavBarNavigator
                                                    .pushNewScreen(
                                                  context,
                                                  screen: BlocProvider(
                                                    create: (context) {
                                                      var bloc = SearchBloc(
                                                          locator.get(),
                                                          locator.get());
                                                      bloc.add(
                                                          SearchAllMoviesEvent());
                                                      return bloc;
                                                    },
                                                    child:
                                                        const SearchResultScreen(),
                                                  ),
                                                  withNavBar: false,
                                                  pageTransitionAnimation:
                                                      PageTransitionAnimation
                                                          .cupertino,
                                                );
                                              },
                                              style: const TextStyle(
                                                fontFamily: "MM",
                                                fontSize: 14,
                                                color: TextColors.whiteText,
                                              ),
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        bottom: 10),
                                                border: InputBorder.none,
                                                hintText: AppLocalizations.of(
                                                        context)!
                                                    .recommendforYou,
                                                hintStyle: const TextStyle(
                                                  fontFamily: "MM",
                                                  fontSize: 14,
                                                  color: TextColors.greyText,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          state.getAllMovies.fold(
                            (exceptionMessage) {
                              return const ExceptionMessage();
                            },
                            (movieList) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 90),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.today,
                                      style: const TextStyle(
                                        fontFamily: "MSB",
                                        fontSize: 16,
                                        color: TextColors.whiteText,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    RelatedSeachWidget(
                                      movie: movieList[5],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      state.getMovies.fold(
                        (exceptionMessage) {
                          return const ExceptionMessage();
                        },
                        (movieList) {
                          return Column(
                            children: [
                              RecommendHeader(
                                movies: movieList,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 30),
                                child: SizedBox(
                                  height: 231,
                                  child: ListView.builder(
                                    itemCount: movieList.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: MovieWidget(
                                          showRate: true,
                                          movie: movieList[index],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
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

class RecommendHeader extends StatelessWidget {
  const RecommendHeader({super.key, required this.movies});
  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.recommendforYou,
                style: const TextStyle(
                  fontFamily: "MSB",
                  fontSize: 16,
                  color: TextColors.whiteText,
                ),
              ),
              GestureDetector(
                onTap: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: CategorySearchScreen(
                      title: "Recommend for you",
                      movieList: movies,
                    ),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
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
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
