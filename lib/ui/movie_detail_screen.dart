import 'dart:ui';
import 'package:cinemax/DI/service_locator.dart';
import 'package:cinemax/bloc/comments/comment_bloc.dart';
import 'package:cinemax/bloc/comments/comment_event.dart';
import 'package:cinemax/bloc/movies/movies_bloc.dart';
import 'package:cinemax/bloc/movies/movies_event.dart';
import 'package:cinemax/bloc/movies/movies_state.dart';
import 'package:cinemax/bloc/video/video_bloc.dart';
import 'package:cinemax/bloc/video/video_event.dart';
import 'package:cinemax/bloc/wishlist/wishlist_bloc.dart';
import 'package:cinemax/bloc/wishlist/wishlist_event.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/constants/string_constants.dart';
import 'package:cinemax/data/model/movie_casts.dart';
import 'package:cinemax/data/model/moviegallery.dart';
import 'package:cinemax/data/model/movie.dart';
import 'package:cinemax/ui/comments_screen.dart';
import 'package:cinemax/ui/gallery_full_screen.dart';
import 'package:cinemax/util/app_manager.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/cached_image.dart';
import 'package:cinemax/widgets/comment_section.dart';
import 'package:cinemax/widgets/downloader.dart';
import 'package:cinemax/widgets/exception_message.dart';
import 'package:cinemax/widgets/shimmer_skelton.dart';
import 'package:cinemax/widgets/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shimmer/shimmer.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({super.key, required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MovieBloc(locator.get(), locator.get(), locator.get())
            ..add(MoviesDataRequestEvent(movie.id, movie.name)),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: BlocBuilder<MovieBloc, MoviesState>(
          builder: (context, state) {
            if (state is MoviesLoadingState) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[100]!,
                child: const MovieDetailLoading(),
              );
            } else if (state is MoviesresponseState) {
              return CustomScrollView(
                slivers: [
                  _MovieDetailHeader(
                    movie: movie,
                    isLiked: state.isLiked,
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
                            (exceptionMessage) {
                              return const ExceptionMessage();
                            },
                            (castList) {
                              return MovieCastAndCrew(
                                casts: castList,
                              );
                            },
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 20.0, top: 20.0),
                            child: Column(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.gallery,
                                  style: TextStyle(
                                    fontFamily:
                                        StringConstants.setBoldPersianFont(),
                                    fontSize: 16,
                                    color: TextColors.whiteText,
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  state.getPhotos.fold(
                    (exceptionMessage) {
                      return const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: ExceptionMessage(),
                        ),
                      );
                    },
                    (photoList) {
                      return _Gallery(
                        photoList: photoList,
                      );
                    },
                  ),
                  state.getComments.fold(
                    (l) {
                      return const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: ExceptionMessage(),
                        ),
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
                                  create: (context) =>
                                      CommentsBloc(locator.get())
                                        ..add(
                                          CommentFetchEvent(movie.id),
                                        ),
                                  child: CommentsScreen(
                                    movieName: movie.name,
                                    year: movie.year,
                                    imageURL: movie.thumbnail,
                                    movieID: movie.id,
                                  ),
                                ),
                                withNavBar: false,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 25, bottom: 20),
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
                                  create: (context) =>
                                      CommentsBloc(locator.get())
                                        ..add(
                                          CommentFetchEvent(movie.id),
                                        ),
                                  child: CommentsScreen(
                                    movieName: movie.name,
                                    year: movie.year,
                                    imageURL: movie.thumbnail,
                                    movieID: movie.id,
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
                ],
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

Future<void> showFullScreenGallery(BuildContext context, String photo) async {
  return showDialog(
    context: context,
    builder: (context) {
      return ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: AlertDialog(
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            content: GalleryFullScreen(
              imageURL: photo,
            ),
          ),
        ),
      );
    },
  );
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
            return GestureDetector(
              onTap: () {
                showFullScreenGallery(context, photoList[index].thumbnail);
              },
              child: ClipRRect(
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
          AppLocalizations.of(context)!.storyLine,
          style: TextStyle(
            fontFamily: StringConstants.setBoldPersianFont(),
            fontSize: (MediaQueryHandler.screenWidth(context) < 350) ? 14 : 16,
            color: TextColors.whiteText,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          storyLine,
          style: TextStyle(
            fontFamily: StringConstants.setSmallPersionFont(),
            fontSize: (MediaQueryHandler.screenWidth(context) < 350) ? 12 : 14,
            color: TextColors.whiteText,
          ),
        ),
      ],
    );
  }
}

