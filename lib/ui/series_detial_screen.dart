import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinemax/DI/service_locator.dart';
import 'package:cinemax/bloc/comments/comment_bloc.dart';
import 'package:cinemax/bloc/comments/comment_event.dart';
import 'package:cinemax/bloc/series/series_bloc.dart';
import 'package:cinemax/bloc/series/series_event.dart';
import 'package:cinemax/bloc/series/series_state.dart';
import 'package:cinemax/bloc/video/video_bloc.dart';
import 'package:cinemax/bloc/video/video_event.dart';
import 'package:cinemax/bloc/wishlist/wishlist_bloc.dart';
import 'package:cinemax/bloc/wishlist/wishlist_event.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/constants/string_constants.dart';
import 'package:cinemax/data/model/movie.dart';
import 'package:cinemax/data/model/moviegallery.dart';
import 'package:cinemax/data/model/series_cast.dart';
import 'package:cinemax/data/model/series_seasons.dart';
import 'package:cinemax/ui/comments_screen.dart';
import 'package:cinemax/ui/movie_detail_screen.dart';
import 'package:cinemax/util/func_util.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/cached_image.dart';
import 'package:cinemax/widgets/comment_section.dart';
import 'package:cinemax/widgets/episode_widget.dart';
import 'package:cinemax/widgets/exception_message.dart';
import 'package:cinemax/widgets/snackbar_content.dart';
import 'package:cinemax/widgets/video_player.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SeriesDetailScreen extends StatelessWidget {
  const SeriesDetailScreen({super.key, required this.series});
  final Movie series;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SeriesBloc(locator.get(), locator.get(), locator.get(), locator.get())
            ..add(SeriesDataRequestEvent(series.id, series.name)),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: BlocBuilder<SeriesBloc, SeriesState>(
          builder: (context, state) {
            if (state is SeriesLoadingState) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[100]!,
                child: const MovieDetailLoading(),
              );
            } else if (state is SeriesResponseState) {
              return Directionality(
                textDirection: TextDirection.ltr,
                child: CustomScrollView(
                  slivers: [
                    _MovieDetailHeader(
                      series: series,
                      onLike: state.isLiked,
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _StoryLine(
                              storyLine: series.storyline,
                            ),
                            state.getCasts.fold(
                              (exceptionMessage) {
                                return const ExceptionMessage();
                              },
                              (casts) {
                                return SeriesCastAndCrew(
                                  casts: casts,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    state.getSeasons.fold(
                      (exceptionMessage) {
                        return const SliverToBoxAdapter(
                          child: ExceptionMessage(),
                        );
                      },
                      (seasonList) {
                        return SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 20, left: 20, bottom: 15),
                            child: _SeasonChip(
                              seasons: seasonList,
                              seriesName: series.name,
                            ),
                          ),
                        );
                      },
                    ),
                    state.getEpisodes.fold(
                      (exceptionMessage) {
                        return const SliverToBoxAdapter(
                          child: ExceptionMessage(),
                        );
                      },
                      (episodeList) {
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    right: 20, left: 20, bottom: 15),
                                child: EpisodeWidget(
                                  episode: episodeList[index],
                                ),
                              );
                            },
                            childCount: episodeList.length,
                          ),
                        );
                      },
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 20.0, bottom: 15.0),
                        child: Text(
                          AppLocalizations.of(context)!.gallery,
                          style: TextStyle(
                            fontFamily: StringConstants.setBoldPersianFont(),
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                      ),
                    ),
                    state.getPhotos.fold(
                      (exceptionMessage) {
                        return SliverToBoxAdapter(
                          child: Text(exceptionMessage),
                        );
                      },
                      (photoList) {
                        return SliverToBoxAdapter(
                          child: Gallery(
                            gallery: photoList,
                          ),
                        );
                      },
                    ),
                    state.getComments.fold(
                      (exceptionMessage) {
                        return const SliverToBoxAdapter(
                          child: ExceptionMessage(),
                        );
                      },
                      (commentList) {
                        if (commentList.isNotEmpty) {
                          return SliverToBoxAdapter(
                            child: GestureDetector(
                              onTap: () {
                                PersistentNavBarNavigator.pushNewScreen(
                                  context,
                                  screen: BlocProvider(
                                    create: (context) => CommentsBloc(
                                      locator.get(),
                                      locator.get(),
                                    )..add(
                                        CommentFetchEvent(series.id),
                                      ),
                                    child: CommentsScreen(
                                      movieName: series.name,
                                      year: series.year,
                                      imageURL: series.thumbnail,
                                      movieID: series.id,
                                    ),
                                  ),
                                  withNavBar: false,
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.cupertino,
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: CommentSection(
                                  comment: commentList.first,
                                ),
                              ),
                            ),
                          );
                        } else {
                          return SliverToBoxAdapter(
                            child: GestureDetector(
                              onTap: () {
                                PersistentNavBarNavigator.pushNewScreen(
                                  context,
                                  screen: BlocProvider(
                                    create: (context) => CommentsBloc(
                                      locator.get(),
                                      locator.get(),
                                    )..add(
                                        CommentFetchEvent(series.id),
                                      ),
                                    child: CommentsScreen(
                                      movieName: series.name,
                                      year: series.year,
                                      imageURL: series.thumbnail,
                                      movieID: series.id,
                                    ),
                                  ),
                                  withNavBar: false,
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.cupertino,
                                );
                              },
                              child: const EmptyCommentSection(),
                            ),
                          );
                        }
                      },
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          bottom: 15.0,
                          top: 20.0,
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.relatedMovie,
                          style: TextStyle(
                            fontFamily: StringConstants.setBoldPersianFont(),
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                      ),
                    ),
                    state.getRelateds.fold(
                      (exceptionMessage) {
                        return const SliverToBoxAdapter();
                      },
                      (relatedList) {
                        return SliverPadding(
                          padding:
                              const EdgeInsets.only(left: 20.0, bottom: 20.0),
                          sliver: SliverGrid(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      routeCondition(
                                          context, relatedList[index]);
                                    },
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      child: SizedBox(
                                        width: 100,
                                        child: FittedBox(
                                          fit: BoxFit.cover,
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                relatedList[index].thumbnail,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              childCount: relatedList.length,
                            ),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisExtent: 200,
                            ),
                          ),
                        );
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
      ),
    );
  }
}

