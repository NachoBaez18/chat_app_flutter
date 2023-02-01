import 'package:chat_app/models/mensajes_response.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../global/enviroment.dart';
import '../models/usuarios.dart';

class ChatService with ChangeNotifier {
  late Usuario usuarioPara;

  Future getChat(String usuarioID) async {
    final token = await AuthServices.getToken();
    if (token != null) {
      final uri = Uri.parse('${Enviroment.apiUrl}/mensajes/$usuarioID');
      final resp = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'x-token': token,
        },
      );
      final mensajesResp = mensajesResponseFromMap(resp.body);
      return mensajesResp.mensaje;
    }
    return false;
  }
}
