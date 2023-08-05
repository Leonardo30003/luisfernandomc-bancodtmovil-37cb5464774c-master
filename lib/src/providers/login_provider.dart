import 'package:flutter/material.dart';

import '../data/controllers/login_controller.dart';
import '../data/response/login_response.dart';
import '../models/usuario_model.dart';
import '../utils/metodos_utiles.dart';
import '../utils/shared_preferences_helper.dart';
import '../utils/variables_globales.dart';
import '../widgets/await_dialogs.dart';
import '../widgets/widgets_personalizados.dart';

class LoginProvider with ChangeNotifier {
  bool _obscureText = true;
  UsuarioModel? _usuario;

  bool get obscureText => _obscureText;

  set obscureText(bool value) {
    _obscureText = value;
    notifyListeners();
  }

  UsuarioModel? get usuario => _usuario;

  set usuario(UsuarioModel? value) {
    _usuario = value;
    notifyListeners();
  }

  Future<UsuarioModel?> realizarLogeo(
      BuildContext context, String user, String pass, bool mostrarProgres) async {
    // usuario = null;
    AwaitsDialogs progressDialog = AwaitsDialogs(context);
    if (mostrarProgres) {
      progressDialog.show("Ingresando.", "Espere por favor...");
    }
    String encriptar = MetodosUtiles.encriptarMD5(cadena: "$pass${GlobalVariables.TOKEN_LOGIN}");
    //print("LOGIN >> $user  $encriptar");
    LoginResponse res = await LoginController().logearUsuario(user, encriptar);
    if (res != null) {
      if (res.en == 1) {
        if (mostrarProgres) {
          progressDialog.hide();
        }
        usuario = res.usuario!;
        print(usuario);
        await SharedPreferencesHelper.saveUsuario(res.usuario!);
        await SharedPreferencesHelper.saveEstadoLogeado(true);
        await SharedPreferencesHelper.saveUser(user);
        await SharedPreferencesHelper.saveToken(pass);
        return res.usuario!;
      } else {
        if (mostrarProgres) {
          progressDialog.hide();
        }
        if (res.m!.isNotEmpty) {
          WidgetsPersonalizados.mostrarToast(mensaje: res.m!);
        }
        await SharedPreferencesHelper.saveEstadoLogeado(false);
        _usuario = null;
        notifyListeners();
        return null;
      }
    }
  }

  Future<bool> verificarLogeo() async {
    bool logeado = await SharedPreferencesHelper.getEstadoLogeado();
    return logeado;
  }

  Future<UsuarioModel> obtenerUsuario() async {
    UsuarioModel user = await SharedPreferencesHelper.getUsuario();
    return user;
  }

  Future<String> recuperarUser() async {
    String user = await SharedPreferencesHelper.getUser();
    return user;
  }

  Future<String> recuperarToken() async {
    String token = await SharedPreferencesHelper.getToken();
    return token;
  }

  Future<void> deslogearApp() async {
    // await SharedPreferencesHelper.saveUser(null);
    // await SharedPreferencesHelper.saveEstadoLogeado(false);
    // await SharedPreferencesHelper.saveUser("");
    // await SharedPreferencesHelper.saveToken("");
    await SharedPreferencesHelper.deleteUsuario();
    await SharedPreferencesHelper.deleteEstadoLogeado();
    await SharedPreferencesHelper.deleteUser();
    await SharedPreferencesHelper.deleteToken();
  }
}