class Gallery extends StatefulWidget {
  const Gallery({super.key, required this.gallery});
  final List<Moviesgallery> gallery;

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  final PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    widget.gallery.shuffle();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: 155,
            child: PageView.builder(
              itemCount: widget.gallery.length,
              controller: controller,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 154,
                  width: 315,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(16),
                      ),
                      child: SizedBox(
                        height: 154,
                        width: 305,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: CachedImage(
                            imageUrl: widget.gallery[index].thumbnail,
                            radius: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SmoothPageIndicator(
          controller: controller,
          count: widget.gallery.length,
          effect: CustomizableEffect(
            spacing: 8.0,
            dotDecoration: DotDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
              rotationAngle: 0.0,
              width: 15.0,
            ),
            activeDotDecoration: DotDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
              rotationAngle: 160.0,
              width: 15.0,
            ),
          ),
        ),
      ],
    );
  }
}

class _SeasonChip extends StatefulWidget {
  const _SeasonChip({required this.seasons, required this.seriesName});
  final List<SeriesSeasons> seasons;
  final String seriesName;

  @override
  State<_SeasonChip> createState() => __SeasonChipState();
}

class __SeasonChipState extends State<_SeasonChip> {
  List<String> items = [];
  String? selectedValue;

  @override
  void initState() {
    items = widget.seasons.map((e) => e.season).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        Text(
          AppLocalizations.of(context)!.episodes,
          style: TextStyle(
            fontFamily: StringConstants.setBoldPersianFont(),
            fontSize: 16,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        const SizedBox(height: 5),
        DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            items: items
                .map((String item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        "Season $item",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: StringConstants.setBoldPersianFont(),
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ))
                .toList(),
            hint: Text(
              'Season 1',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.tertiary,
                fontFamily: StringConstants.setBoldPersianFont(),
              ),
            ),
            value: selectedValue,
            onChanged: (String? value) {
              setState(() {
                selectedValue = value;
              });
              context.read<SeriesBloc>().add(
                    SeriesEpisodesFetchEvent(
                      widget.seasons[items.indexOf(selectedValue!)].id,
                      widget.seasons[items.indexOf(selectedValue!)].seriesId,
                      widget.seriesName,
                    ),
                  );
            },
            buttonStyleData: ButtonStyleData(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 40,
              width: 130,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                color: Theme.of(context).colorScheme.secondary,
              ),
              elevation: 2,
            ),
            iconStyleData: IconStyleData(
              icon: SvgPicture.asset(
                'assets/images/icon_arrow_down.svg',
                height: 24,
                width: 24,
              ),
            ),
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
            ),
          ),
        ),
      ],
    );
  }
}

