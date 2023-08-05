import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bancodetiempo/src/pages/login/registro_page.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/login_provider.dart';
import '../../utils/colores.dart';
import '../../utils/metodos_utiles.dart';
import '../../widgets/fondo_login.dart';
import '../../widgets/widgets_personalizados.dart';
import '../home_page.dart';

class LoginPage extends StatefulWidget {
  static const PAGE_ROUTE = "loginpage";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colores.COLOR_GRIS_FONDO,
      body: SafeArea(
        child: Stack(
          children: [
            Fondos.fondoLogin(context: context),
            Fondos.fondoFormulario(
              screenWidth: screen.width * 0.55,// se modifica el ancho del recuadro
              screenHeigth: screen.height * 0.55,// se modifica el largo del cuadro
              formulario: FormularioLogin(),
            ),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.pushNamed(context, RegistroPage.PAGE_ROUTE);
            //   },
            //   child: Align(
            //     alignment: Alignment.topRight,
            //     child: Container(
            //       margin: EdgeInsets.only(right: 30.0, top: 30.0),
            //       child: AutoSizeText("REGISTRARSE", style: TextStyle(color: Colores.COLOR_BLANCO)),
            //     ),
            //   ),
            // )
            // WidgetsPersonalizados.backButton(
            //   context: context,
            //   colorIcon: Colores.COLOR_GRIS_HINT,
            //   callBack: () {
            //     Navigator.pop(context);
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

class FormularioLogin extends StatefulWidget {
  @override
  _FormularioLoginState createState() => _FormularioLoginState();
}

class _FormularioLoginState extends State<FormularioLogin> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController controlUser = new TextEditingController();

  TextEditingController controlPass = new TextEditingController();

  final estiloLine = TextStyle(
    color: Colores.COLOR_ICON_GREY,
    decoration: TextDecoration.lineThrough,
    decorationColor: Colores.COLOR_ICON_GREY,
    decorationThickness: 1.0,
    decorationStyle: TextDecorationStyle.solid,
  );

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    LoginProvider _loginProvider = Provider.of<LoginProvider>(context);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 10.0),
            AutoSizeText(
              "Iniciar Sesión",
              maxLines: 1,
              style: TextStyle(color: Colores.COLOR_PRIMARY, fontWeight: FontWeight.bold, fontSize: 35.0),
            ),
            AutoSizeText(
              "Ingresa su usuario y contraseña",
              maxLines: 1,
              style: TextStyle(color: Colores.COLOR_ICON_GREY, fontWeight: FontWeight.normal, fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Align(
              alignment: Alignment.centerLeft,
              child: AutoSizeText(
                "Usuario/Celular",
                maxLines: 1,
                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.normal, fontSize: 16.0),
              ),
            ),
            SizedBox(height: 5.0),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              controller: controlUser,
              // enableInteractiveSelection: false,
              decoration: InputDecoration(
                hintText: 'Ingresa su Usuario/Celular',
                hintStyle: TextStyle(fontSize: 20.0, color: Colores.COLOR_GRIS_HINT),
                fillColor: Colores.COLOR_GRIS_BORDER,
                filled: true,
                // focusColor: Colores.GRIS_BORDER_COLOR,
                // hoverColor: Colores.GRIS_BORDER_COLOR,
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                // border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                focusedBorder: OutlineInputBorder(
                  // borderSide: BorderSide(color: Colors.white),
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: new BorderSide(color: Colors.white),
                  borderRadius: new BorderRadius.circular(10.0),
                ),
              ),
              validator: (value) {
                // return MetodosUtiles.validateEmail(value);
                if (value != null) {
                  return MetodosUtiles.validatePruebas(value);
                }
                return null;
              },
            ),
            SizedBox(height: 20.0),
            Align(
              alignment: Alignment.centerLeft,
              child: AutoSizeText(
                "Ingresa su contraseña",
                maxLines: 1,
                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.normal, fontSize: 16.0),
              ),
            ),
            SizedBox(height: 5.0),
            TextFormField(
              autofocus: false,
              controller: controlPass,
              obscureText: _loginProvider.obscureText,
              keyboardType: TextInputType.text,
              // enableInteractiveSelection: false,
              decoration: InputDecoration(
                hintText: 'Ingresa tu contraseña',
                hintStyle: TextStyle(fontSize: 20.0, color: Colores.COLOR_GRIS_HINT),
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                fillColor: Colores.COLOR_GRIS_BORDER,
                filled: true,
                // border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                focusedBorder: OutlineInputBorder(
                  // borderSide: BorderSide(color: Colors.white),
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: new BorderSide(color: Colors.white),
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    _loginProvider.obscureText = !_loginProvider.obscureText;
                  },
                  child: Icon(
                    _loginProvider.obscureText ? Icons.visibility_off : Icons.visibility,
                    semanticLabel: _loginProvider.obscureText ? 'show password' : 'hide password',
                  ),
                ),
              ),
              validator: (value) {
                // return MetodosUtiles.validatePassword(value);
                if (value != null) {
                  return MetodosUtiles.validatePruebas(value);
                }
                return null;
              },
            ),
            const SizedBox(height: 20.0),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RegistroPage.PAGE_ROUTE);
                },
                child: AutoSizeText(
                  "Olvide la contraseña",
                  maxLines: 1,
                  style: TextStyle(
                      color: Colores.COLOR_PRIMARY,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                ),
              ),
            ),
            WidgetsPersonalizados.actionRaisedButton(
              context: context,
              title: "Ingresar",
              color: Colores.COLOR_PRIMARY,
              textColor: Colores.COLOR_BLANCO,
              borderColor: Colores.COLOR_PRIMARY,
              screenWidth: screen.width * 0.3,
              callBack: () async {
                if (_formKey.currentState!.validate()) {
                  print("PLATAFORM  >>>  true");
                  // log("LOGIN  >>   ${controlUser.text.trim()}   ${controlPass.text.trim()}");
                  await _loginProvider.realizarLogeo(context, controlUser.text.trim(), controlPass.text.trim(), true);
                  if (_loginProvider.usuario != null) {
                    Navigator.pushReplacementNamed(context, HomePage.PAGE_ROUTE);
                  }
                } else {
                  print("PLATAFORM  >>>  false");
                  print("LLEGA");
                }
              },
            ),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RegistroPage.PAGE_ROUTE);
                },
                child: AutoSizeText(
                  "Registrate",
                  maxLines: 1,
                  style: TextStyle(
                      color: Colores.COLOR_PRIMARY,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                ),
              ),
            ),
