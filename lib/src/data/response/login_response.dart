import 'dart:convert';

import 'package:bancodetiempo/src/pages/drawer_pages/perfil_page.dart';

import '../../models/usuario_model.dart';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.m,
    this.en,
    this.usuario,
  });

  String? m = "";
  int? en = -1;
  UsuarioModel? usuario = UsuarioModel();


  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    m: json["m"] ?? "",
    en: json["en"] ?? -1,
    usuario: json["usuario"] == null ? null : UsuarioModel.fromJson(json["usuario"]),
  );

  Map<String, dynamic> toJson() => {
    "m": m ?? "",
    "en": en ?? -1,
    "usuario": usuario == null ? null : usuario!.toJson(),
  };
}
