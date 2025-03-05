import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class ControlerAudioService extends ChangeNotifier {
  // Criando o player
  final player = AudioPlayer();

  
  Future<void> reproduzirPlaylist({
    required ConcatenatingAudioSource concatenatigAudioSource,
    int initialIndex = 0,
    Duration position = const Duration(minutes: 0)
  }) async {

    try {
      // Definindo o caminho do audio
      await player.setAudioSource(
        concatenatigAudioSource,
        initialPosition: position,
        initialIndex: initialIndex
      );
      
      // Aguardando o carregamento do audio
      await player.load(); 

      // Iniciando o audio
      await player.play();    
    }catch(e){
      debugPrint('Ocorreu um erro ao produzir audio: $e');
    }
    
    
    // Enviando a notificação
    notifyListeners();
  }
  
  Future<void> pararAudio() async {
    // Para a musica por completo
    // Caso você volte a reproduzir o audio irá voltar do inicio
    await player.stop();
    
    // Enviando a notificação
    notifyListeners();
  }

  Future<void> pausarAudio() async {

    // Pausa a musica
    // Mantem onde o usuario parou no audio.
    await player.pause();

    // Enviando a notificação
    notifyListeners();
  }

  Future<void> tocarAudio() async {
    // Tocar musica
    // Volta a musica da onde parou o audio
    await player.play();

    // Enviando a notificação
    notifyListeners();
  }

  Future<void> liberarRecursos() async {
    // Liberar recursos
    // Finaliza o player por completo
    await player.dispose();
  }
  
}