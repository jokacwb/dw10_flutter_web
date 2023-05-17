import 'package:flutter/material.dart';

import '../styles/colors_app.dart';
import '../styles/styles_app.dart';

class ThemeConfig {
  //Para evitar que seja instanciada
  ThemeConfig._();

  static final theme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorsApp.instance.primary,
      primary: ColorsApp.instance.primary,
      secondary: ColorsApp.instance.secondary,
    ),
    elevatedButtonTheme:
        ElevatedButtonThemeData(style: StylesApp.instance.primaryButton),
  );
}
