import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String ruta;
  final String subtitle;
  final String title;

  const Labels(
      {super.key,
      required this.ruta,
      required this.subtitle,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Text(
          this.subtitle,
          //'No tienes cuenta?',
          style: TextStyle(
              color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300),
        ),
        SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, this.ruta);
          },
          child: Text(
            this.title,
            //'Crea una ahora!',
            style: TextStyle(
              color: Colors.blue[600],
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ]),
    );
  }
}
