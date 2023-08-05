import 'dart:convert';

ResponseGeneral responseGeneralFromJson(String str) => ResponseGeneral.fromJson(json.decode(str));

String responseGeneralToJson(ResponseGeneral data) => json.encode(data.toJson());

class ResponseGeneral {
  ResponseGeneral({
    this.error,
    this.m,
    this.en,
  });

  int? error = -1;
  String? m = "";
  int? en = -1;

  factory ResponseGeneral.fromJson(Map<String, dynamic> json) => ResponseGeneral(
    error: json["error"] ?? 1,
    m: json["m"] ?? "",
    en: json["en"] == -1 ? null : json["en"],
  );

  Map<String, dynamic> toJson() => {
    "error": error ?? 1,
    "m": m ?? "",
    "en": en ?? -1,
  };
}
