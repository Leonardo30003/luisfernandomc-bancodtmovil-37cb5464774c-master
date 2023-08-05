import 'dart:convert';

import '../../models/categoria_model.dart';

ResponseCategorias responseCategoriasFromJson(String str) =>
    ResponseCategorias.fromJson(json.decode(str));

String responseCategoriasToJson(ResponseCategorias data) => json.encode(data.toJson());

class ResponseCategorias {
  ResponseCategorias({
    this.en,
    this.m,
    this.t,
    this.listCategorias,
  });

  int? en = -1;
  String? m = "";
  int? t = 0;
  List<CategoriaModel>? listCategorias = [];

  factory ResponseCategorias.fromJson(Map<String, dynamic> json) => ResponseCategorias(
        en: json["en"] ?? -1,
        m: json["m"] ?? "",
        t: json["t"] ?? 0,
        listCategorias: json["ls"] == null
            ? []
            : List<CategoriaModel>.from(json["ls"].map((x) => CategoriaModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "en": en ?? -1,
        "m": m ?? "",
        "t": t ?? 0,
        "ls": listCategorias == null ? [] : List<dynamic>.from(listCategorias!.map((x) => x.toJson())),
      };
}
