import 'dart:ui';

enum Language {
  english(
    Locale('en', 'US'),
    'English',
  ),
  persian(
    Locale('fa', 'IR'),
    'Persian',
  ),
  french(
    Locale('fr', 'FR'),
    'French',
  ),
  spanish(
    Locale('es', 'ES'),
    'Spanish',
  ),
  chineese(
    Locale('zh', 'CN'),
    'Chinese ',
  ),
  hindi(
    Locale('hi', 'IN'),
    'Hindi',
  );

  const Language(
    this.value,
    this.text,
  );

  final Locale value;
  final String text;
}
