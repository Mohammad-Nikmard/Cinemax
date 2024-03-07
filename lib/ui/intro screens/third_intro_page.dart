import 'package:flutter/material.dart';

class ThirdIntroPage extends StatelessWidget {
  const ThirdIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset("assets/images/intro3.png"),
        ],
      ),
    );
  }
}
