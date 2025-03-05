
import 'dart:typed_data';

import 'package:crazyplayer/src/data/services/controler_audio_service/controler_audio_service.dart';
import 'package:crazyplayer/src/data/services/media_audio_service/consulta_audio_service.dart';
import 'package:crazyplayer/utils/extensions/context.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query_forked/on_audio_query.dart';

class MusicaItemPadrao extends StatefulWidget {
  final SongModel songModel;
  final ControlerAudioService controlerAudioService;
  final VoidCallback onPlay;
  const MusicaItemPadrao({ required this.songModel, required this.controlerAudioService, required this.onPlay, super.key});

  @override
  State<MusicaItemPadrao> createState() => _MusicaItemPadraoState(songModel: songModel, onPlay: onPlay);
}

class _MusicaItemPadraoState extends State<MusicaItemPadrao> {
  final SongModel songModel;
  final ConsultaAudioService consultaAudio = ConsultaAudioService();
  final VoidCallback onPlay;
  late MediaQueryData data;

  _MusicaItemPadraoState({required this.songModel, required this.onPlay});

  @override
  Widget build(BuildContext context) {
    data = context.getMediaQueryData();
    
    return GestureDetector(
      onTap: () async {
        if (songModel.uri != null) {
          final Uri? caminhoCapaAudio = await consultaAudio.obterUriArteAudio(idAudio: songModel.id);
          debugPrint('Uri do audio: ${caminhoCapaAudio}');

          // Reproduzindo o audio
          // controlerAudioService.reproduzirAudio(audioSource: AudioSource.uri(
          //   Uri.parse(songModel.uri!),
          //   tag: MediaItem(
          //     id: '${songModel.id}', 
          //     title: songModel.title,
          //     artUri: caminhoCapaAudio,
          //     artist: songModel.artist,

          //   )
          // ));
          // Chamando o play da musica
          onPlay();

        }
      },
      child:Container(
        width: data.size.width,
        height: data.size.height*.1,
        decoration: BoxDecoration(
          color: Colors.transparent
        ),
        child: Row(
          // Alinhar os elementos a direita na horizontal (eixo x)
          mainAxisAlignment: MainAxisAlignment.start,
          // Alinhar os elementos no centro no eixo y
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: data.size.width*.16,
              height: data.size.height*.08,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child:obterCapaAudio()
              )
            ),
            // Espaço entre a capa e a legenda
            SizedBox(
              width: data.size.width*.05,
            ),
            Column(
              // Alinhar os elementos no centro no eixo y
              mainAxisAlignment: MainAxisAlignment.center,
              // Alinhar os elementos a direita na horizontal (eixo x)
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                criarLegendaAudio(),
                criarNomeDoArtista()
              ],
            )
          ],
        ),
      )
    );
  }

  Widget obterCapaAudio(){
    return FutureBuilder(
      future: consultaAudio.obterArteAudio(idAudio: songModel.id), 
      builder: (context, snapshot){
        // Verificando se tem imagem ou ainda está obtendo a imagem
        if (snapshot.connectionState == ConnectionState.waiting || snapshot.data == null){
          return SizedBox();
        }

        
        // Retornando a imagem da musica
        return Image.memory(
          snapshot.data!,
          fit: BoxFit.cover,
        );
      }
    );
  }

  Widget criarLegendaAudio(){
    return SizedBox(
      width: data.size.width*.5,
      child:Text(
        // Remover espaços do inicio e o final da string
        songModel.title.trim(),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis,
          fontSize: data.size.width*.04
        ),
      )
    );
  }

  Widget criarNomeDoArtista(){
    return SizedBox(
      width: data.size.width*.5,
      child: Text(
        // Remover espaços do inicio e o final da string
        (songModel.artist ?? 'Desconhecido').trim(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: data.size.width*.025,
          color: Colors.grey,
          overflow: TextOverflow.ellipsis
        ),
      ),
    );
  }
}