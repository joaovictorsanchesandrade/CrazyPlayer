import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:crazyplayer/src/app/app_theme.dart';
import 'package:crazyplayer/src/data/services/env_service/env_service.dart';
import 'package:crazyplayer/src/routing/app_routes.dart';

class CrazyBeatApp extends StatelessWidget {
  const CrazyBeatApp({super.key});

  @override
  Widget build(BuildContext context) {    
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light
    ));

    // Widget principal do aplicativo
    return MaterialApp(
      // Titulo do aplicatvo
      title: EnvService.appName,

      // Rota inicial do aplicativo
      initialRoute: AppRoutes.initialRoute,

      // Outras rotas do aplicativo
      routes: AppRoutes.rotas,

      // Tema do aplicativo
      theme:  AppTheme.defaultTheme,
    );
  }
}