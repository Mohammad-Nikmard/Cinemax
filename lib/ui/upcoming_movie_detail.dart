import 'dart:ui';
import 'package:cinemax/DI/service_locator.dart';
import 'package:cinemax/bloc/upcomings/upcomingDetail/updetail_bloc.dart';
import 'package:cinemax/bloc/upcomings/upcomingDetail/updetail_event.dart';
import 'package:cinemax/bloc/upcomings/upcomingDetail/updetail_state.dart';
import 'package:cinemax/bloc/video/video_bloc.dart';
import 'package:cinemax/bloc/video/video_event.dart';
import 'package:cinemax/bloc/wishlist/wishlist_bloc.dart';
import 'package:cinemax/bloc/wishlist/wishlist_event.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/constants/string_constants.dart';
import 'package:cinemax/data/model/upcoming_cast.dart';
import 'package:cinemax/data/model/upcoming_gallery.dart';
import 'package:cinemax/data/model/upcomings.dart';
import 'package:cinemax/ui/gallery_full_screen.dart';
import 'package:cinemax/util/app_manager.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/back_label.dart';
import 'package:cinemax/widgets/cached_image.dart';
import 'package:cinemax/widgets/exception_message.dart';
import 'package:cinemax/widgets/shimmer_skelton.dart';
import 'package:cinemax/widgets/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';

