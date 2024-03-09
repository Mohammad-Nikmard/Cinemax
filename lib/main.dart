import 'package:cinemax/theme/main_theme.dart';
import 'package:cinemax/ui/upcoming_movie_detail.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: mainTheme,
      home: const UpcomingMovieDetail(),
    );
  }
}
