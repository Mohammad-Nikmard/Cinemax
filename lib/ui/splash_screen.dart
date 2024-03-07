import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const SafeArea(
        child: Center(
          child: Image(
            image: AssetImage(
              "assets/images/splash_logo.png",
            ),
          ),
        ),
      ),
    );
  }
}
