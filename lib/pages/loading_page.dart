import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/usuario_pages.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/services/sokect_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return Center(
            child: Text('Espere...'),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthServices>(context, listen: false);
    final sokectServices = Provider.of<SocketService>(context, listen: false);
    final autenticado = await authService.isLoggedIn();
    print('auternticando $autenticado');
    if (autenticado) {
      //todo: comectar al sokect
      sokectServices.connect();
      //Navigator.pushReplacementNamed(context, 'usuarios');
      //* Por la transicion cambiamos la forma de como mandamos a llamar la ruta
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (_, __, ___) => UsuariosPage(),
            transitionDuration: Duration(milliseconds: 0)),
      );
    } else {
      //Navigator.pushReplacementNamed(context, 'login');
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (_, __, ___) => LoginPage(),
            transitionDuration: Duration(milliseconds: 0)),
      );
    }
  }
}
