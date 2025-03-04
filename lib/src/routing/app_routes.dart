import 'package:flutter/material.dart';
import 'package:crazyplayer/src/ui/home/views/home_view.dart';
import 'package:crazyplayer/src/ui/loading/views/loading_view.dart';
import 'package:crazyplayer/utils/typedefs.dart';


class AppNamedRoutes {
  // Todas os nomes das rotas
  static const loading = '/loading';
  static const home = '/home';

}
class AppRoutes {

  // Rota inciail do aplicativo
  static const String initialRoute = AppNamedRoutes.loading;
  
  // Rotas do aplicativo
  static final Map<String, WidgetFunctionContext> rotas = {
    // Tela de carregamento
    AppNamedRoutes.loading: (context) => LoadingView(),
    AppNamedRoutes.home: (context) => HomeView()
  };
}
