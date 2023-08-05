import 'dart:convert';

import '../../models/demanda_model.dart';

DemandaResponse demandaResponseFromJson(String str) => DemandaResponse.fromJson(json.decode(str));

String demandaResponseToJson(DemandaResponse data) => json.encode(data.toJson());

class DemandaResponse {
  DemandaResponse({
    this.m,
    this.en,
    this.listDemandas,
  });

  String? m = "";
  int? en = -1;
  List<DemandaModel>? listDemandas = [];

  factory DemandaResponse.fromJson(Map<String, dynamic> json) => DemandaResponse(
        m: json["m"] ?? "",
        en: json["en"] ?? -1,
        listDemandas: json["lM"] == null
            ? []
            : List<DemandaModel>.from(json["lM"].map((x) => DemandaModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "m": m ?? "",
        "en": en ?? -1,
        "lM": listDemandas == null ? [] : List<dynamic>.from(listDemandas!.map((x) => x.toJson())),
      };
}
