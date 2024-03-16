import 'dart:ui';
import 'package:cinemax/bloc/upcomings/upcomingDetail/updetail_bloc.dart';
import 'package:cinemax/bloc/upcomings/upcomingDetail/updetail_state.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/data/model/upcoming_cast.dart';
import 'package:cinemax/data/model/upcoming_gallery.dart';
import 'package:cinemax/data/model/upcomings.dart';
import 'package:cinemax/ui/gallery_full_screen.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/back_label.dart';
import 'package:cinemax/widgets/cached_image.dart';
import 'package:cinemax/widgets/exception_message.dart';
import 'package:cinemax/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpcomingMovieDetail extends StatelessWidget {
  const UpcomingMovieDetail({super.key, required this.upcomingItem});
  final Upcomings upcomingItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: BlocBuilder<UpDetailBloc, UpDetailState>(
          builder: (context, state) {
            if (state is UpDetailLoadingState) {
              return const AppLoadingIndicator();
            } else if (state is UpDetailResponseState) {
              return SafeArea(
                child: CustomScrollView(
                  slivers: [
                    _Header(
                      upcomingtitle: upcomingItem.name,
                    ),
                    MovieHeadDetail(
                      upcomingItem: upcomingItem,
                    ),
                    _Synopsis(
                      synopsis: upcomingItem.synopsis,
                    ),
                    state.casts.fold(
                      (exceptionMessage) {
                        return const SliverToBoxAdapter(
                          child: ExceptionMessage(),
                        );
                      },
                      (castList) {
                        return SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: UpcomingCastAndCrew(
                              casts: castList,
                            ),
                          ),
                        );
                      },
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.gallery,
                              style: TextStyle(
                                fontFamily: "MSB",
                                fontSize:
                                    (MediaQueryHandler.screenWidth(context) <
                                            350)
                                        ? 14
                                        : 16,
                                color: TextColors.whiteText,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                          ],
                        ),
                      ),
                    ),
                    state.getphotos.fold(
                      (exceptionMessage) {
                        return const SliverToBoxAdapter(
                          child: ExceptionMessage(),
                        );
                      },
                      (gallery) {
                        return _Gallery(
                          photoList: gallery,
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
        ));
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
  final List<UpcomingGallery> photoList;

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

class _Synopsis extends StatelessWidget {
  const _Synopsis({required this.synopsis});
  final String synopsis;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.synopsis,
              style: TextStyle(
                fontFamily: "MSB",
                fontSize:
                    (MediaQueryHandler.screenWidth(context) < 350) ? 14 : 16,
                color: TextColors.whiteText,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              synopsis,
              style: TextStyle(
                fontFamily: "MR",
                fontSize:
                    (MediaQueryHandler.screenWidth(context) < 350) ? 12 : 14,
                color: TextColors.whiteText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieHeadDetail extends StatelessWidget {
  const MovieHeadDetail({super.key, required this.upcomingItem});
  final Upcomings upcomingItem;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 40.0, left: 20, right: 20),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              child: SizedBox(
                height: 180,
                width: MediaQuery.of(context).size.width,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: CachedImage(
                    imageUrl: upcomingItem.thumbnail,
                    radius: 20,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Text(
                  upcomingItem.name,
                  style: TextStyle(
                    fontFamily: "MSB",
                    fontSize: (MediaQueryHandler.screenWidth(context) < 350)
                        ? 14
                        : 16,
                    color: TextColors.whiteText,
                  ),
                ),
                const SizedBox(height: 7),
                SizedBox(
                  height: 16,
                  child: Row(
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
                        "${AppLocalizations.of(context)!.releaseDate}: ",
                        style: TextStyle(
                          fontFamily: "MM",
                          fontSize:
                              (MediaQueryHandler.screenWidth(context) < 350)
                                  ? 10
                                  : 12,
                          color: TextColors.greyText,
                        ),
                      ),
                      Text(
                        "${upcomingItem.releaseMonth} ${upcomingItem.releaseDate}, ${upcomingItem.releaseYear}",
                        style: TextStyle(
                          fontFamily: "MM",
                          fontSize:
                              (MediaQueryHandler.screenWidth(context) < 350)
                                  ? 10
                                  : 12,
                          color: TextColors.whiteText,
                        ),
                      ),
                      const VerticalDivider(
                        thickness: 1.3,
                        color: TextColors.greyText,
                      ),
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
                        upcomingItem.genre,
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatefulWidget {
  const _Header({required this.upcomingtitle});
  final String upcomingtitle;

  @override
  State<_Header> createState() => _HeaderState();
}

class _HeaderState extends State<_Header> with TickerProviderStateMixin {
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
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const BackLabel(),
                ),
                Text(
                  widget.upcomingtitle,
                  style: const TextStyle(
                    fontFamily: "MSB",
                    fontSize: 16,
                    color: TextColors.whiteText,
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
          ],
        ),
      ),
    );
  }
}

class UpcomingCastAndCrew extends StatelessWidget {
  const UpcomingCastAndCrew({super.key, required this.casts});
  final List<UpcomingsCasts> casts;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.casts,
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
