import 'package:cinemax/DI/service_locator.dart';
import 'package:cinemax/data/model/wishlist_cart.dart';
import 'package:cinemax/theme/main_theme.dart';
import 'package:cinemax/ui/dashobard_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(WishlistCartAdapter());
  await Hive.openBox<WishlistCart>("MovieBox");

  await initServiceLoactor();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: mainTheme,
      home: const DashboardScreen(),
    );
  }
}
