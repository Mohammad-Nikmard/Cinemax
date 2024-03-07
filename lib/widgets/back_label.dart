import 'package:cinemax/constants/color_constants.dart';
import 'package:flutter/material.dart';

class BackLabel extends StatelessWidget {
  const BackLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 32,
      decoration: const BoxDecoration(
        color: PrimaryColors.softColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Image.asset('assets/images/icon_arrow_back.png'),
      ),
    );
  }
}