class _StoryLine extends StatelessWidget {
  const _StoryLine({required this.storyLine});
  final String storyLine;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.storyLine,
          style: TextStyle(
            fontFamily: StringConstants.setBoldPersianFont(),
            fontSize: (MediaQueryHandler.screenWidth(context) < 350) ? 14 : 16,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          storyLine,
          style: TextStyle(
            fontFamily: StringConstants.setSmallPersionFont(),
            fontSize: (MediaQueryHandler.screenWidth(context) < 350) ? 12 : 14,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
      ],
    );
  }
}

class _MovieDetailHeader extends StatelessWidget {
  const _MovieDetailHeader({required this.series, required this.onLike});
  final Movie series;
  final bool onLike;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          SizedBox(
            height: 552,
            width: MediaQuery.of(context).size.width,
            child: FittedBox(
              fit: BoxFit.fill,
              child: CachedImage(
                imageUrl: series.thumbnail,
                radius: 0,
              ),
            ),
          ),
          Container(
            height: 552,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(
                width: 0,
                color: PrimaryColors.darkColor,
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  PrimaryColors.darkColor.withOpacity(0.6),
                  PrimaryColors.darkColor,
                ],
              ),
            ),
          ),
          _MovieHeaderContent(
            series: series,
            isLiked: onLike,
          ),
        ],
      ),
    );
  }
}

class _MovieHeaderContent extends StatefulWidget {
  const _MovieHeaderContent({required this.series, required this.isLiked});
  final Movie series;
  final bool isLiked;

  @override
  State<_MovieHeaderContent> createState() => _MovieHeaderContentState();
}

