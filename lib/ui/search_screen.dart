import 'package:cinemax/DI/service_locator.dart';
import 'package:cinemax/bloc/search/search_bloc.dart';
import 'package:cinemax/bloc/search/search_event.dart';
import 'package:cinemax/bloc/search/search_state.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/constants/string_constants.dart';
import 'package:cinemax/data/model/movie.dart';
import 'package:cinemax/ui/category_search_screen.dart';
import 'package:cinemax/ui/search_result_screen.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/exception_message.dart';
import 'package:cinemax/widgets/movie_widget.dart';
import 'package:cinemax/widgets/related_search_widget.dart';
import 'package:cinemax/widgets/shimmer_skelton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchLoadingState) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[400]!,
              highlightColor: Colors.grey[100]!,
              child: const SearchLoading(),
            );
          } else if (state is SearchResponseState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SingleChildScrollView(
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            _SearchEngine(),
                            state.getAllMovies.fold(
                              (exceptionMessage) {
                                return const ExceptionMessage();
                              },
                              (movieList) {
                                movieList.shuffle();
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 90),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.today,
                                        style: TextStyle(
                                          fontFamily: StringConstants
                                              .setBoldPersianFont(),
                                          fontSize: 16,
                                          color: TextColors.whiteText,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      RelatedSeachWidget(
                                        movie: movieList[0],
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
                            movieList.shuffle();
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
                                      itemCount: 8,
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
                style: TextStyle(
                  fontFamily: StringConstants.setBoldPersianFont(),
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
                  style: TextStyle(
                    fontFamily: StringConstants.setMediumPersionFont(),
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

class _SearchEngine extends StatefulWidget {
  const _SearchEngine({super.key});

  @override
  State<_SearchEngine> createState() => __SearchEngineState();
}

class __SearchEngineState extends State<_SearchEngine> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = "";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 25),
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
                padding: const EdgeInsets.only(left: 15),
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
                        controller: searchController,
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                          });
                        },
                        style: TextStyle(
                          fontFamily: StringConstants.setMediumPersionFont(),
                          fontSize: 14,
                          color: TextColors.whiteText,
                        ),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(bottom: 10),
                          border: InputBorder.none,
                          hintText: AppLocalizations.of(context)!.typeSomething,
                          hintStyle: TextStyle(
                            fontFamily: StringConstants.setMediumPersionFont(),
                            fontSize: 14,
                            color: TextColors.greyText,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                        child: ColoredBox(
                          color: (searchQuery.isEmpty)
                              ? PrimaryColors.blueAccentColor.withOpacity(0.4)
                              : PrimaryColors.blueAccentColor,
                          child: InkWell(
                            onTap: () {
                              if (searchQuery.isNotEmpty) {
                                PersistentNavBarNavigator.pushNewScreen(
                                  context,
                                  screen: BlocProvider(
                                    create: (context) {
                                      var bloc = SearchBloc(
                                          locator.get(), locator.get());
                                      bloc.add(
                                          SearchQueryEvent(searchQuery.trim()));
                                      return bloc;
                                    },
                                    child: SearchResultScreen(
                                      searchQuery: searchQuery,
                                    ),
                                  ),
                                  withNavBar: false,
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.cupertino,
                                );
                              }
                            },
                            child: SizedBox(
                              height: 35,
                              width: 100,
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!.search,
                                  style: const TextStyle(
                                    fontFamily: "MR",
                                    fontSize: 14,
                                    color: TextColors.whiteText,
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchLoading extends StatelessWidget {
  const SearchLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              ShimmerSkelton(
                height: 40,
                width: MediaQueryHandler.screenWidth(context),
                radius: 24,
              ),
              const SizedBox(height: 30),
              const ShimmerSkelton(
                height: 20,
                width: 100,
                radius: 5,
              ),
              const SizedBox(height: 15),
              const Row(
                children: [
                  ShimmerSkelton(
                    height: 147,
                    width: 112,
                    radius: 15,
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerSkelton(
                        height: 20,
                        width: 150,
                        radius: 5,
                      ),
                      SizedBox(height: 15),
                      ShimmerSkelton(
                        height: 20,
                        width: 80,
                        radius: 5,
                      ),
                      SizedBox(height: 15),
                      ShimmerSkelton(
                        height: 20,
                        width: 160,
                        radius: 5,
                      ),
                      SizedBox(height: 15),
                      ShimmerSkelton(
                        height: 20,
                        width: 140,
                        radius: 5,
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
