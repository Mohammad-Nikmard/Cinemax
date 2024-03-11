import 'dart:ui';
import 'package:cinemax/bloc/movies/movies_bloc.dart';
import 'package:cinemax/bloc/movies/movies_state.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/data/model/movie_casts.dart';
import 'package:cinemax/data/model/moviegallery.dart';
import 'package:cinemax/data/model/movie.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/cached_image.dart';
import 'package:cinemax/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({super.key, required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocBuilder<MovieBloc, MoviesState>(
        builder: (context, state) {
          if (state is MoviesLoadingState) {
            return const AppLoadingIndicator();
          } else if (state is MoviesresponseState) {
            return CustomScrollView(
              slivers: [
                _MovieDetailHeader(
                  movie: movie,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _StoryLine(
                          storyLine: movie.storyline,
                        ),
                        state.castList.fold(
                          (l) {
                            return SliverToBoxAdapter(
                              child: Text("exceptionMessage"),
                            );
                          },
                          (castList) {
                            return MovieCastAndCrew(
                              casts: castList,
                            );
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 20.0, top: 20.0),
                          child: Column(
                            children: [
                              Text(
                                "Gallery",
                                style: TextStyle(
                                  fontFamily: "MSB",
                                  fontSize: 16,
                                  color: TextColors.whiteText,
                                ),
                              ),
                              SizedBox(height: 10.0),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                state.getPhotos.fold(
                  (exceptionMessage) {
                    return SliverToBoxAdapter(
                      child: Text("exceptionMessage"),
                    );
                  },
                  (photoList) {
                    return _Gallery(
                      photoList: photoList,
                    );
                  },
                )
              ],
            );
          }
          return Text("There seem to be errors Getting data");
        },
      ),
    );
  }
}

class _Gallery extends StatelessWidget {
  const _Gallery({required this.photoList});
  final List<Moviesgallery> photoList;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
              child: SizedBox(
                height: 100,
                width: 100,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: CachedImage(
                    imageUrl: photoList[index].thumbnail,
                    radius: 15,
                  ),
                ),
              ),
            );
          },
          childCount: photoList.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
      ),
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
          "Story Line",
          style: TextStyle(
            fontFamily: "MSB",
            fontSize: (MediaQueryHandler.screenWidth(context) < 350) ? 14 : 16,
            color: TextColors.whiteText,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: Text(
                storyLine,
                style: TextStyle(
                  fontFamily: "MR",
                  fontSize:
                      (MediaQueryHandler.screenWidth(context) < 350) ? 12 : 14,
                  color: TextColors.whiteText,
                ),
              ),
            ),
            Text(
              "More",
              style: TextStyle(
                fontFamily: "MSB",
                fontSize:
                    (MediaQueryHandler.screenWidth(context) < 350) ? 12 : 14,
                color: PrimaryColors.blueAccentColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MovieDetailHeader extends StatelessWidget {
  const _MovieDetailHeader({required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          SizedBox(
            height: 552,
            width: MediaQuery.of(context).size.width,
            child: FittedBox(
              fit: BoxFit.cover,
              child: CachedImage(
                imageUrl: movie.thumbnail,
                radius: 0,
              ),
            ),
          ),
          Container(
            height: 600,
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
                  PrimaryColors.darkColor.withOpacity(0.7),
                  PrimaryColors.darkColor,
                ],
              ),
            ),
          ),
          _MovieHeaderContent(
            movie: movie,
          ),
        ],
      ),
    );
  }
}