class _MovieHeaderContentState extends State<_MovieHeaderContent>
    with TickerProviderStateMixin {
  late final AnimationController controller;
  bool isLiked = false;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    isLiked = isLiked;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset(
                  'assets/images/icon_arrow_back.svg',
                ),
              ),
              SizedBox(
                width: 170,
                child: Text(
                  widget.series.name,
                  style: TextStyle(
                    fontFamily: StringConstants.setBoldPersianFont(),
                    fontSize: (MediaQueryHandler.screenWidth(context) < 350)
                        ? 14
                        : 16,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    headerLogics();
                  });
                },
                child: Container(
                  height:
                      (MediaQueryHandler.screenWidth(context) < 350) ? 28 : 32,
                  width:
                      (MediaQueryHandler.screenWidth(context) < 350) ? 28 : 32,
                  decoration: ShapeDecoration(
                    shape: const ContinuousRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(40),
                      ),
                    ),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  child: Transform.scale(
                    scale: 1.3,
                    child: Lottie.asset(
                      'assets/Animation - 1710000521327.json',
                      controller: controller,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 35),
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
            child: SizedBox(
              height:
                  (MediaQueryHandler.screenWidth(context) < 350) ? 243 : 287,
              width: (MediaQueryHandler.screenWidth(context) < 350) ? 165 : 205,
              child: FittedBox(
                fit: BoxFit.cover,
                child: CachedImage(
                  imageUrl: widget.series.thumbnail,
                  radius: 12,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/icon_calendar.svg',
                  height:
                      (MediaQueryHandler.screenWidth(context) < 350) ? 12 : 16,
                  width:
                      (MediaQueryHandler.screenWidth(context) < 350) ? 12 : 16,
                  colorFilter: const ColorFilter.mode(
                    TextColors.greyText,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 3.0),
                Text(
                  widget.series.year,
                  style: TextStyle(
                    fontFamily: StringConstants.setMediumPersionFont(),
                    fontSize: (MediaQueryHandler.screenWidth(context) < 350)
                        ? 10
                        : 12,
                    color: TextColors.greyText,
                  ),
                ),
                const SizedBox(width: 3.0),
                const VerticalDivider(
                  thickness: 1.3,
                  color: TextColors.greyText,
                ),
                const SizedBox(width: 3.0),
                SvgPicture.asset(
                  'assets/images/icon_clock.svg',
                  height:
                      (MediaQueryHandler.screenWidth(context) < 350) ? 12 : 16,
                  width:
                      (MediaQueryHandler.screenWidth(context) < 350) ? 12 : 16,
                  colorFilter: const ColorFilter.mode(
                    TextColors.greyText,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 3.0),
                Text(
                  "${widget.series.timeLength} ${AppLocalizations.of(context)!.minutes}",
                  style: TextStyle(
                    fontFamily: StringConstants.setMediumPersionFont(),
                    fontSize: (MediaQueryHandler.screenWidth(context) < 350)
                        ? 10
                        : 12,
                    color: TextColors.greyText,
                  ),
                ),
                const SizedBox(width: 3.0),
                const VerticalDivider(
                  thickness: 1.3,
                  color: TextColors.greyText,
                ),
                const SizedBox(width: 3.0),
                SvgPicture.asset(
                  'assets/images/icon_film.svg',
                  height:
                      (MediaQueryHandler.screenWidth(context) < 350) ? 12 : 16,
                  width:
                      (MediaQueryHandler.screenWidth(context) < 350) ? 12 : 16,
                  colorFilter: const ColorFilter.mode(
                    TextColors.greyText,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 3.0),
                Text(
                  widget.series.genre,
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
          ),
          const SizedBox(height: 15.0),
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            child: ColoredBox(
              color: Theme.of(context).colorScheme.primaryContainer,
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
                        Theme.of(context).colorScheme.secondaryContainer,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      widget.series.rate,
                      style: TextStyle(
                        fontFamily: StringConstants.setMediumPersionFont(),
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.secondaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                          child: BlocProvider(
                            create: (context) => VideoBloc(locator.get())
                              ..add(FetchTrailerEvent(widget.series.id)),
                            child: const MainVideoBranch(),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32),
                  ),
                  child: ColoredBox(
                    color: Theme.of(context).colorScheme.primary,
                    child: SizedBox(
                      height: (MediaQueryHandler.screenWidth(context) < 350)
                          ? 32
                          : 48,
                      width: (MediaQueryHandler.screenWidth(context) < 350)
                          ? 100
                          : 115,
                      child: Center(
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 25, right: 10),
                              child: SvgPicture.asset(
                                'assets/images/icon_play.svg',
                                height:
                                    (MediaQueryHandler.screenWidth(context) <
                                            350)
                                        ? 18
                                        : 20,
                                width: (MediaQueryHandler.screenWidth(context) <
                                        350)
                                    ? 18
                                    : 20,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              AppLocalizations.of(context)!.play,
                              style: TextStyle(
                                fontFamily:
                                    StringConstants.setMediumPersionFont(),
                                fontSize:
                                    (MediaQueryHandler.screenWidth(context) <
                                            350)
                                        ? 12
                                        : 16,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15.0),
              ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(100),
                ),
                child: ColoredBox(
                  color: Theme.of(context).colorScheme.secondary,
                  child: SizedBox(
                    height: (MediaQueryHandler.screenWidth(context) < 350)
                        ? 32
                        : 48,
                    width: (MediaQueryHandler.screenWidth(context) < 350)
                        ? 32
                        : 48,
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/images/icon_download.svg',
                        height: (MediaQueryHandler.screenWidth(context) < 350)
                            ? 18
                            : 24,
                        width: (MediaQueryHandler.screenWidth(context) < 350)
                            ? 18
                            : 24,
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15.0),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: SnackbarContent(
                        message: AppLocalizations.of(context)!.futureShare,
                        color: Theme.of(context).colorScheme.surfaceVariant,
                      ),
                      elevation: 0,
                      closeIconColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(100),
                  ),
                  child: ColoredBox(
                    color: Theme.of(context).colorScheme.secondary,
                    child: SizedBox(
                      height: (MediaQueryHandler.screenWidth(context) < 350)
                          ? 32
                          : 48,
                      width: (MediaQueryHandler.screenWidth(context) < 350)
                          ? 32
                          : 48,
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/images/icon_share.svg',
                          height: (MediaQueryHandler.screenWidth(context) < 350)
                              ? 18
                              : 24,
                          width: (MediaQueryHandler.screenWidth(context) < 350)
                              ? 18
                              : 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  headerLogics() {
    if (isLiked) {
      context
          .read<SeriesBloc>()
          .add(WishlistDeleteItemEvent(widget.series.name));
      context.read<WishlistBloc>().add(WishlistFetchCartsEvent());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          backgroundColor: Colors.transparent,
          content: SnackbarContent(
            message:
                "${widget.series.name} ${AppLocalizations.of(context)!.removeFromWishlist}",
            color: Theme.of(context).colorScheme.tertiaryContainer,
          ),
          duration: const Duration(seconds: 5),
        ),
      );
      controller.reverse();
      isLiked = false;
    } else if (!isLiked) {
      context.read<SeriesBloc>().add(
            WishlistAddToCartEvent(widget.series),
          );
      context.read<WishlistBloc>().add(WishlistFetchCartsEvent());
      controller.forward();
      isLiked = true;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          backgroundColor: Colors.transparent,
          content: SnackbarContent(
            message:
                "${widget.series.name} ${AppLocalizations.of(context)!.isAddedToWishlist}",
            color: Theme.of(context).colorScheme.surfaceVariant,
          ),
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }
}

class SeriesCastAndCrew extends StatelessWidget {
  const SeriesCastAndCrew({super.key, required this.casts});
  final List<SeriesCasts> casts;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        Text(
          AppLocalizations.of(context)!.casts,
          style: TextStyle(
            fontFamily: StringConstants.setBoldPersianFont(),
            fontSize: (MediaQueryHandler.screenWidth(context) < 350) ? 14 : 16,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: casts.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(100),
                      ),
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: CachedImage(
                            imageUrl: casts[index].thumbnail,
                            radius: 100,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          casts[index].name,
                          style: TextStyle(
                            fontFamily: StringConstants.setBoldPersianFont(),
                            fontSize:
                                (MediaQueryHandler.screenWidth(context) < 350)
                                    ? 12
                                    : 14,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        Text(
                          casts[index].role,
                          style: TextStyle(
                            fontFamily: StringConstants.setMediumPersionFont(),
                            fontSize:
                                (MediaQueryHandler.screenWidth(context) < 350)
                                    ? 8
                                    : 10,
                            color: TextColors.greyText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
