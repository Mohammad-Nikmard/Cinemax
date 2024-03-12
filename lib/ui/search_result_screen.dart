import 'package:cinemax/bloc/search/search_bloc.dart';
import 'package:cinemax/bloc/search/search_event.dart';
import 'package:cinemax/bloc/search/search_state.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/data/model/actors.dart';
import 'package:cinemax/data/model/movie.dart';
import 'package:cinemax/ui/category_search_screen.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/cached_image.dart';
import 'package:cinemax/widgets/loading_indicator.dart';
import 'package:cinemax/widgets/related_search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class SearchResultScreen extends StatelessWidget {
  const SearchResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocBuilder<SearhcBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchLoadingState) {
            return const AppLoadingIndicator();
          } else if (state is SearchAllMoviesResponse) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25, bottom: 25),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/icon_search.svg',
                                      height: 16,
                                      width: 16,
                                      color: TextColors.greyText,
                                    ),
                                    const SizedBox(width: 10.0),
                                    Expanded(
                                      child: TextField(
                                        onChanged: (value) {
                                          if (value.isNotEmpty) {
                                            context
                                                .read<SearhcBloc>()
                                                .add(SearchQueryEvent(value));
                                          } else if (value.isEmpty) {
                                            context
                                                .read<SearhcBloc>()
                                                .add(SearchAllMoviesEvent());
                                          }
                                        },
                                        style: const TextStyle(
                                          fontFamily: "MM",
                                          fontSize: 14,
                                          color: TextColors.whiteText,
                                        ),
                                        decoration: const InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(bottom: 10),
                                          border: InputBorder.none,
                                          hintText: "Type Something...",
                                          hintStyle: TextStyle(
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
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                  fontFamily: "MM",
                                  fontSize: 12,
                                  color: TextColors.whiteText,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is SearchResultState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25, bottom: 25),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/icon_search.svg',
                                      height: 16,
                                      width: 16,
                                      color: TextColors.greyText,
                                    ),
                                    const SizedBox(width: 10.0),
                                    Expanded(
                                      child: TextField(
                                        onChanged: (value) {
                                          if (value.isNotEmpty) {
                                            context
                                                .read<SearhcBloc>()
                                                .add(SearchQueryEvent(value));
                                          } else if (value.isEmpty) {
                                            context
                                                .read<SearhcBloc>()
                                                .add(SearchAllMoviesEvent());
                                          }
                                        },
                                        style: const TextStyle(
                                          fontFamily: "MM",
                                          fontSize: 14,
                                          color: TextColors.whiteText,
                                        ),
                                        decoration: const InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(bottom: 10),
                                          border: InputBorder.none,
                                          hintText: "Type Something...",
                                          hintStyle: TextStyle(
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
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                  fontFamily: "MM",
                                  fontSize: 12,
                                  color: TextColors.whiteText,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: RelatedActorList(
                      actorsList: state.getActors,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: MovieRelatedHeader(
                      movies: state.moviesearch,
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: RelatedSeachWidget(
                            movie: state.moviesearch[index],
                          ),
                        );
                      },
                      childCount: state.moviesearch.length,
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is EmptySearchState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25, bottom: 25),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/icon_search.svg',
                                      height: 16,
                                      width: 16,
                                      color: TextColors.greyText,
                                    ),
                                    const SizedBox(width: 10.0),
                                    Expanded(
                                      child: TextField(
                                        onChanged: (value) {
                                          if (value.isNotEmpty) {
                                            context
                                                .read<SearhcBloc>()
                                                .add(SearchQueryEvent(value));
                                          } else if (value.isEmpty) {
                                            context
                                                .read<SearhcBloc>()
                                                .add(SearchAllMoviesEvent());
                                          }
                                        },
                                        style: const TextStyle(
                                          fontFamily: "MM",
                                          fontSize: 14,
                                          color: TextColors.whiteText,
                                        ),
                                        decoration: const InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(bottom: 10),
                                          border: InputBorder.none,
                                          hintText: "Type Something...",
                                          hintStyle: TextStyle(
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
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                  fontFamily: "MM",
                                  fontSize: 12,
                                  color: TextColors.whiteText,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const _EmptySearch(),
                ],
              ),
            );
          }
          return Text("There seem to be errors Getting data");
        },
      ),
    );
  }
}

class MovieRelatedHeader extends StatelessWidget {
  const MovieRelatedHeader({super.key, required this.movies});
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
              const Text(
                "Movie Related",
                style: TextStyle(
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
                      title: "Movie Related",
                      movieList: movies,
                    ),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                child: const Text(
                  "See All",
                  style: TextStyle(
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

class RelatedActorList extends StatelessWidget {
  const RelatedActorList({super.key, required this.actorsList});
  final List<Actors> actorsList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Actors",
          style: TextStyle(
            fontFamily: "MSB",
            fontSize: 16,
            color: TextColors.whiteText,
          ),
        ),
        const SizedBox(height: 20.0),
        SizedBox(
          height: 110,
          child: ListView.builder(
            itemCount: actorsList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: RelatedActor(
                  actors: actorsList[index],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class RelatedActor extends StatelessWidget {
  const RelatedActor({super.key, required this.actors});
  final Actors actors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(100),
          ),
          child: SizedBox(
            height: 50,
            width: 50,
            child: FittedBox(
              child: CachedImage(
                imageUrl: actors.thumbnail,
                radius: 100,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          actors.name,
          style: const TextStyle(
            fontFamily: "MSB",
            fontSize: 12,
            color: TextColors.whiteText,
          ),
        ),
      ],
    );
  }
}

class _EmptySearch extends StatelessWidget {
  const _EmptySearch();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: MediaQueryHandler.screenHeight(context) - 100,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/search_image.svg',
              ),
              const SizedBox(height: 10),
              const SizedBox(
                width: 200,
                child: Text(
                  "We Are Sorry, We Can Not Find The Movie :(",
                  style: TextStyle(
                    fontFamily: "MSB",
                    fontSize: 16,
                    color: TextColors.whiteText,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const SizedBox(
                width: 210,
                child: Text(
                  "Find your movie by Type title, Categories, Years, etc",
                  style: TextStyle(
                    fontFamily: "MM",
                    fontSize: 12,
                    color: TextColors.greyText,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
