import 'package:cinemax/constants/color_constants.dart';
import 'package:flutter/material.dart';

class BackLabel extends StatelessWidget {
  const BackLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Center(
        child: Image.asset('assets/images/icon_arrow_back.png'),
      ),
    );
  }
}
