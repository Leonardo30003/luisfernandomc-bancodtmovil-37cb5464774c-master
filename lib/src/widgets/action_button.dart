import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../utils/colores.dart';

class ActionButton {
  static Widget buttonIcon({required IconData icono, required String texto, required VoidCallback callback}) {
    return ElevatedButton.icon(
        icon: Icon(
          icono,
          size: 18,
          color: Colors.white,
        ),
        onPressed: () {
          callback();
        },
        style: TextButton.styleFrom(primary: Colors.white, backgroundColor: Colores.COLOR_PRIMARY),
        label: Text(texto));
  }
}

class Botones extends StatelessWidget {
  // TIPO 0 FLATB
  final int tipo;
  final String text;
  final Color colorText;
  final Color colorButton;
  final double border;
  final VoidCallback callback;

  const Botones(
      {Key? key,
      required this.tipo,
      required this.text,
      required this.colorText,
      required this.colorButton,
      required this.border,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Widget boton;
    final ButtonStyle buttonStyle = TextButton.styleFrom(
      elevation: 0.0,
      backgroundColor: colorButton,
      foregroundColor: colorText,
      minimumSize: const Size(88, 36),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
    );

    switch (tipo) {
      case 0:
        boton = ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0.0,
              primary: colorButton,
              onPrimary: colorText,
              minimumSize: const Size(double.infinity, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(border),
              )),
          onPressed: () {
            callback();
          },
          child:
              AutoSizeText(text, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, letterSpacing: 1)),
          // child: Text("data"),
        );
        break;
      case 1:
        boton = TextButton(
          style: buttonStyle,
          onPressed: () {
            callback();
          },
          child: AutoSizeText(text, style: const TextStyle(fontSize: 16)),
        );
        break;
      default:
        boton = TextButton(onPressed: () {}, child: Container());
    }
    return boton;
  }
}
