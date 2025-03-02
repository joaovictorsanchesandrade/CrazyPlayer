import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvService {
    // Nome do arquivo de variaveis de ambiente
    static String filename = '.env';

    // Carregar variaveis de ambiente
    static Future<void> load() async => await dotenv.load( 
        fileName: filename       
    );

    // Carregar variaveis de ambiente
    static String get appName => dotenv.env['APP_NAME']!;

}
