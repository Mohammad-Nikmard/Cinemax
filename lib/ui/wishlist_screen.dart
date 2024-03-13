import 'package:cinemax/bloc/wishlist/wishlist_bloc.dart';
import 'package:cinemax/bloc/wishlist/wishlist_event.dart';
import 'package:cinemax/bloc/wishlist/wishlist_state.dart';
import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/loading_indicator.dart';
import 'package:cinemax/widgets/wishlist_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

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
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 30,
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Wishlist",
                          style: TextStyle(
                            fontFamily: "MSB",
                            fontSize: 16,
                            color: TextColors.whiteText,
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
                      return Text("exceptionMessage");
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
            );
          } else if (state is WishlistEmptyState) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Wishlist",
                        style: TextStyle(
                          fontFamily: "MSB",
                          fontSize: 16,
                          color: TextColors.whiteText,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 35),
                  _EmptyWishlist(),
                ],
              ),
            );
          }
          return Text("There seem to be errors Getting data");
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
      height: MediaQueryHandler.screenHeight(context) - 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/box_image.svg',
          ),
          const SizedBox(height: 15),
          const Text(
            "There is No Movie Yet!",
            style: TextStyle(
              fontFamily: "MSB",
              fontSize: 16,
              color: TextColors.whiteText,
            ),
          ),
          const SizedBox(height: 5),
          const SizedBox(
            width: 190,
            child: Text(
              "Find your movie by Type title, categories, years, etc.",
              style: TextStyle(
                fontFamily: "MM",
                fontSize: 12,
                color: TextColors.greyText,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
