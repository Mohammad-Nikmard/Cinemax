import 'package:cinemax/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WishlistWidget extends StatelessWidget {
  const WishlistWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
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
            Container(
              height: 83,
              width: (screenSize.width < 350) ? 100 : 121,
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
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
                    "Action",
                    style: TextStyle(
                      fontFamily: "MM",
                      fontSize: (screenSize.width < 380) ? 10 : 12,
                      color: TextColors.wihteGreyText,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Flexible(
                    child: Text(
                      "Spider-man Felan Bisar shode",
                      style: TextStyle(
                        fontFamily: "MM",
                        fontSize: (screenSize.width < 380) ? 12 : 14,
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
                            "Movie",
                            style: TextStyle(
                              fontFamily: "MM",
                              fontSize: (screenSize.width < 380) ? 10 : 12,
                              color: TextColors.greyText,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Image.asset(
                            'assets/images/icon_star.png',
                            color: SecondaryColors.orangeColor,
                            height: 16,
                            width: 16,
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            "4.5",
                            style: TextStyle(
                              fontFamily: "MM",
                              fontSize: 12,
                              color: SecondaryColors.orangeColor,
                            ),
                          ),
                        ],
                      ),
                      Image.asset(
                        'assets/images/icon_heart.png',
                        color: SecondaryColors.redColor,
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
