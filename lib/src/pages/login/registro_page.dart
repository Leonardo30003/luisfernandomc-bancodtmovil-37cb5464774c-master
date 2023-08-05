import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/login_provider.dart';
import '../../utils/colores.dart';
import '../../utils/metodos_utiles.dart';
import '../../widgets/fondo_login.dart';
import '../../widgets/widgets_personalizados.dart';
import '../home_page.dart';

class RegistroPage extends StatefulWidget {
  static const PAGE_ROUTE = "registropage";

  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Fondos.fondoLogin(context: context),
            Fondos.fondoFormulario(
              screenWidth: screen.width * 0.55,
              screenHeigth: screen.height * 0.70,
              formulario: FormularioRegistro(),
            ),
            WidgetsPersonalizados.backButton(
              colorIcon: Colores.COLOR_SPLASH,
              callBack: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}

class FormularioRegistro extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controlNombres = TextEditingController();
  TextEditingController controlApellido = TextEditingController();
  TextEditingController controlEmail = TextEditingController();
  TextEditingController controlPass = TextEditingController();

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
      child: Column(
        children: [
          SizedBox(height: 20.0),
          AutoSizeText(
            "Registro",
            maxLines: 1,
            style: TextStyle(color: Colores.COLOR_PRIMARY, fontWeight: FontWeight.bold, fontSize: 35.0),
          ),
          AutoSizeText(
            "Ingresa la información solicitada",
            maxLines: 1,
            style: TextStyle(color: Colores.COLOR_ICON_GREY, fontWeight: FontWeight.normal, fontSize: 16.0),
          ),
          SizedBox(height: 30.0),
          Align(
            alignment: Alignment.centerLeft,
            child: AutoSizeText(
              "Nombres",
              maxLines: 1,
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.normal, fontSize: 16.0),
            ),
          ),
          SizedBox(height: 5.0),
          TextFormField(
            keyboardType: TextInputType.text,
            autofocus: false,
            controller: controlNombres,
            // enableInteractiveSelection: false,
            decoration: InputDecoration(
              hintText: 'Ingresa tu nombre',
              hintStyle: TextStyle(fontSize: 20.0, color: Colores.COLOR_GRIS_HINT),
              fillColor: Colores.COLOR_GRIS_BORDER,
              filled: true,
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              focusedBorder: OutlineInputBorder(
                // borderSide: BorderSide(color: Colors.white),
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            validator: (value) {
              return null;
              // return Utils.validateEmail(value);
            },
          ),
          SizedBox(height: 20.0),
          Align(
            alignment: Alignment.centerLeft,
            child: AutoSizeText(
              "Apellidos",
              maxLines: 1,
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.normal, fontSize: 16.0),
            ),
          ),
          SizedBox(height: 5.0),
          TextFormField(
            keyboardType: TextInputType.text,
            autofocus: false,
            controller: controlApellido,
            // enableInteractiveSelection: false,
            decoration: InputDecoration(
              hintText: 'Ingresa tus apellidos',
              hintStyle: TextStyle(fontSize: 20.0, color: Colores.COLOR_GRIS_HINT),
              fillColor: Colores.COLOR_GRIS_BORDER,
              filled: true,
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              focusedBorder: OutlineInputBorder(
                // borderSide: BorderSide(color: Colors.white),
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            validator: (value) {
              return null;
              // return Utils.validateEmail(value);
            },
          ),
          SizedBox(height: 20.0),
          Align(
            alignment: Alignment.centerLeft,
            child: AutoSizeText(
              "Correo",
              maxLines: 1,
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.normal, fontSize: 16.0),
            ),
          ),
          SizedBox(height: 5.0),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            autofocus: false,
            controller: controlEmail,
            // enableInteractiveSelection: false,
            decoration: InputDecoration(
              hintText: 'Ingresa tu usuario/email',
              hintStyle: TextStyle(fontSize: 20.0, color: Colores.COLOR_GRIS_HINT),
              fillColor: Colores.COLOR_GRIS_BORDER,
              filled: true,
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              // border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              focusedBorder: OutlineInputBorder(
                // borderSide: BorderSide(color: Colors.white),
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            validator: (value) {
              if (value != null) {
                return MetodosUtiles.validateEmail(value);
              }
              return null;
            },
          ),
          SizedBox(height: 20.0),
          Align(
            alignment: Alignment.centerLeft,
            child: AutoSizeText(
              "Ingresa tu contraseña",
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
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(10.0),
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
              if (value != null) {
                String respuesta = MetodosUtiles.validatePassword(value);
                if (respuesta.isEmpty) {
                  return null;
                }
              }
            },
          ),
          SizedBox(height: 15.0),
          WidgetsPersonalizados.actionRaisedButton( context: context,
            title: "Registrar",
            color: Colores.COLOR_PRIMARY,
            textColor: Colores.COLOR_BLANCO,
            borderColor: Colores.COLOR_PRIMARY,
            screenWidth: screen.width * 0.3,
            callBack: () {
              if (_formKey.currentState!.validate()) {
                Navigator.pushNamed(context, HomePage.PAGE_ROUTE);
              }
            },
          ),
          // Container(
          //   padding: EdgeInsets.symmetric(vertical: 10.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Text('                                  ', style: estiloLine),
          //       Text('    Ó usa    ', style: TextStyle(color: Colores.COLOR_ICON_GREY)),
          //       Text('                                  ', style: estiloLine),
          //     ],
          //   ),
          // ),
          // Container(
          //   padding: EdgeInsets.symmetric(vertical: 10.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Spacer(),
          //       FloatingActionButton(
          //         elevation: 0.5,
          //         backgroundColor: Colores.BLANCO,
          //         child: Container(
          //           width: 50.0,
          //           height: 50.0,
          //           decoration: new BoxDecoration(
          //             shape: BoxShape.circle,
          //             // border: Border.all(color: Colors.grey, width: 1.0, style: BorderStyle.solid),
          //             image: new DecorationImage(
          //               fit: BoxFit.fill,
          //               image: AssetImage("assets/img/logo_facebook.png"),
          //             ),
          //           ),
          //         ),
          //       ),
          //       SizedBox(width: 30.0),
          //       FloatingActionButton(
          //         elevation: 0.5,
          //         backgroundColor: Colores.BLANCO,
          //         child: Container(
          //           width: 50.0,
          //           height: 50.0,
          //           decoration: new BoxDecoration(
          //             shape: BoxShape.circle,
          //             // border: Border.all(color: Colores.GRIS_BORDER_COLOR, width: 1.0, style: BorderStyle.solid),
          //             image: new DecorationImage(
          //               fit: BoxFit.fill,
          //               image: AssetImage("assets/img/logo_gmail.png"),
          //             ),
          //           ),
          //         ),
          //       ),
          //       Spacer(),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
