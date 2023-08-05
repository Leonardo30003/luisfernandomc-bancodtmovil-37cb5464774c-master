import 'dart:convert';

import '../../models/transaccion_model.dart';

TransaccionesResponse transaccionesResponseFromJson(String str) =>
    TransaccionesResponse.fromJson(json.decode(str));

String transaccionesResponseToJson(TransaccionesResponse data) => json.encode(data.toJson());

class TransaccionesResponse {
  TransaccionesResponse({
    this.m,
    this.en,
    this.lM,
  });

  String? m = "";
  int? en = -1;
  List<TransaccionModel>? lM = [];

  factory TransaccionesResponse.fromJson(Map<String, dynamic> json) => TransaccionesResponse(
        m: json["m"] ?? "",
        en: json["en"] ?? -1,
        lM: json["lM"] == null
            ? []
            : List<TransaccionModel>.from(json["lM"].map((x) => TransaccionModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "m": m ?? "",
        "en": en ?? -1,
        "lM": lM == null ? [] : List<dynamic>.from(lM!.map((x) => x.toJson())),
      };
}
