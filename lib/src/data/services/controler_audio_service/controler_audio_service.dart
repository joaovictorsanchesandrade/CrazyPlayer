import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class ControlerAudioService {

  // Criando o player
  final _player = AudioPlayer();
  
  Future<void> reproduzirAudio({
    required AudioSource audioSource
  }) async {
    // Definindo o caminho do audio
    await _player.setAudioSource(audioSource);
    
    // Aguarda o carregamento do audio
    await _player.load(); 
    
    // Iniciando o audio
    await _player.play();    
  }
  
  Future<void> pararAudio() async {
    // Para a musica por completo
    // Caso você volte a reproduzir o audio irá voltar do inicio
    await _player.stop();
  }

  Future<void> pausarAudio() async {
    // Pausa a musica
    // Mantem onde o usuario parou no audio.
    await _player.pause();
  }

  Future<void> liberarRecursos() async {
    // Liberar recursos
    // Finaliza o player por completo
    await _player.dispose();
  }
  
}