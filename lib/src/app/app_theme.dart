import 'package:flutter/material.dart';

// Todos os temas de cores do aplicativos estão aqui

class AppTheme {
  // Tema default do aplicativo
  static get defaultTheme => primaryTheme;

  // Temas de cores do aplicativo
  static ThemeData primaryTheme = ThemeData(
    // Esquema de cores
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.green
    ),
  );
}
