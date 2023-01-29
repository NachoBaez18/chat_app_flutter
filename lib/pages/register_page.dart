import 'package:chat_app/helpers/mostrar_alertta.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Logo(
                    titulo: 'Registro',
                  ),
                  _Form(),
                  Labels(
                    ruta: 'login',
                    subtitle: 'Ya tienes una cuenta?',
                    title: 'Ingresa con la misma!',
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Terminos y condiciones de uso',
                      style: TextStyle(fontWeight: FontWeight.w200),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  const _Form({super.key});

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthServices>(context);
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.perm_identity_outlined,
            placeholder: 'Nombre',
            textController: nameCtrl,
          ),
          CustomInput(
            icon: Icons.email_outlined,
            placeholder: 'Correo',
            keyboardype: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            textController: passwordCtrl,
            isPassword: true,
          ),
          //todo: Crear boton
          BotonAzul(
            text: 'Crear cuenta',
            onPressed: authServices.autenticando
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final registroOk = await authServices.register(
                        nameCtrl.text.trim(),
                        emailCtrl.text.trim(),
                        passwordCtrl.text.trim());

                    if (registroOk == true) {
                      Navigator.pushReplacementNamed(context, 'usuarios');
                    } else {
                      mostrarAlerta(context, 'Registro incorrecto', registroOk);
                    }
                  },
          )
        ],
      ),
    );
  }
}
