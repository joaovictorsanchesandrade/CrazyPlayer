import 'package:crazyplayer/src/data/services/controler_audio_service/controler_audio_service.dart';
import 'package:flutter/material.dart';
import 'package:crazyplayer/src/components/barra_de_ferramentas.dart';
import 'package:crazyplayer/src/components/lista_musicas_padrao.dart';
import 'package:crazyplayer/utils/extensions/context.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late MediaQueryData dataHomeView;
  late ControlerAudioService controlerAudioService;

  @override
  void initState() {
    super.initState();

    // Criando o controle de audio
    controlerAudioService = ControlerAudioService();
  }

  @override
  void dispose() {
    // Liberando recursos do controle de audios
    controlerAudioService.liberarRecursos();

    // Liberando recursos do home
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Obter a media query da data 
    dataHomeView = context.getMediaQueryData();

    return Scaffold(
        body: Container(
          width: dataHomeView.size.width,
          height: dataHomeView.size.height,
          color: Colors.black,
            child:Column(
              children: [
                SizedBox(
                  height: dataHomeView.size.height*.05,
                ),
                BarraDeFerramentas(),
                ListaMusicasPadrao(controlerAudioService: controlerAudioService,)
              ],
            ),
        )
    );
  }

  
}
