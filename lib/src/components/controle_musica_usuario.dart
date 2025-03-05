import 'dart:io';

import 'package:crazyplayer/src/data/services/controler_audio_service/controler_audio_service.dart';
import 'package:crazyplayer/utils/extensions/context.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class ControleMusicaUsuario extends StatefulWidget {
  final ControlerAudioService controlerAudioService;
  ControleMusicaUsuario({required this.controlerAudioService, super.key});

  @override
  State<ControleMusicaUsuario> createState() => _ControleMusicaUsuarioState(controlerAudioService: controlerAudioService);
}

class _ControleMusicaUsuarioState extends State<ControleMusicaUsuario> {
  final ControlerAudioService controlerAudioService;
  
  _ControleMusicaUsuarioState({required this.controlerAudioService});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controlerAudioService,
      builder: (context, _) {
        final MediaQueryData data = context.getMediaQueryData();
        
        // Se não tiver não retorna o controle
        if (controlerAudioService.player.sequenceState == null){
          return SizedBox();
        }

        // Obtendo a musica que está executando no momento
        final MediaItem mediaItem = controlerAudioService.player.sequenceState!.currentSource!.tag;

        return Container(
          color: Colors.white,
          width: data.size.width,
          height: data.size.height*.1,
          child: Row(
            children: [
              // Detalhes da musica
              SizedBox(
                width: data.size.width*.7,
                child: Row(
                  children:[
                    // Espaço da imagem da musica
                    Container(
                      width: data.size.width*.2,
                      height: data.size.height*.1,
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent
                      ),
                      
                    )
                  ]
                )
              ),

              // Botões de controle do audio
              IconButton(
                icon: Icon(
                  // Escolhendo qual é o icone que deve mostrar
                  (controlerAudioService.player.playing) ? Icons.stop:Icons.play_arrow,

                  // Estilo do icone
                  color: Colors.black,
                ),
                onPressed: () => (controlerAudioService.player.playing) ? controlerAudioService.pausarAudio():controlerAudioService.tocarAudio(),
                color: Colors.black,
              )
            ],
          ),
        );
      }
    );
  }
}
