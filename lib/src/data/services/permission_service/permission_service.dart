import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<bool> requestStorage() async {
    // Pedindo permissão para acessar o amarzenamento
    PermissionStatus status = await Permission.storage.request();
    return status.isGranted;
  }
}