/*            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('                                  ', style: estiloLine),
                  Text('    Ó usa    ', style: TextStyle(color: Colores.COLOR_ICON_GREY)),
                  Text('                                  ', style: estiloLine),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  FloatingActionButton(
                    heroTag: "fc",
                    elevation: 0.5,
                    backgroundColor: Colores.COLOR_GRIS_FONDO,
                    onPressed: () {},
                    child: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        // border: Border.all(color: Colors.grey, width: 1.0, style: BorderStyle.solid),
                        image: new DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/facebook_logo.png"),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 30.0),
                  FloatingActionButton(
                    heroTag: "gm",
                    elevation: 0.5,
                    backgroundColor: Colores.COLOR_GRIS_FONDO,
                    onPressed: () {},
                    child: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // border: Border.all(color: Colores.GRIS_BORDER_COLOR, width: 1.0, style: BorderStyle.solid),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/images/gmail_logo.png"),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}

// class _FormularioState extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     Size screen = MediaQuery.of(context).size;
//     LoginProvider _loginProvider = Provider.of<LoginProvider>(context);
//     final _formKey = GlobalKey<FormState>();
//     TextEditingController controlUser = new TextEditingController();
//     TextEditingController controlPass = new TextEditingController();
//
//     final estiloLine = TextStyle(
//       color: Colores.COLOR_ICON_GREY,
//       decoration: TextDecoration.lineThrough,
//       decorationColor: Colores.COLOR_ICON_GREY,
//       decorationThickness: 1.0,
//       decorationStyle: TextDecorationStyle.solid,
//     );
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           SizedBox(height: 20.0),
//           Align(
//             alignment: Alignment.centerLeft,
//             child: AutoSizeText(
//               "Contraseña",
//               maxLines: 1,
//               style: TextStyle(color: Colores.COLOR_ICON_GREY, fontWeight: FontWeight.normal, fontSize: 14.0),
//             ),
//           ),
//           TextFormField(
//             autofocus: false,
//             controller: controlPass,
//             obscureText: _loginProvider.obscureText,
//             keyboardType: TextInputType.text,
//             // enableInteractiveSelection: false,
//             decoration: InputDecoration(
//               hintText: 'Ingresa tu contraseña',
//               contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
//               border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
//               suffixIcon: GestureDetector(
//                 onTap: () {
//                   _loginProvider.obscureText = !_loginProvider.obscureText;
//                 },
//                 child: Icon(
//                   _loginProvider.obscureText ? Icons.visibility : Icons.visibility_off,
//                   semanticLabel: _loginProvider.obscureText ? 'show password' : 'hide password',
//                 ),
//               ),
//             ),
//             validator: (value) {
//               return Utils.validatePassword(value);
//             },
//             onSaved: (String value) {
//               // _loginData.password = value;
//             },
//           ),
//           SizedBox(height: 20.0),
//           AutoSizeText(
//             "¿Olvidaste tu contraseña?",
//             maxLines: 1,
//             style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 14.0),
//           ),
//           SizedBox(height: 10.0),
//           WidgetsPersonalizados.actionRaisedButton(
//             title: "Ingresar",
//             color: Colores.AZUL_KRADAC_COLOR,
//             textColor: Colores.BLANCO,
//             borderColor: Colores.AZUL_KRADAC_COLOR,
//             screenWidth: screen.width * 1.3,
//             callBack: () {
//               if (_formKey.currentState.validate()) {
//                 Navigator.pushNamed(context, HomePage.PAGE_ROUTE);
//               }
//             },
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(vertical: 10.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('                                  ', style: estiloLine),
//                 Text('    Ó usa    ', style: TextStyle(color: Colores.COLOR_ICON_GREY)),
//                 Text('                                  ', style: estiloLine),
//               ],
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(vertical: 10.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Spacer(),
//                 FloatingActionButton(
//                   elevation: 0.5,
//                   backgroundColor: Colores.BLANCO,
//                   child: Container(
//                     width: 50.0,
//                     height: 50.0,
//                     decoration: new BoxDecoration(
//                       shape: BoxShape.circle,
//                       // border: Border.all(color: Colors.grey, width: 1.0, style: BorderStyle.solid),
//                       image: new DecorationImage(
//                         fit: BoxFit.fill,
//                         image: AssetImage("assets/img/logo_facebook.png"),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Spacer(),
//                 FloatingActionButton(
//                   elevation: 0.5,
//                   backgroundColor: Colores.BLANCO,
//                   child: Container(
//                     width: 50.0,
//                     height: 50.0,
//                     decoration: new BoxDecoration(
//                       shape: BoxShape.circle,
//                       // border: Border.all(color: Colores.GRIS_BORDER_COLOR, width: 1.0, style: BorderStyle.solid),
//                       image: new DecorationImage(
//                         fit: BoxFit.fill,
//                         image: AssetImage("assets/img/logo_gmail.png"),
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 // new Container(
//                 //   width: 50.0,
//                 //   height: 50.0,
//                 //   decoration: new BoxDecoration(
//                 //     shape: BoxShape.circle,
//                 //     border: Border.all(color: Colores.GRIS_BORDER_COLOR, width: 1.0, style: BorderStyle.solid),
//                 //     image: new DecorationImage(
//                 //       fit: BoxFit.fill,
//                 //       image: AssetImage("assets/img/logo_gmail.png"),
//                 //     ),
//                 //   ),
//                 // ),
//
//                 // IconButton(
//                 //   icon: Image.asset("assets/img/logo_gmail.png"),
//                 //   iconSize: 40,
//                 //   onPressed: () {},
//                 // ),
//                 Spacer(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
