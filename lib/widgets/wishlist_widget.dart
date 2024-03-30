import 'dart:ui';
import 'package:cinemax/bloc/video/video_bloc.dart';
import 'package:cinemax/bloc/video/video_event.dart';
import 'package:cinemax/bloc/wishlist/wishlist_bloc.dart';
import 'package:cinemax/bloc/wishlist/wishlist_event.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/data/model/wishlist_cart.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/cached_image.dart';
import 'package:cinemax/widgets/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../DI/service_locator.dart';

class WishlistWidget extends StatelessWidget {
  const WishlistWidget({super.key, required this.cart, required this.index});
  final WishlistCart cart;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 107,
      decoration: const BoxDecoration(
        color: PrimaryColors.softColor,
        borderRadius: BorderRadius.all(
          Radius.circular(17),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
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
                            ..add(FetchTrailerEvent(cart.movieId)),
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
                          Radius.circular(10),
                        ),
                        child: SizedBox(
                          height: 83,
                          width: (MediaQueryHandler.screenWidth(context) < 350)
                              ? 100
                              : 121,
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: CachedImage(
                              imageUrl: cart.thumbnail,
                              radius: 10,
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        child: SizedBox(
                          height: 83,
                          width: (MediaQueryHandler.screenWidth(context) < 350)
                              ? 100
                              : 121,
                          child: ColoredBox(
                            color: PrimaryColors.darkColor.withOpacity(0.3),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SvgPicture.asset('assets/images/icon_play_wishlist.svg'),
                ],
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    cart.genre,
                    style: TextStyle(
                      fontFamily: "MM",
                      fontSize: (MediaQueryHandler.screenWidth(context) < 380)
                          ? 10
                          : 12,
                      color: TextColors.wihteGreyText,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Flexible(
                    child: Text(
                      cart.name,
                      style: TextStyle(
                        fontFamily: "MM",
                        fontSize: (MediaQueryHandler.screenWidth(context) < 380)
                            ? 12
                            : 14,
                        color: TextColors.whiteText,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            cart.category,
                            style: TextStyle(
                              fontFamily: "MM",
                              fontSize:
                                  (MediaQueryHandler.screenWidth(context) < 380)
                                      ? 10
                                      : 12,
                              color: TextColors.greyText,
                            ),
                          ),
                          const SizedBox(width: 10),
                          SvgPicture.asset(
                            'assets/images/icon_star.svg',
                            colorFilter: const ColorFilter.mode(
                              SecondaryColors.orangeColor,
                              BlendMode.srcIn,
                            ),
                            height: 16,
                            width: 16,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            cart.rate,
                            style: const TextStyle(
                              fontFamily: "MM",
                              fontSize: 12,
                              color: SecondaryColors.orangeColor,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          context
                              .read<WishlistBloc>()
                              .add(WishlistCardDelete(index));
                        },
                        child: SvgPicture.asset(
                          'assets/images/icon_heart.svg',
                          colorFilter: const ColorFilter.mode(
                            SecondaryColors.redColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
