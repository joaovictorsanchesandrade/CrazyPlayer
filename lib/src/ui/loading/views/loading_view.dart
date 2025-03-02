import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sanches_player/src/app/app_colors.dart';
import 'package:sanches_player/src/data/services/permission_service/permission_service.dart';
import 'package:sanches_player/utils/extensions/context.dart';

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
      
      if (!status){
        // Fechando o aplicativo
        context.closeView();
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
          child: Image.asset(
            'assets/imagens/logo.png',
            width: data.size.width*.7,
          ),
        ),
      ),
    );
  }
}