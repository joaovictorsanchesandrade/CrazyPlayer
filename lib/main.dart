import 'package:flutter/material.dart';
import 'package:sanches_player/src/app/app_widget.dart';
import 'package:sanches_player/src/data/services/env_service/env_service.dart';

Future<void> main() async {
  // Carregando variaveis de ambiente
  await EnvService.load();

  // Iniciando o aplicativo
  runApp(const CrazyBeatApp());
}

