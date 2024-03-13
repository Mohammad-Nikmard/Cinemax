import 'package:cinemax/bloc/wishlist/wishlist_bloc.dart';
import 'package:cinemax/bloc/wishlist/wishlist_event.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/data/model/wishlist_cart.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

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
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              child: SizedBox(
                height: 83,
                width:
                    (MediaQueryHandler.screenWidth(context) < 350) ? 100 : 121,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: CachedImage(
                    imageUrl: cart.thumbnail,
                    radius: 10,
                  ),
                ),
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
                            color: SecondaryColors.orangeColor,
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
                          color: SecondaryColors.redColor,
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
