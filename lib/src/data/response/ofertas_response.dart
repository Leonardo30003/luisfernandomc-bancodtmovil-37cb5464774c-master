import 'dart:convert';

import '../../models/oferta_model.dart';

OfertasResponse ofertasResponseFromJson(String str) => OfertasResponse.fromJson(json.decode(str));

String ofertasResponseToJson(OfertasResponse data) => json.encode(data.toJson());

class OfertasResponse {
  OfertasResponse({
    this.m,
    this.en,
    this.listOfertas,
  });

  String? m = "";
  int? en = -1;
  List<OfertaModel>? listOfertas = [];

  factory OfertasResponse.fromJson(Map<String, dynamic> json) => OfertasResponse(
        m: json["m"] ?? "",
        en: json["en"] ?? -1,
        listOfertas: json["lM"] == null
            ? []
            : List<OfertaModel>.from(json["lM"].map((x) => OfertaModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "m": m ?? "",
        "en": en ?? -1,
        "lM": listOfertas == null ? [] : List<dynamic>.from(listOfertas!.map((x) => x.toJson())),
      };
}
