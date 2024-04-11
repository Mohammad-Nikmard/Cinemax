import 'package:cinemax/bloc/wishlist/wishlist_bloc.dart';
import 'package:cinemax/bloc/wishlist/wishlist_event.dart';
import 'package:cinemax/bloc/wishlist/wishlist_state.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/constants/string_constants.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/exception_message.dart';
import 'package:cinemax/widgets/loading_indicator.dart';
import 'package:cinemax/widgets/wishlist_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    BlocProvider.of<WishlistBloc>(context).add(WishlistFetchCartsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          if (state is WishlistLoadingState) {
            return const AppLoadingIndicator();
          } else if (state is WishlistResponseState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: CustomScrollView(
                    slivers: [
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 20,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.wishlist,
                              style: TextStyle(
                                fontFamily:
                                    StringConstants.setBoldPersianFont(),
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(height: 35),
                      ),
                      state.getCards.fold(
                        (exceptionMessage) {
                          return const SliverToBoxAdapter(
                            child: ExceptionMessage(),
                          );
                        },
                        (cartList) {
                          return SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: WishlistWidget(
                                    cart: cartList[index],
                                    index: index,
                                  ),
                                );
                              },
                              childCount: cartList.length,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is WishlistEmptyState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.wishlist,
                          style: TextStyle(
                            fontFamily: StringConstants.setBoldPersianFont(),
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 35),
                    const _EmptyWishlist(),
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

class _EmptyWishlist extends StatelessWidget {
  const _EmptyWishlist();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQueryHandler.screenHeight(context) - 180,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/box_image.svg',
          ),
          const SizedBox(height: 15),
          Text(
            AppLocalizations.of(context)!.noMovie,
            style: TextStyle(
              fontFamily: StringConstants.setBoldPersianFont(),
              fontSize: 16,
              color: Theme.of(context).colorScheme.tertiary,
            ),
            textDirection: StringConstants.setBoldPersianFont() == "SM"
                ? TextDirection.rtl
                : TextDirection.ltr,
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: 190,
            child: Text(
              AppLocalizations.of(context)!.noMovieCap,
              style: TextStyle(
                fontFamily: StringConstants.setMediumPersionFont(),
                fontSize: 12,
                color: TextColors.greyText,
              ),
              textAlign: TextAlign.center,
              textDirection: StringConstants.setBoldPersianFont() == "SM"
                  ? TextDirection.rtl
                  : TextDirection.ltr,
            ),
          ),
        ],
      ),
    );
  }
}
