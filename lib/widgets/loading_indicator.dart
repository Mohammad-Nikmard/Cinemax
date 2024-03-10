import 'package:cinemax/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 120,
        width: 120,
        child: LoadingIndicator(
          indicatorType: Indicator.pacman,
          colors: [PrimaryColors.blueAccentColor],
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
