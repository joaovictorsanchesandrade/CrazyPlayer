import 'dart:io';

import 'package:flutter/material.dart';
import 'package:crazyplayer/src/app/app_colors.dart';
import 'package:crazyplayer/src/data/services/permission_service/permission_service.dart';
import 'package:crazyplayer/utils/extensions/context.dart';
import 'package:flutter/services.dart';

class LoadingView extends StatefulWidget {
  const LoadingView({super.key});

  @override
  State<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  late MediaQueryData data;

  @override
  void initState() {
    super.initState();

    // Executar função depois que o layout carregar completamente
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Pedindo permissão do amarzenamento
      bool status = await PermissionService.requestStorage();
      
      debugPrint('Storage permission: $status');
      if (!status){
        // Fechando o aplicativo
        SystemNavigator.pop(); // Fechar o aplicativo
        return;
      }
      
      // Acessando o home
      context.home(replace: true);
    });
  }

  void initVars(){ // Carregar variaveis necessarias
    // Carregando funções necessarias
    data = context.getMediaQueryData();
  }
  
  @override
  Widget build(BuildContext context) {
    initVars();

    return Scaffold(
      body: Container(
        width: data.size.width,
        height: data.size.height,
        decoration: BoxDecoration(
          color: Colors.black
        ),
        child: Center(
          child: ImagemAplicativoLoading()
          )
        )
    );
  }
}

class ImagemAplicativoLoading extends StatelessWidget {
  const ImagemAplicativoLoading({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryData data = context.getMediaQueryData();

    return Container(
      width: data.size.width*.5,
      height: data.size.width*.5,
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(40.0)
      ),
      child:Image.asset(
        'assets/imagens/logo.png',
        fit: BoxFit.fill, // Preencher todo o espaço possivel
      )
    );
  }
}

