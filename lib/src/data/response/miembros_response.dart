import 'dart:convert';

import '../../models/miembro_model.dart';

MiembrosResponse miembrosResponseFromJson(String str) => MiembrosResponse.fromJson(json.decode(str));

String miembrosResponseToJson(MiembrosResponse data) => json.encode(data.toJson());

class MiembrosResponse {
  MiembrosResponse({
    this.en,
    this.m,
    this.error,
    this.miembros,
  });

  int? en;
  String? m;
  int? error;
  List<MiembroModel>? miembros = [];

  factory MiembrosResponse.fromJson(Map<String, dynamic> json) => MiembrosResponse(
    en: json["en"] ?? -1,
    m: json["m"] ?? "",
    error: json["error"] ?? 1,
    miembros: json["miembros"] == null ? [] : List<MiembroModel>.from(json["miembros"].map((x) => MiembroModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "en": en ?? -1,
    "m": m ?? "",
    "error": error ?? -1,
    "miembros": miembros == null ? [] :List<dynamic>.from(miembros!.map((x) => x.toJson())),
  };
}

