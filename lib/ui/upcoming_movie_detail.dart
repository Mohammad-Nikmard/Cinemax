import 'package:cinemax/bloc/upcomings/upcomingDetail/updetail_bloc.dart';
import 'package:cinemax/bloc/upcomings/upcomingDetail/updetail_state.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/data/model/upcoming_gallery.dart';
import 'package:cinemax/data/model/upcomings.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/back_label.dart';
import 'package:cinemax/widgets/cached_image.dart';
import 'package:cinemax/widgets/cast_crew_widget.dart';
import 'package:cinemax/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

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
              return CustomScrollView(
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
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: CastAndCrewWidget(),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Gallery",
                            style: TextStyle(
                              fontFamily: "MSB",
                              fontSize:
                                  (MediaQueryHandler.screenWidth(context) < 350)
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
                      return Text("exceptionMessage");
                    },
                    (gallery) {
                      return _Gallery(
                        photoList: gallery,
                      );
                    },
                  ),
                ],
              );
            }
            return Text("There seem to be errors Getting data");
          },
        ));
  }
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

class _Synopsis extends StatelessWidget {
  const _Synopsis({required this.synopsis});
  final String synopsis;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Synopsis",
              style: TextStyle(
                fontFamily: "MSB",
                fontSize:
                    (MediaQueryHandler.screenWidth(context) < 350) ? 14 : 16,
                color: TextColors.whiteText,
              ),
            ),
            const SizedBox(height: 10.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    synopsis,
                    style: TextStyle(
                      fontFamily: "MR",
                      fontSize: (MediaQueryHandler.screenWidth(context) < 350)
                          ? 12
                          : 14,
                      color: TextColors.whiteText,
                    ),
                  ),
                ),
                Text(
                  "More",
                  style: TextStyle(
                    fontFamily: "MSB",
                    fontSize: (MediaQueryHandler.screenWidth(context) < 350)
                        ? 12
                        : 14,
                    color: PrimaryColors.blueAccentColor,
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
                      Image.asset(
                        'assets/images/icon_calendar.png',
                        height: (MediaQueryHandler.screenWidth(context) < 350)
                            ? 12
                            : 16,
                        width: (MediaQueryHandler.screenWidth(context) < 350)
                            ? 12
                            : 16,
                        color: TextColors.greyText,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        "Relase Date: ",
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
                      const SizedBox(width: 5),
                      const VerticalDivider(
                        thickness: 1.3,
                        color: TextColors.greyText,
                      ),
                      const SizedBox(width: 5),
                      Image.asset(
                        'assets/images/icon_film.png',
                        height: (MediaQueryHandler.screenWidth(context) < 350)
                            ? 12
                            : 16,
                        width: (MediaQueryHandler.screenWidth(context) < 350)
                            ? 12
                            : 16,
                        color: TextColors.greyText,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        upcomingItem.genre,
                        style: TextStyle(
                          fontFamily: "MM",
                          fontSize:
                              (MediaQueryHandler.screenWidth(context) < 350)
                                  ? 10
                                  : 12,
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
              height: 30,
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
