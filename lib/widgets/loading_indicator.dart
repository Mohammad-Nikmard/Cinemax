import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 120,
        width: 120,
        child: LoadingIndicator(
          indicatorType: Indicator.pacman,
          colors: [Theme.of(context).colorScheme.primary],
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
