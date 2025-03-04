

// Ler os audios do dispositivo do usuario


import 'dart:typed_data';

import 'package:on_audio_query_forked/on_audio_query.dart';

class ConsultaAudioService {

  final OnAudioQuery _audioQuery = OnAudioQuery();

  Future<List<SongModel>> obterAudios() async {
    return await _audioQuery.querySongs(
      // Ordem crescente de A-z
      orderType: OrderType.ASC_OR_SMALLER,
      // Classificação titulo da musica
      sortType: SongSortType.TITLE,
    );
  }

  Future<Uint8List?> obterArteAudio({ required int idAudio}) async {
    // Obter o id de um audio
    return _audioQuery.queryArtwork(
      idAudio, // Id do audio
      ArtworkType.AUDIO // Tipo audio
    );
  }
}