
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class StorageService {
  // Obter o caminho para a pasta de amarzenamento do dispostivo
  Future<Directory?> storageDirectory() async => await getExternalStorageDirectory();

  Future<void> readSounds() async {  
    // Obter o caminho do amarzenmaneto interno do dispostivo
    Directory? localStorage = await storageDirectory();

    // Verificando se o caminho foi obitido com sucesso
    if (localStorage == null) {
      throw Exception('Não foi possivel localizar o diretorio do amarzenmento do dispostivo');
    }

  }
}
