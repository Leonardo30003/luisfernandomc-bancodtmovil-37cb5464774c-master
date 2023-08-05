import 'dart:convert';

import '../../models/usuario_busqueda_model.dart';

BuscarUsuarioResponse buscarUsuarioResponseFromJson(String str) => BuscarUsuarioResponse.fromJson(json.decode(str));

String buscarUsuarioResponseToJson(BuscarUsuarioResponse data) => json.encode(data.toJson());

class BuscarUsuarioResponse {
  BuscarUsuarioResponse({
    this.en,
    this.m,
    this.usuario,
  });

  int? en = -1;
  String? m = "";
  UsuarioBusquedaModel? usuario = UsuarioBusquedaModel();

  factory BuscarUsuarioResponse.fromJson(Map<String, dynamic> json) => BuscarUsuarioResponse(
    en: json["en"] ?? -1,
    m: json["m"] ?? "",
    usuario: json["usuario"] == null ? null : UsuarioBusquedaModel.fromJson(json["usuario"]),
  );

  Map<String, dynamic> toJson() => {
    "en": en ?? -1,
    "m": m ?? "",
    "usuario": usuario == null ? UsuarioBusquedaModel() : usuario!.toJson(),
  };
}

