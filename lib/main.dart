import 'package:cinemax/DI/service_locator.dart';
import 'package:cinemax/bloc/language/language_bloc.dart';
import 'package:cinemax/bloc/language/language_event.dart';
import 'package:cinemax/bloc/language/language_state.dart';
import 'package:cinemax/bloc/splash/splash_bloc.dart';
import 'package:cinemax/bloc/splash/splash_event.dart';
import 'package:cinemax/data/model/wishlist_cart.dart';
import 'package:cinemax/theme/main_theme.dart';
import 'package:cinemax/ui/intro%20screens/intro_dashboard.dart';
import 'package:cinemax/ui/splash_screen.dart';
import 'package:cinemax/util/app_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(WishlistCartAdapter());
  await Hive.openBox<WishlistCart>("MovieBox");

  await initServiceLoactor();

  runApp(
    BlocProvider(
      create: (context) => LanguageBloc()..add(GetLanguage()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        return MaterialApp(
          locale: state.selectedLanguage.value,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          debugShowCheckedModeBanner: false,
          theme: mainTheme,
          home: (AppManager.isFistTime())
              ? const IntroDashboard()
              : BlocProvider(
                  create: (context) =>
                      SplashBloc()..add(CheckConnectionEvent()),
                  child: const SplashScreen(),
                ),
        );
      },
    );
  }
}
