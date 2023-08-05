import 'dart:convert';

import '../../models/usuarioaplicado_model.dart';

QuienesAplicaronResponse quienesAplicaronResponseFromJson(String str) =>
    QuienesAplicaronResponse.fromJson(json.decode(str));

String quienesAplicaronResponseToJson(QuienesAplicaronResponse data) => json.encode(data.toJson());

class QuienesAplicaronResponse {
  QuienesAplicaronResponse({
    this.m,
    this.en,
    this.listAplicaron,
  });

  String? m;
  int? en;
  List<UsuarioAplicadoModel>? listAplicaron;

  factory QuienesAplicaronResponse.fromJson(Map<String, dynamic> json) => QuienesAplicaronResponse(
        m: json["m"] ?? "",
        en: json["en"] ?? -1,
        listAplicaron: json["lM"] == null
            ? []
            : List<UsuarioAplicadoModel>.from(
                json["lM"].map((x) => UsuarioAplicadoModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "m": m ?? "",
        "en": en ?? -1,
        "lM": listAplicaron == null ? [] : List<dynamic>.from(listAplicaron!.map((x) => x.toJson())),
      };
}
