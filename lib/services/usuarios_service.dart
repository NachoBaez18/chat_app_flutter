import 'package:chat_app/models/usuarios_response.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app/models/usuarios.dart';

import '../global/enviroment.dart';

class UsauriosServices {
  Future<List<Usuario>?> getUsuarios() async {
    try {
      final token = await AuthServices.getToken();

      if (token != null) {
        final uri = Uri.parse('${Enviroment.apiUrl}/usuarios');
        final resp = await http.get(
          uri,
          headers: {
            'Content-Type': 'application/json',
            'x-token': token,
          },
        );
        final usuariosResponse = usuariosResponseFromMap(resp.body);

        return usuariosResponse.usuarios;
      }
    } catch (e) {
      return [];
    }
  }
}
