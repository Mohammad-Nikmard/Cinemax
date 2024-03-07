import 'package:flutter/material.dart';

class FirstIntroPage extends StatelessWidget {
  const FirstIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/intro1.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
