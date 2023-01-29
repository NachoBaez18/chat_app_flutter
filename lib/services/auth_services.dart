import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:chat_app/global/enviroment.dart';
import 'package:chat_app/models/loginResponse.dart';
import 'package:chat_app/models/usuarios.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthServices with ChangeNotifier {
  late Usuario usuario;
  bool _autenticando = false;

  // Create storage
  final _storage = new FlutterSecureStorage();

  bool get autenticando => this._autenticando;
  set autenticando(bool value) {
    this._autenticando = value;
    notifyListeners();
  }

  static Future<String?> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    this.autenticando = true;
    final data = {
      'email': email,
      'password': password,
    };

    final uri = Uri.parse('${Enviroment.apiUrl}/login');
    final resp = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    autenticando = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromMap(resp.body);
      this.usuario = loginResponse.usuario;

      await this._guardarToken(loginResponse.token);

      return true;
    } else {
      return false;
    }
  }

  Future register(String nombre, String email, String password) async {
    this.autenticando = true;
    final data = {
      'nombre': nombre,
      'email': email,
      'password': password,
    };

    final uri = Uri.parse('${Enviroment.apiUrl}/login/new');
    final resp = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    autenticando = false;
    print(resp.body);
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromMap(resp.body);
      this.usuario = loginResponse.usuario;

      await this._guardarToken(loginResponse.token);

      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await this._storage.read(key: 'token');

    if (token != null) {
      try {
        final uri = Uri.parse('${Enviroment.apiUrl}/login/renew');
        final resp = await http.get(
          uri,
          headers: {
            'Content-Type': 'application/json',
            'x-token': token,
          },
        );
        final data = resp.body;

        if (resp.statusCode == 200) {
          final loginResponse = loginResponseFromMap(resp.body);
          this.usuario = loginResponse.usuario;

          await this._guardarToken(loginResponse.token);
          this.autenticando = false;

          return true;
        } else {
          this.autenticando = false;
          this.logout();
          return false;
        }
      } catch (e) {
        return false;
      }
    }
    return false;
  }

  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    return await _storage.delete(key: 'token');
  }
}
