import 'package:flutter/material.dart';
import 'package:sanches_player/utils/extensions/context.dart';
import 'package:sanches_player/utils/typedefs.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late MediaQueryData dataHomeView;

  @override
  Widget build(BuildContext context) {
    // Obter a media query da data 
    dataHomeView = context.getMediaQueryData();

    return Scaffold(
        body: Container(
          width: dataHomeView.size.width,
          height: dataHomeView.size.height,
          color: Colors.black87,
            child:Column(
              children: [
                SizedBox(
                  height: dataHomeView.size.height*.05,
                ),
                BarraDeFerramentas()
              ],
            ),
        )
    );
  }

  
}

class BarraDeFerramentas extends StatefulWidget {
  const BarraDeFerramentas({super.key});

  @override
  State<BarraDeFerramentas> createState() => _BarraDeFerramentasState();
}

class _BarraDeFerramentasState extends State<BarraDeFerramentas> {
  // Informações sobre o contexto
  late MediaQueryData data;

  // Informações sobre o estado atual da barra de ferramentas
  BarraDeFerramentasOpcoes ferramentaSelecionada = BarraDeFerramentasOpcoes.ALBUM;

  @override
  Widget build(BuildContext context) {
    data = context.getMediaQueryData();
    
    return Column(
      children:[
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child:Container(            
            child:Row(              
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Criando os campos da barra de ferramenta
                criarCampo(
                  nomeBotao: 'Playlist',
                  opcaoSelecionada: BarraDeFerramentasOpcoes.PLAYLIST,
                ),
                criarCampo(
                  nomeBotao: 'Album',
                  opcaoSelecionada: BarraDeFerramentasOpcoes.ALBUM,
                ),
                criarCampo(
                  nomeBotao: 'Musicas',
                  opcaoSelecionada: BarraDeFerramentasOpcoes.MUSICAS,
                ),
                criarCampo(
                  nomeBotao: 'Curtidas',
                  opcaoSelecionada: BarraDeFerramentasOpcoes.CURTIDAS,
                ),
              ],
            )
          )
        ),
        Divider()
      ]
    );
  }

  Widget criarCampo({
    required String nomeBotao,
    required BarraDeFerramentasOpcoes opcaoSelecionada,
    ActionButtonBarTools? onPressed = null,
  }){
    // Verificando se o campo foi selecionado
    final bool selecionado = opcaoSelecionada == ferramentaSelecionada;

    // Criando o widget do campo   
    return GestureDetector(
      onTap:(onPressed == null) ? (){
        setState(() {
          ferramentaSelecionada = opcaoSelecionada;
        });
      }:onPressed,
      child:Container(
        margin: EdgeInsets.only(
          left: data.size.width*.08
        ),
        decoration: BoxDecoration(
          border: (selecionado) ? Border(
            bottom: BorderSide(
              color: Colors.white,
              width: 2.0
            )
          ):null
        ),
        child: Text(
          nomeBotao,
          style: TextStyle(
            color: (selecionado) ? Colors.white:Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: data.size.width*.035
          ),
        ),        
      )
    );
  }
}

enum BarraDeFerramentasOpcoes {
  PLAYLIST,
  ALBUM,
  MUSICAS,
  CURTIDAS
}