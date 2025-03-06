import 'dart:io';

import 'package:crazyplayer/src/app/app_colors.dart';
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
    return StreamBuilder<PlayerState>(
      stream: controlerAudioService.player.playerStateStream,
      builder: (context, snapshot) {
        final playingState = snapshot.data;
        final playing = playingState?.playing ?? false;

        final MediaQueryData data = context.getMediaQueryData();

        // Index da musica        
        final int? index = controlerAudioService.player.currentIndex;

        // Verificando se tem alguma musica tocando
        if (index == null || controlerAudioService.player.sequence == null){
          return SizedBox();
        }

        // Obtendo a musica que está executando no momento
        final MediaItem mediaItem = controlerAudioService.player.sequence![index].tag;

        return Container(
          decoration: BoxDecoration(
            color: AppColors.blackControlerLayout,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0)
            )
          ),
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
                    (mediaItem.artUri != null) ? Container(
                      width: data.size.width*.2,
                      height: data.size.height*.1,
                      margin: EdgeInsets.only(
                        left: data.size.width*.01,
                        right: data.size.width*.01,
                        top: data.size.height*.005,
                        bottom: data.size.height*.005
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0)
                      ), 
                      child: ClipRRect(
                        child:Image.file(
                          File(mediaItem.artUri!.toFilePath()),
                          fit: BoxFit.cover,
                        )
                      ),
                    ):SizedBox(),
                    Column(
                      children: [
                        Row(
                          children:[
                            Text(mediaItem.title)
                          ]
                        ),
                        Row(
                          children:[
                            Text(
                              mediaItem.artist ?? 'Desconhecido',
                              style: TextStyle(
                                color: Colors.grey
                              ),
                            )
                          ]
                        ),
                        StreamBuilder<Duration>(
                          stream: controlerAudioService.player.positionStream,
                          builder: (context, snapshot) {
                            final position = snapshot.data ?? Duration.zero;
                            final duration = controlerAudioService.player.duration ?? Duration.zero;

                            return Slider(
                              min: 0,
                              max: duration.inMilliseconds.toDouble(),
                              value: position.inMilliseconds.toDouble(),
                              onChanged: (value) {
                                controlerAudioService.player.seek(Duration(milliseconds: value.toInt()));
                              },
                            );
                          },
                        ),

                      ],
                    )
                  ]
                )
              ),

              // Botões de controle do audio
              IconButton(
                icon: Icon(
                  // Escolhendo qual é o icone que deve mostrar
                  (playing) ? Icons.stop:Icons.play_arrow,
                  // Estilo do icone
                  color: Colors.white,
                ),
                onPressed: () => (playing) ? controlerAudioService.pausarAudio():controlerAudioService.tocarAudio(),
                color: Colors.white,
              )
            ],
          ),
        );
      }
    );
  }
}
