import 'package:flutter/material.dart';
import 'package:crazyplayer/src/app/app_widget.dart';
import 'package:crazyplayer/src/data/services/env_service/env_service.dart';
import 'package:just_audio_background/just_audio_background.dart';

Future<void> main() async {
  // Permiti reproduzir musica em segundo
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );


  // Carregando variaveis de ambiente
  await EnvService.load();

  // Iniciando o aplicativo
  runApp(const CrazyBeatApp());
}

