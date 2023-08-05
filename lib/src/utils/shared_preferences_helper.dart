import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/usuario_model.dart';

class SharedPreferencesHelper {
  //Guardar el usuario logeado
  static Future<void> saveUsuario(UsuarioModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (user == null) {
      prefs.setString("usuario", "");
    } else {
      final JsonEncoder _encoder = new JsonEncoder();
      prefs.setString("usuario", _encoder.convert(user.toJson()));
    }
  }

  static Future<UsuarioModel> getUsuario() async {
    final JsonDecoder _decoder = JsonDecoder();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString("usuario") ?? "";
    if (user.isEmpty) {
      return UsuarioModel();
    }
    return UsuarioModel.fromJson(_decoder.convert(user));
  }

  static Future<void> deleteUsuario() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("usuario");
  }

  //Guardar el estado de Logeo
  static Future<void> saveEstadoLogeado(bool logeado) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("logeado", logeado);
  }

  static Future<bool> getEstadoLogeado() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool logeado = prefs.getBool("logeado") ?? false;
    return logeado;
  }

  static Future<void> deleteEstadoLogeado() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("logeado");
  }

  //Guardar estado user
  static Future<void> saveUser(String user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user", user);
  }

  static Future<String> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString("user") ?? "";
    return user;
  }

  static Future<void> deleteUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("user");
  }

  //Guardar token
  static Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
  }

  static Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    return token;
  }
  static Future<void> deleteToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
  }
}
