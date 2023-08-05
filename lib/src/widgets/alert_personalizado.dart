import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bancodetiempo/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/miembro_model.dart';
import '../utils/colores.dart';
import '../utils/variables_globales.dart';
import 'widgets_personalizados.dart';

class AlertPersonalizado {
  static alertOferta(
      {required BuildContext context,
      required Size screenSize,
      required bool editar,
      required var oferta,
      required VoidCallback callback}) {
    Alert(
      style: const AlertStyle(isCloseButton: false, backgroundColor: Colores.COLOR_GRIS_BORDER),
      context: context,
      title: "",
      // desc: "Flutter is more awesome with RFlutter Alert.",
      alertAnimation: fadeAlertAnimation,
      content: Container(
        color: Colores.COLOR_GRIS_BORDER,
        width: screenSize.width * 0.50,
        height: screenSize.height * 0.30,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 5,
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                        width: 70.0,
                        height: 70.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image: oferta.imagen == ""
                                ? const AssetImage(Assets.imagesPlaceholder) as ImageProvider
                                : NetworkImage(GlobalVariables.URL_IMAGE + oferta.imagen),
                          ),
                        ),
                      ),
                    ),
                    WidgetsPersonalizados.getStars(oferta.calificacion.toDouble()),
                    AutoSizeText(
                      "${oferta.nombres} ${oferta.apellidos}",
                      maxLines: 3,
                      minFontSize: 12,
                      style: TextStyle(color: Colores.COLOR_GRIS_HINT, fontSize: 18.0),
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                    ),
                    AutoSizeText(
                      oferta.email == "" ? "correo@email.com" : "${oferta.email}",
                      maxLines: 1,
                      minFontSize: 12,
                      style: const TextStyle(color: Colores.COLOR_GRIS_HINT, fontSize: 16.0),
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                    ),
                    AutoSizeText(
                      "${oferta.telefono}",
                      maxLines: 1,
                      minFontSize: 12,
                      style: const TextStyle(color: Colores.COLOR_GRIS_HINT, fontSize: 16.0),
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.only(top: 10.0),
                // color: Colores.COLOR_GRIS_HINT,
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: AutoSizeText(
                          "${oferta.fechaCreacion}",
                          maxLines: 1,
                          minFontSize: 12,
                          style: const TextStyle(color: Colores.COLOR_GRADIENTE_2, fontSize: 16.0),
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          "${oferta.titulo}",
                          maxLines: 1,
                          minFontSize: 14,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: AutoSizeText(
                        "${oferta.descripcionActividad}",
                        style: const TextStyle(color: Colores.COLOR_GRADIENTE_2, fontSize: 15.0),
                        maxLines: 5,
                        minFontSize: 12,
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      buttons: [
        DialogButton(
          onPressed: () {
            callback();
            Navigator.pop(context);
          },
          width: 150,
          color: Colores.COLOR_VERDE_BOTON,
          child: const Text("Aceptar", style: TextStyle(color: Colors.white, fontSize: 20)),
        )
      ],
    ).show();
    debugPrint("Alert closed now.");
  }

  static alertMiembro({
    required BuildContext context,
    required Size screenSize,
    required MiembroModel miembro,
    required List<Widget> elementos,
  }) {
    Alert(
      style: const AlertStyle(isCloseButton: false, backgroundColor: Colores.COLOR_GRIS_BORDER),
      context: context,
      title: "",
      // desc: "Flutter is more awesome with RFlutter Alert.",
      alertAnimation: fadeAlertAnimation,
      content: Container(
        color: Colores.COLOR_GRIS_BORDER,
        width: screenSize.width * 0.3,
        height: screenSize.height * 0.3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 5,
              child: Container(
                width: 120.0,
                height: 120.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: miembro.imagen == ""
                        ? const AssetImage(Assets.imagesPlaceholder) as ImageProvider
                        : NetworkImage(GlobalVariables.URL_IMAGE + miembro.imagen!),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: WidgetsPersonalizados.getStars(miembro.calificacion!.toDouble()),
            ),
            AutoSizeText(
              "${miembro.nombres} ${miembro.apellidos}",
              maxLines: 2,
              minFontSize: 12,
              style: const TextStyle(color: Colores.COLOR_GRIS_HINT, fontSize: 20),
              textAlign: TextAlign.justify,
              overflow: TextOverflow.ellipsis,
            ),
            AutoSizeText(
              // "${MetodosUtiles.formatearFecha(oferta.fechaCreacion)}",
              miembro.email!.isEmpty ? "correo@email.com" : miembro.email!,
              maxLines: 1,
              minFontSize: 12,
              style: const TextStyle(color: Colores.COLOR_GRIS_HINT, fontSize: 16),
              textAlign: TextAlign.justify,
              overflow: TextOverflow.ellipsis,
            ),
            AutoSizeText(
              // "${MetodosUtiles.formatearFecha(oferta.fechaCreacion)}",
              "Tiempo : ${miembro.tiempo} horas",
              maxLines: 1,
              minFontSize: 12,
              style: const TextStyle(color: Colores.COLOR_GRIS_HINT, fontSize: 16),
              textAlign: TextAlign.justify,
              overflow: TextOverflow.ellipsis,
            ),
            AutoSizeText(
              // "${MetodosUtiles.formatearFecha(oferta.fechaCreacion)}",
              "${miembro.telefono}",
              maxLines: 1,
              minFontSize: 12,
              style: TextStyle(color: Colores.COLOR_GRIS_HINT, fontSize: 16),
              textAlign: TextAlign.justify,
              overflow: TextOverflow.ellipsis,
            ),
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: elementos,
              ),
            ),
          ],
        ),
      ),
      buttons: [
        DialogButton(
          onPressed: () {
            Navigator.pop(context);
          },
          width: 150,
          color: Colores.COLOR_VERDE_BOTON,
          child: const Text("Aceptar", style: TextStyle(color: Colors.white, fontSize: 20)),
        )
      ],
    ).show();
    debugPrint("Alert closed now.");
  }

  static alertWidget(BuildContext context, bool boton, String? titulo, Widget contenido, {VoidCallback? callback}) {
    Alert(
      context: context,
      title: titulo ?? "",
      // desc: "Flutter is more awesome with RFlutter Alert.",
      onWillPopActive: true,
      alertAnimation: fadeAlertAnimation,
      type: AlertType.success,
      closeIcon: const Icon(Icons.remove, color: Colors.white),
      content: Container(
        // color: Colores.COLOR_ROJO_BOTON,
        width: 100.0,
        height: 100.00,
        child: contenido,
      ),
      buttons: boton
          ? [
              DialogButton(
                onPressed: () async {
                  Navigator.pop(context);
                  if (callback != null) {
                    callback();
                  }
                },
                width: 150,
                color: Colores.COLOR_VERDE_BOTON,
                child: const Text("Aceptar", style: TextStyle(color: Colors.white, fontSize: 20)),
              )
            ]
          : [],
    ).show();
    // Code will continue after alert is closed.
    debugPrint("Alert closed now.");
  }

  static Widget fadeAlertAnimation(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return Align(
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }

  static alertConfirmError(BuildContext context, String mensaje, int tipo) {
    // tipo 1 = confirm   -1 = error
    AwesomeDialog dialogg;
    dialogg = AwesomeDialog(
      context: context,
      dialogType: (tipo == 1) ? DialogType.SUCCES : DialogType.ERROR,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Aviso',
      desc: mensaje,
      showCloseIcon: false,
      dismissOnTouchOutside: false,
      headerAnimationLoop: false,
      btnOkText: "Aceptar",
      btnOkColor: (tipo == 1) ? Colores.COLOR_VERDE_BOTON : Colores.COLOR_ROJO_BOTON,
      // dialogBackgroundColor: (tipo == 1) ? Colors.green : Colors.red ,
      // onDissmissCallback: (type) {
      //   debugPrint('Dialog Dissmiss from callback $type');
      // },
      // autoHide: Duration(seconds: 2),
      btnCancelText: "Cancelar",
      btnOkOnPress: () {
        print("ALERT  :: ONcLICK OK");
        // dialogg.dissmiss();
        // Navigator.of(context).pop();
      },
      // btnCancelOnPress: () {
      //   print("ALERT  :: ONcLICK CANCEL");
      // },
    )..show();
  }

  static alertInfo(BuildContext context, String mensaje, {VoidCallback? callback}) {
    // tipo 1 = confirm   -1 = error
    AwesomeDialog dialogg;
    dialogg = AwesomeDialog(
      context: context,
      dialogType: DialogType.NO_HEADER,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Aviso',
      desc: mensaje,
      showCloseIcon: false,
      dismissOnTouchOutside: false,
      headerAnimationLoop: false,
      btnOkText: "Aceptar",
      btnCancelText: "Cancelar",
      btnOkOnPress: () {
        print("ALERT  :: ONcLICK OK");
        if (callback != null) {
          callback();
        }
      },
      btnCancelOnPress: () {
        print("ALERT  :: ONcLICK CANCEL");
      },
    )..show();
  }

  static alertInfoContenido(BuildContext context, String mensaje, Widget contenido) {
    // tipo 1 = confirm   -1 = error
    AwesomeDialog dialogg;
    dialogg = AwesomeDialog(
      context: context,
      dialogType: DialogType.NO_HEADER,
      animType: AnimType.BOTTOMSLIDE,
      title: mensaje,
      // desc: mensaje,
      body: contenido,
      showCloseIcon: false,
      dismissOnTouchOutside: false,
      headerAnimationLoop: false,
      btnOkText: "Aceptar",
      // btnCancelText: "Cancelar",
      btnOkOnPress: () {
        print("ALERT  :: ONcLICK OK");
      },
      // btnCancelOnPress: () {
      //   print("ALERT  :: ONcLICK CANCEL");
      // },
    )..show();
  }
}
