import 'package:crazyplayer/src/components/musica_item_padrao.dart';
import 'package:crazyplayer/src/data/services/controler_audio_service/controler_audio_service.dart';
import 'package:flutter/material.dart';
import 'package:crazyplayer/src/data/services/media_audio_service/consulta_audio_service.dart';
import 'package:crazyplayer/utils/extensions/context.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query_forked/on_audio_query.dart';

class ListaMusicasPadrao extends StatefulWidget {
  final ControlerAudioService controlerAudioService;
  const ListaMusicasPadrao({required this.controlerAudioService, super.key});

  @override
  State<ListaMusicasPadrao> createState() => _ListaMusicasPadraoState(controlerAudioService: controlerAudioService);
}

class _ListaMusicasPadraoState extends State<ListaMusicasPadrao> {
  // Consulta detalhes dos audios amarzenado no dispositivo do usuario
  ConsultaAudioService consultaAudido = ConsultaAudioService();

  // Controlar os audios que estão sendo reproduzidos
  final ControlerAudioService controlerAudioService;
  
  _ListaMusicasPadraoState({required this.controlerAudioService});

  @override
  Widget build(BuildContext context) {
    MediaQueryData data = context.getMediaQueryData();

    return Expanded(
      child: FutureBuilder(
        future: consultaAudido.obterAudios(), 
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child:CircularProgressIndicator()
            );
          }

          if (snapshot.data == null){
            return Center(
              child:Text('Ocorreu um erro ao carregar as musicas')
            );
          }
          
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index){
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  SizedBox(
                    width: data.size.width*.95,
                    child: MusicaItemPadrao(
                      songModel: snapshot.data![index],
                      controlerAudioService: controlerAudioService,
                      onPlay: (){
                        debugPrint('Index: $index');
                        controlerAudioService.reproduzirPlaylist(
                          initialIndex: index,
                          concatenatigAudioSource: ConcatenatingAudioSource(
                            children: snapshot.data!.map((songModel) => AudioSource.uri(
                              Uri.parse(songModel.uri!),
                              tag: MediaItem(
                                id: '${songModel.id}', 
                                title: songModel.title,
                                artist: songModel.artist,
                              )
                            )).toList(),
                          )
                        );
                      },
                    )
                  )
                ]
              );
            },
          );
        }
      )
    );
  }

  
}

