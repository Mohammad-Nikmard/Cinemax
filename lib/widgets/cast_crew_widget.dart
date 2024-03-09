import 'package:cinemax/constants/color_constants.dart';
import 'package:flutter/material.dart';

class CastAndCrewWidget extends StatelessWidget {
  const CastAndCrewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        Text(
          "Cast and Crew",
          style: TextStyle(
            fontFamily: "MSB",
            fontSize: (screenSize.width < 350) ? 14 : 16,
            color: TextColors.whiteText,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      backgroundColor: PrimaryColors.blueAccentColor,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "John Watts",
                          style: TextStyle(
                            fontFamily: "MSB",
                            fontSize: (screenSize.width < 350) ? 12 : 14,
                            color: TextColors.whiteText,
                          ),
                        ),
                        Text(
                          "Actor",
                          style: TextStyle(
                            fontFamily: "MM",
                            fontSize: (screenSize.width < 350) ? 8 : 10,
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
