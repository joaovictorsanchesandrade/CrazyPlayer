// Todas as extensões para o BuildContext se encotram aqui
import 'package:flutter/material.dart';
import 'package:sanches_player/src/routing/app_routes.dart';

extension MediaQueryGet on BuildContext {
  // Obter o media query data
  MediaQueryData getMediaQueryData() => MediaQuery.of(this);
}

extension NavigatorFunctions on BuildContext {
  // Obter o navigator
  NavigatorState getNavigator() => Navigator.of(this);

  // Acessar uma view
  void pushView({
    required String namedRoute,
    required bool replace
  }) => (replace) 
    ? getNavigator().pushReplacementNamed(namedRoute) :
      getNavigator().pushNamed(namedRoute);
  

  // Fechar view
  void closeView() => getNavigator().pop();

  // Acessar o loading
  void loading({bool replace = false}) => pushView(namedRoute: AppNamedRoutes.loading, replace: replace);
  
  // Acessar o home
  void home({bool replace = false}) => pushView(namedRoute: AppNamedRoutes.home, replace: replace);
   
  
}