import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  final String text;
  final Function()? onPressed;

  const BotonAzul({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      elevation: 2,
      highlightElevation: 5,
      color: Colors.blue,
      shape: StadiumBorder(),
      child: Container(
        width: double.infinity,
        height: 55,
        child: Center(
            child: Text(
          this.text,
          style: TextStyle(color: Colors.white, fontSize: 17),
        )),
      ),
    );
  }
}