class _MovieDetailHeader extends StatelessWidget {
  const _MovieDetailHeader({required this.movie, required this.isLiked});
  final Movie movie;
  final bool isLiked;

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
            isOnLikes: isLiked,
          ),
        ],
      ),
    );
  }
}

class _MovieHeaderContent extends StatefulWidget {
  const _MovieHeaderContent({required this.movie, required this.isOnLikes});
  final Movie movie;
  final bool isOnLikes;

  @override
  State<_MovieHeaderContent> createState() => _MovieHeaderContentState();
}

class _MovieHeaderContentState extends State<_MovieHeaderContent>
    with TickerProviderStateMixin {
  late final AnimationController controller;
  bool? isLiked;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    isLiked = widget.isOnLikes;
    if (!isLiked!) {
      controller.value = 0.0;
    } else if (isLiked!) {
      controller.value = 1.0;
    }
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
                  widget.movie.name,
                  style: TextStyle(
                    fontFamily: StringConstants.setBoldPersianFont(),
                    fontSize: (MediaQueryHandler.screenWidth(context) < 350)
                        ? 14
                        : 16,
                    color: TextColors.whiteText,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (isLiked!) {
                      context
                          .read<MovieBloc>()
                          .add(WishlistDeleteItemEvent(widget.movie.name));
                      context
                          .read<WishlistBloc>()
                          .add(WishlistFetchCartsEvent());
                      controller.reverse();
                      isLiked = false;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          backgroundColor: Colors.transparent,
                          content: _SnackbarContent(
                            message:
                                "${widget.movie.name} ${AppLocalizations.of(context)!.removeFromWishlist}",
                            color: SecondaryColors.redColor,
                          ),
                          duration: const Duration(seconds: 5),
                        ),
                      );
                    } else if (!isLiked!) {
                      context.read<MovieBloc>().add(
                            WishlistAddToCartEvent(widget.movie),
                          );
                      context
                          .read<WishlistBloc>()
                          .add(WishlistFetchCartsEvent());
                      controller.forward();
                      isLiked = true;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          backgroundColor: Colors.transparent,
                          content: _SnackbarContent(
                            message:
                                "${widget.movie.name} ${AppLocalizations.of(context)!.isAddedToWishlist}",
                            color: SecondaryColors.greenColor,
                          ),
                          duration: const Duration(seconds: 5),
                        ),
                      );
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
                  widget.movie.year,
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
                  "${widget.movie.timeLength} ${AppLocalizations.of(context)!.minutes}",
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
                  widget.movie.genre,
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
                  widget.movie.rate,
                  style: TextStyle(
                    fontFamily: StringConstants.setMediumPersionFont(),
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
              GestureDetector(
                onTap: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: BlocProvider(
                      create: (context) => VideoBloc(locator.get())
                        ..add(FetchTrailerEvent(widget.movie.id)),
                      child: const MainVideoBranch(),
                    ),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                child: Container(
                  height:
                      (MediaQueryHandler.screenWidth(context) < 350) ? 32 : 48,
                  width: (MediaQueryHandler.screenWidth(context) < 350)
                      ? 100
                      : 115,
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
                          padding: const EdgeInsets.only(left: 25, right: 10),
                          child: SvgPicture.asset(
                            'assets/images/icon_play.svg',
                            height:
                                (MediaQueryHandler.screenWidth(context) < 350)
                                    ? 18
                                    : 20,
                            width:
                                (MediaQueryHandler.screenWidth(context) < 350)
                                    ? 18
                                    : 20,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          AppLocalizations.of(context)!.play,
                          style: TextStyle(
                            fontFamily: StringConstants.setMediumPersionFont(),
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
              ),
              const SizedBox(width: 15.0),
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
                              ..add(FetchTrailerEvent(widget.movie.id)),
                            child: const AppDownloader(),
                          ),
                        ),
                      );
                    },
                  );
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
                    child: SvgPicture.asset(
                      'assets/images/icon_download.svg',
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
              const SizedBox(width: 15.0),
              GestureDetector(
                onTap: () {
                  // shareDialog(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: _SnackbarContent(
                        message: AppLocalizations.of(context)!.futureShare,
                        color: SecondaryColors.greenColor,
                      ),
                      elevation: 0,
                      closeIconColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                      duration: const Duration(seconds: 2),
                    ),
                  );
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
                        child: SvgPicture.asset(
                          'assets/images/icon_close.svg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        AppLocalizations.of(context)!.share,
                        style: TextStyle(
                          fontFamily: StringConstants.setBoldPersianFont(),
                          fontSize: 20,
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
                        SvgPicture.asset(
                          "assets/images/telegram.svg",
                          height: 70,
                          width: 70,
                        ),
                        const SizedBox(width: 15),
                        SvgPicture.asset(
                          "assets/images/instagram.svg",
                          height: 61.5,
                          width: 61.5,
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
          AppLocalizations.of(context)!.casts,
          style: TextStyle(
            fontFamily: StringConstants.setBoldPersianFont(),
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
                            fontFamily: StringConstants.setBoldPersianFont(),
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

class _SnackbarContent extends StatelessWidget {
  const _SnackbarContent({required this.message, required this.color});
  final String message;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          AppManager.getLnag() == "fa" ? TextDirection.rtl : TextDirection.ltr,
      child: Container(
        width: MediaQueryHandler.screenWidth(context),
        height: 60,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 15, left: 15),
          child: Center(
            child: Text(
              message,
              style: TextStyle(
                color: TextColors.whiteText,
                fontSize: 12,
                fontFamily: StringConstants.setBoldPersianFont(),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class MovieDetailLoading extends StatelessWidget {
  const MovieDetailLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerSkelton(
                  height: 32,
                  width: 32,
                  radius: 100,
                ),
                ShimmerSkelton(
                  height: 20,
                  width: 100,
                  radius: 5,
                ),
                ShimmerSkelton(
                  height: 32,
                  width: 32,
                  radius: 100,
                ),
              ],
            ),
            const SizedBox(height: 40),
            const Center(
              child: ShimmerSkelton(
                height: 287,
                width: 205,
                radius: 15,
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: ShimmerSkelton(
                height: 20,
                width: 230,
                radius: 5,
              ),
            ),
            const SizedBox(height: 10),
            const Center(
              child: ShimmerSkelton(
                height: 20,
                width: 60,
                radius: 5,
              ),
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShimmerSkelton(
                  height: 48,
                  width: 100,
                  radius: 100,
                ),
                SizedBox(width: 15),
                ShimmerSkelton(
                  height: 48,
                  width: 48,
                  radius: 100,
                ),
                SizedBox(width: 15),
                ShimmerSkelton(
                  height: 48,
                  width: 48,
                  radius: 100,
                ),
              ],
            ),
            const SizedBox(height: 15),
            const ShimmerSkelton(
              height: 20,
              width: 100,
              radius: 5,
            ),
            const SizedBox(height: 15),
            ShimmerSkelton(
              height: 20,
              width: MediaQueryHandler.screenWidth(context),
              radius: 5,
            ),
            const SizedBox(height: 10),
            ShimmerSkelton(
              height: 20,
              width: MediaQueryHandler.screenWidth(context) - 70,
              radius: 5,
            ),
            const SizedBox(height: 10),
            ShimmerSkelton(
              height: 20,
              width: MediaQueryHandler.screenWidth(context) - 100,
              radius: 5,
            ),
          ],
        ),
      ),
    );
  }
}