class _MovieHeaderContent extends StatefulWidget {
  const _MovieHeaderContent({required this.movie});
  final Movie movie;

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
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset('assets/images/icon_arrow_back.png'),
              ),
              SizedBox(
                width: 170,
                child: Text(
                  widget.movie.name,
                  style: TextStyle(
                    fontFamily: "MSB",
                    fontSize: (MediaQueryHandler.screenWidth(context) < 350)
                        ? 14
                        : 16,
                    color: TextColors.whiteText,
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (isLiked) {
                      controller.reverse();
                      isLiked = false;
                    } else if (!isLiked) {
                      controller.forward();
                      isLiked = true;
                    }
                  });
                },
                child: Container(
                  height:
                      (MediaQueryHandler.screenWidth(context) < 350) ? 28 : 32,
                  width:
                      (MediaQueryHandler.screenWidth(context) < 350) ? 28 : 32,
                  decoration: const ShapeDecoration(
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(40),
                      ),
                    ),
                    color: PrimaryColors.softColor,
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
          const SizedBox(height: 50),
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
                  imageUrl: widget.movie.thumbnail,
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
                Image.asset(
                  'assets/images/icon_calendar.png',
                  color: TextColors.greyText,
                  height:
                      (MediaQueryHandler.screenWidth(context) < 350) ? 12 : 16,
                  width:
                      (MediaQueryHandler.screenWidth(context) < 350) ? 12 : 16,
                ),
                const SizedBox(width: 3.0),
                Text(
                  widget.movie.year,
                  style: TextStyle(
                    fontFamily: "MM",
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
                Image.asset(
                  'assets/images/icon_clock.png',
                  color: TextColors.greyText,
                  height:
                      (MediaQueryHandler.screenWidth(context) < 350) ? 12 : 16,
                  width:
                      (MediaQueryHandler.screenWidth(context) < 350) ? 12 : 16,
                ),
                const SizedBox(width: 3.0),
                Text(
                  widget.movie.timeLength,
                  style: TextStyle(
                    fontFamily: "MM",
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
                Image.asset(
                  'assets/images/icon_film.png',
                  color: TextColors.greyText,
                  height:
                      (MediaQueryHandler.screenWidth(context) < 350) ? 12 : 16,
                  width:
                      (MediaQueryHandler.screenWidth(context) < 350) ? 12 : 16,
                ),
                const SizedBox(width: 3.0),
                Text(
                  widget.movie.genre,
                  style: TextStyle(
                    fontFamily: "MM",
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
          Container(
            height: 24,
            width: 55,
            decoration: const BoxDecoration(
              color: Color(0xff252836),
              borderRadius: BorderRadius.all(
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
                  widget.movie.rate,
                  style: const TextStyle(
                    fontFamily: "MM",
                    fontSize: 12,
                    color: SecondaryColors.orangeColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height:
                    (MediaQueryHandler.screenWidth(context) < 350) ? 32 : 48,
                width:
                    (MediaQueryHandler.screenWidth(context) < 350) ? 100 : 115,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(32),
                  ),
                  color: SecondaryColors.orangeColor,
                ),
                child: Center(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Image.asset(
                          'assets/images/icon_play.png',
                          height: (MediaQueryHandler.screenWidth(context) < 350)
                              ? 18
                              : 24,
                          width: (MediaQueryHandler.screenWidth(context) < 350)
                              ? 18
                              : 24,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "Play",
                        style: TextStyle(
                          fontFamily: "MM",
                          fontSize:
                              (MediaQueryHandler.screenWidth(context) < 350)
                                  ? 12
                                  : 16,
                          color: TextColors.whiteText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 15.0),
              Container(
                height:
                    (MediaQueryHandler.screenWidth(context) < 350) ? 32 : 48,
                width: (MediaQueryHandler.screenWidth(context) < 350) ? 32 : 48,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: PrimaryColors.softColor,
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/icon_download.png',
                    color: SecondaryColors.orangeColor,
                    height: (MediaQueryHandler.screenWidth(context) < 350)
                        ? 18
                        : 24,
                    width: (MediaQueryHandler.screenWidth(context) < 350)
                        ? 18
                        : 24,
                  ),
                ),
              ),
              const SizedBox(width: 15.0),
              GestureDetector(
                onTap: () {
                  shareDialog(context);
                },
                child: Container(
                  height:
                      (MediaQueryHandler.screenWidth(context) < 350) ? 32 : 48,
                  width:
                      (MediaQueryHandler.screenWidth(context) < 350) ? 32 : 48,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: PrimaryColors.softColor,
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/icon_share.png',
                      color: PrimaryColors.blueAccentColor,
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
            ],
          ),
        ],
      ),
    );
  }
}

Future<void> shareDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) {
      return ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: AlertDialog(
            backgroundColor: PrimaryColors.softColor,
            content: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: const BoxDecoration(
                          color: Color(0xff252836),
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          'assets/images/icon_close.png',
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Center(
                      child: Text(
                        "Share to",
                        style: TextStyle(
                          fontFamily: "MSB",
                          fontSize: 18,
                          color: TextColors.whiteText,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Divider(
                      thickness: 1.33,
                      color: PrimaryColors.darkColor,
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/Apple.png',
                          height: 49,
                          width: 49,
                        ),
                        const SizedBox(width: 15),
                        Image.asset(
                          'assets/images/Facebook.png',
                          height: 49,
                          width: 49,
                        ),
                        const SizedBox(width: 15),
                        Image.asset(
                          'assets/images/Google.png',
                          height: 49,
                          width: 49,
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
    },
  );
}

class MovieCastAndCrew extends StatelessWidget {
  const MovieCastAndCrew({super.key, required this.casts});
  final List<MovieCasts> casts;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        Text(
          "Cast and Crew",
          style: TextStyle(
            fontFamily: "MSB",
            fontSize: (MediaQueryHandler.screenWidth(context) < 350) ? 14 : 16,
            color: TextColors.whiteText,
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
                            fontFamily: "MSB",
                            fontSize:
                                (MediaQueryHandler.screenWidth(context) < 350)
                                    ? 12
                                    : 14,
                            color: TextColors.whiteText,
                          ),
                        ),
                        Text(
                          casts[index].role,
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
