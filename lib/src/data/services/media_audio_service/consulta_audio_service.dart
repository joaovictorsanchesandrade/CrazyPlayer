

// Ler os audios do dispositivo do usuario


import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:on_audio_query_forked/on_audio_query.dart';
import 'package:path_provider/path_provider.dart';

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

  Future<Uri?> obterUriArteAudio({required int idAudio}) async {
    try {
      // Obter o diretorio temporario do dispositivo
      final Directory diretorioTemporario = await getTemporaryDirectory();
        
      // Obter o diretorio temporario de capas de audios
      final Directory diretorioCapasAudiosTemporario = Directory('${diretorioTemporario.path}/capas_temporarias');
      
      // Verificando se o diretorio já existe 
      if (!await diretorioCapasAudiosTemporario.exists()) await diretorioCapasAudiosTemporario.create();

      // Define o caminha da capa temporaria
      final String caminhoImagem = '${diretorioCapasAudiosTemporario.path}/capa_temporaria_$idAudio.png';

      // Criando o arquivo da imagem
      final File arquivoImagem = File(caminhoImagem);

      // Obtendo os bytes da imagem
      Uint8List? bytes = await obterArteAudio(idAudio: idAudio);
      
      if (bytes != null){
        debugPrint('Escrevendo bytes na imagem');
        // Escreve os bytes no arquivo
        await arquivoImagem.writeAsBytes(bytes);
        
        // Retornando o uri da imagem
        return arquivoImagem.uri;
      }
      return null;
    }catch(e){
      debugPrint('Ocorreu um erro ao criar uma capa temporaria: $e');
      return null;
    }
  }

  

}