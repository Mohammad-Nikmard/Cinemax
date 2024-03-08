import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/widgets/back_label.dart';
import 'package:cinemax/widgets/wishlist_widget.dart';
import 'package:flutter/material.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const BackLabel(),
                ),
                const Text(
                  "Wishlist",
                  style: TextStyle(
                    fontFamily: "MSB",
                    fontSize: 16,
                    color: TextColors.whiteText,
                  ),
                ),
                const SizedBox(
                  width: 32,
                ),
              ],
            ),
            const SizedBox(height: 35),
            const WishlistWidget(),
          ],
        ),
      ),
    );
  }
}

class _EmptyWishlist extends StatelessWidget {
  const _EmptyWishlist();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/images/box_image.png'),
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
    );
  }
}