class UpcomingMovieDetail extends StatelessWidget {
  const UpcomingMovieDetail({super.key, required this.upcomingItem});
  final Upcomings upcomingItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocProvider(
        create: (context) => UpDetailBloc(locator.get(), locator.get())
          ..add(UpDetailDataRequestEvent(upcomingItem.id, upcomingItem.name)),
        child: BlocBuilder<UpDetailBloc, UpDetailState>(
          builder: (context, state) {
            if (state is UpDetailLoadingState) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[100]!,
                child: const UpDetailLoading(),
              );
            } else if (state is UpDetailResponseState) {
              return SafeArea(
                child: CustomScrollView(
                  slivers: [
                    _Header(
                      upcomingItem: upcomingItem,
                      isOnLikes: state.isOnLikes,
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
                                fontFamily:
                                    StringConstants.setBoldPersianFont(),
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
                fontFamily: StringConstants.setBoldPersianFont(),
                fontSize:
                    (MediaQueryHandler.screenWidth(context) < 350) ? 14 : 16,
                color: TextColors.whiteText,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              synopsis,
              style: TextStyle(
                fontFamily: StringConstants.setSmallPersionFont(),
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
                            ..add(FetchUpcomingTrailerEvent(upcomingItem.id)),
                          child: const MainVideoBranch(),
                        ),
                      ),
                    );
                  },
                );
              },
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Stack(
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
                      ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                        child: SizedBox(
                          height: 180,
                          width: MediaQuery.of(context).size.width,
                          child: ColoredBox(
                            color: PrimaryColors.darkColor.withOpacity(0.3),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SvgPicture.asset(
                    'assets/images/icon_play_wishlist.svg',
                    height: 60,
                    width: 60,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Text(
                  upcomingItem.name,
                  style: TextStyle(
                    fontFamily: StringConstants.setBoldPersianFont(),
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
                          fontFamily: StringConstants.setMediumPersionFont(),
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
                          fontFamily: StringConstants.setMediumPersionFont(),
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
                          fontFamily: StringConstants.setMediumPersionFont(),
                          fontSize:
                              (MediaQueryHandler.screenWidth(context) < 350)
                                  ? 6
                                  : 8,
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
  const _Header({required this.upcomingItem, required this.isOnLikes});
  final Upcomings upcomingItem;
  final bool isOnLikes;

  @override
  State<_Header> createState() => _HeaderState();
}

class _HeaderState extends State<_Header> with TickerProviderStateMixin {
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
                  widget.upcomingItem.name,
                  style: TextStyle(
                    fontFamily: StringConstants.setBoldPersianFont(),
                    fontSize: 16,
                    color: TextColors.whiteText,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isLiked!) {
                        context.read<UpDetailBloc>().add(
                            DeleteWishlistItemEvent(widget.upcomingItem.name));
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
                            content: _SnackBarUnlikeMessage(
                              movieName: widget.upcomingItem.name,
                            ),
                            duration: const Duration(seconds: 5),
                          ),
                        );
                      } else if (!isLiked!) {
                        context.read<UpDetailBloc>().add(
                              UpcomingAddToCartEvent(widget.upcomingItem),
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
                            content: _SnackBarLikedMessage(
                              movieName: widget.upcomingItem.name,
                            ),
                            duration: const Duration(seconds: 5),
                          ),
                        );
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

class _SnackBarLikedMessage extends StatelessWidget {
  const _SnackBarLikedMessage({required this.movieName});
  final String movieName;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          AppManager.getLnag() == 'fa' ? TextDirection.rtl : TextDirection.ltr,
      child: Container(
        width: MediaQueryHandler.screenWidth(context),
        height: 60,
        decoration: const BoxDecoration(
          color: SecondaryColors.greenColor,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 15, left: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "$movieName ${AppLocalizations.of(context)!.isAddedToWishlist}",
                style: TextStyle(
                  color: TextColors.whiteText,
                  fontSize: 12,
                  fontFamily: StringConstants.setBoldPersianFont(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SnackBarUnlikeMessage extends StatelessWidget {
  const _SnackBarUnlikeMessage({required this.movieName});
  final String movieName;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          AppManager.getLnag() == 'fa' ? TextDirection.rtl : TextDirection.ltr,
      child: Container(
        width: MediaQueryHandler.screenWidth(context),
        height: 60,
        decoration: const BoxDecoration(
          color: SecondaryColors.redColor,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 15, left: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "$movieName ${AppLocalizations.of(context)!.removeFromWishlist}",
                style: TextStyle(
                  color: TextColors.whiteText,
                  fontSize: 12,
                  fontFamily: StringConstants.setBoldPersianFont(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UpDetailLoading extends StatelessWidget {
  const UpDetailLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
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
                    width: 150,
                    radius: 5,
                  ),
                  ShimmerSkelton(
                    height: 32,
                    width: 32,
                    radius: 100,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ShimmerSkelton(
                height: 180,
                width: MediaQueryHandler.screenWidth(context),
                radius: 20,
              ),
              const SizedBox(height: 15),
              const ShimmerSkelton(
                height: 20,
                width: 120,
                radius: 5,
              ),
              const SizedBox(height: 10),
              const ShimmerSkelton(
                height: 20,
                width: 210,
                radius: 5,
              ),
              const SizedBox(height: 30),
              const ShimmerSkelton(
                height: 20,
                width: 75,
                radius: 5,
              ),
              const SizedBox(height: 20),
              ShimmerSkelton(
                height: 20,
                width: MediaQueryHandler.screenWidth(context),
                radius: 5,
              ),
              const SizedBox(height: 8),
              ShimmerSkelton(
                height: 20,
                width: MediaQueryHandler.screenWidth(context) - 50,
                radius: 5,
              ),
              const SizedBox(height: 8),
              ShimmerSkelton(
                height: 20,
                width: MediaQueryHandler.screenWidth(context) - 100,
                radius: 5,
              ),
              const SizedBox(height: 30),
              const ShimmerSkelton(
                height: 20,
                width: 110,
                radius: 5,
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerSkelton(
                        height: 64,
                        width: 64,
                        radius: 100,
                      ),
                      SizedBox(height: 10),
                      ShimmerSkelton(
                        height: 20,
                        width: 100,
                        radius: 5,
                      ),
                      SizedBox(height: 10),
                      ShimmerSkelton(
                        height: 20,
                        width: 64,
                        radius: 5,
                      ),
                    ],
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerSkelton(
                        height: 64,
                        width: 64,
                        radius: 100,
                      ),
                      SizedBox(height: 10),
                      ShimmerSkelton(
                        height: 20,
                        width: 100,
                        radius: 5,
                      ),
                      SizedBox(height: 10),
                      ShimmerSkelton(
                        height: 20,
                        width: 64,
                        radius: 5,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const ShimmerSkelton(
                height: 20,
                width: 90,
                radius: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
