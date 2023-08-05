import 'package:auto_size_text/auto_size_text.dart';
import 'package:bancodetiempo/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/usuario_model.dart';
import '../../providers/login_provider.dart';
import '../../utils/colores.dart';
import '../../utils/variables_globales.dart';
import '../../widgets/widgets_personalizados.dart';

class PerfilPage extends StatefulWidget {
  // const PerfilPage({Key key}) : super(key: key);
  static const PAGE_ROUTE = "perfilpage";

  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  @override
  Widget build(BuildContext context) {
    Size screenSized = MediaQuery.of(context).size;
    LoginProvider _loginProvider = Provider.of<LoginProvider>(context);
    UsuarioModel usuarioPerfil = _loginProvider.usuario!;
    return Scaffold(
      // appBar: WidgetsPersonalizados.appBarNormalOption(
      //     title: "Perfil Usuario",
      //     elevation: 0.0,
      //     mostrarBackButton: true,
      //     optionsList: [],
      //     callBackButton: () {
      //       Navigator.pop(context);
      //     }),
      body: SafeArea(
        child: Container(
          color: Colores.COLOR_GRIS_FONDO,
          child: Stack(
            children: [
              Container(
                height: 200,
                padding: EdgeInsets.only(bottom: 10),
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/images/buisness.jpg"), fit: BoxFit.cover),
                ),
                child: Center(),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  // color: Colores.COLOR_GRIS_FONDO,
                  margin: EdgeInsets.only(top: 130),
                  height: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Usuario(assetsImage: usuarioPerfil.imagen!, size: 120),
                      Center(
                        child: WidgetsPersonalizados.getStars(usuarioPerfil.calificacion!, sizeStar: 30.0),
                      ),
                      Center(
                        child: Text(
                          "${usuarioPerfil.nombres} ${usuarioPerfil.apellidos}",
                          style: TextStyle(
                              color: Colors.black54, fontSize: 25, fontWeight: FontWeight.bold, letterSpacing: 1.0),
                        ),
                      ),
                      SizedBox(height: 20.0),

                      Container(
                        width: screenSized.width,
                        height: 25,
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        // color: Colores.COLOR_ROJO_BOTON,
                        child: Row(
                          children: [
                            AutoSizeText(
                              "Dirección:",
                              style: TextStyle(
                                  color: Colores.COLOR_PRIMARY,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0),
                            ),
                            SizedBox(width: 20.0),
                            AutoSizeText(
                              "${usuarioPerfil.direccion}",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.0,
                              ),
                              overflow: TextOverflow.fade,
                              maxFontSize: 16.0,
                              minFontSize: 10.0,
                              maxLines: 2,
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                      Container(
                        width: screenSized.width,
                        height: 25,
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        // color: Colores.COLOR_ROJO_BOTON,
                        child: Row(
                          children: [
                            AutoSizeText(
                              "Email:      ",
                              style: TextStyle(
                                  color: Colores.COLOR_PRIMARY,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0),
                            ),
                            SizedBox(width: 20.0),
                            AutoSizeText(
                                "${usuarioPerfil.email}",
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.0),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                      Container(
                        width: screenSized.width,
                        height: 25,
                        padding: EdgeInsets.symmetric(horizontal: 20.0), // color: Colores.COLOR_ROJO_BOTON,
                        child: Row(
                          children: [
                            AutoSizeText(
                              "Teléfono: ",
                              style: TextStyle(
                                  color: Colores.COLOR_PRIMARY,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0),
                            ),
                            SizedBox(width: 20.0),
                            AutoSizeText(
                              "${usuarioPerfil.telefono}",
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.0),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Container(
                        width: double.infinity,
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ItemInfoUsuario(
                              Text(
                                "${usuarioPerfil.tiempo}",
                                style: TextStyle(
                                    color: Colores.COLOR_PRIMARY,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.0),
                              ),
                              "Nº Horas",
                            ),
                            ItemInfoUsuario(
                              Text(
                                "${usuarioPerfil.npublicaciones}",
                                style: TextStyle(
                                    color: Colores.COLOR_PRIMARY,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.0),
                              ),
                              "Publicaciones",
                            ),
                            ItemInfoUsuario(
                                // Center(
                                //   child: WidgetsPersonalizados.getStars(usuarioPerfil.calificacion,
                                //       sizeStar: 20.0),
                                // ),
                                Text(
                                  "${usuarioPerfil.calificacion}",
                                  style: TextStyle(
                                      color: Colores.COLOR_PRIMARY,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.0),
                                ),
                                "Calificación"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              WidgetsPersonalizados.backButtonFlotante(
                callback: () {
                  Navigator.pop(context);
                },
                sizeButton: 40.0,
                colorIcon: Colores.COLOR_ICON_GREY,
                colorButton: Colores.COLOR_GRIS_TRANSPARENTE,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Usuario extends StatelessWidget {
  final String assetsImage;
  final double size;

  const Usuario({required this.assetsImage, required this.size}) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          color: Colores.COLOR_BLANCO,
          image: DecorationImage(
            image: assetsImage == ""
                ? const AssetImage(Assets.imagesPlaceholder) as ImageProvider
                : NetworkImage(GlobalVariables.URL_IMAGE + assetsImage),
            fit: BoxFit.cover,
          ),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 5)),
      margin: EdgeInsets.only(bottom: 10),
    );
  }
}

class ItemInfoUsuario extends StatelessWidget {
  Widget dato;
  String descripcion;

  ItemInfoUsuario(this.dato, this.descripcion);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            dato,
            Text(descripcion,
                style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
          ],
        ),
      ),
    );
  }
}
