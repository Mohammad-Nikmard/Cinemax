import 'package:cinemax/bloc/search/search_bloc.dart';
import 'package:cinemax/bloc/search/search_state.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/constants/string_constants.dart';
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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchResultScreen extends StatelessWidget {
  const SearchResultScreen({super.key, required this.searchQuery});
  final String searchQuery;

  @override
  Widget build(BuildContext context) {
    TextEditingController resultController =
        TextEditingController(text: searchQuery);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchLoadingState) {
            return const AppLoadingIndicator();
          } else if (state is SearchResultState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  borderRadius: const BorderRadius.all(
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
                                          controller: resultController,
                                          style: TextStyle(
                                            fontFamily: StringConstants
                                                .setMediumPersionFont(),
                                            fontSize: 14,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    bottom: 10),
                                            border: InputBorder.none,
                                            hintStyle: TextStyle(
                                              fontFamily: StringConstants
                                                  .setMediumPersionFont(),
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
                                child: Text(
                                  AppLocalizations.of(context)!.cancel,
                                  style: TextStyle(
                                    fontFamily:
                                        StringConstants.setMediumPersionFont(),
                                    fontSize: 12,
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
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
                    if (state.moviesearch.isNotEmpty) ...{
                      SliverToBoxAdapter(
                        child: MovieRelatedHeader(
                          movies: state.moviesearch,
                        ),
                      ),
                    },
                    if (state.moviesearch.isNotEmpty) ...{
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
                    }
                  ],
                ),
              ),
            );
          }
          if (state is EmptySearchState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  borderRadius: const BorderRadius.all(
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
                                          controller: resultController,
                                          readOnly: true,
                                          style: TextStyle(
                                            fontFamily: StringConstants
                                                .setMediumPersionFont(),
                                            fontSize: 14,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    bottom: 10),
                                            border: InputBorder.none,
                                            hintStyle: TextStyle(
                                              fontFamily: StringConstants
                                                  .setMediumPersionFont(),
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
                                child: Text(
                                  AppLocalizations.of(context)!.cancel,
                                  style: TextStyle(
                                    fontFamily:
                                        StringConstants.setMediumPersionFont(),
                                    fontSize: 12,
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
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

class MovieRelatedHeader extends StatelessWidget {
  const MovieRelatedHeader({super.key, required this.movies});
  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.relatedMovie,
                style: TextStyle(
                  fontFamily: StringConstants.setBoldPersianFont(),
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              GestureDetector(
                onTap: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: CategorySearchScreen(
                      title: AppLocalizations.of(context)!.relatedMovie,
                      movieList: movies,
                    ),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                child: Text(
                  AppLocalizations.of(context)!.seeAll,
                  style: TextStyle(
                    fontFamily: StringConstants.setMediumPersionFont(),
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.primary,
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
        if (actorsList.isNotEmpty) ...{
          Text(
            AppLocalizations.of(context)!.actor,
            style: TextStyle(
              fontFamily: StringConstants.setMediumPersionFont(),
              fontSize: 16,
              color: Theme.of(context).colorScheme.tertiary,
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
        }
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
            height: 70,
            width: 70,
            child: FittedBox(
              fit: BoxFit.cover,
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
          style: TextStyle(
            fontFamily: StringConstants.setBoldPersianFont(),
            fontSize: 12,
            color: Theme.of(context).colorScheme.tertiary,
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
              SizedBox(
                width: 200,
                child: Text(
                  AppLocalizations.of(context)!.sorryForSearch,
                  style: TextStyle(
                    fontFamily: StringConstants.setBoldPersianFont(),
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 210,
                child: Text(
                  AppLocalizations.of(context)!.noMovieCap,
                  style: TextStyle(
                    fontFamily: StringConstants.setMediumPersionFont(),
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
