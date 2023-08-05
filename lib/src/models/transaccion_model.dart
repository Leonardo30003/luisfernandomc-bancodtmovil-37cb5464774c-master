import 'dart:convert';

import 'package:intl/intl.dart';

TransaccionModel transaccionModelFromJson(String str) =>
    TransaccionModel.fromJson(json.decode(str));

String transaccionModelToJson(TransaccionModel data) => json.encode(data.toJson());

class TransaccionModel {
  TransaccionModel({
    this.tipo,
    this.idTransaccion,
    this.numeroHoras,
    this.fechaRegistro,
    this.descripcionActividad,
    this.nombres,
    this.apellidos,
    this.nombres2,
    this.apellidos2,
  });

  String? tipo  = "";
  int? idTransaccion  = -1;
  int? numeroHoras = 0;
  String? fechaRegistro  = "";
  String? descripcionActividad = "";
  String? nombres = "";
  String? apellidos = "";
  String? nombres2 = "";
  String? apellidos2 = "";

  factory TransaccionModel.fromJson(Map<String, dynamic> json) => TransaccionModel(
        tipo: json["tipo"] ?? "",
        idTransaccion: json["id_transaccion"]  ?? -1,
        numeroHoras: json["numero_horas"] ?? 0,
        fechaRegistro: json["fechaRegistro"] == null
            ? ""
            : DateFormat('yyyy-MM-dd HH:mm:ss')
                .format(DateTime.parse(json["fechaRegistro"]).toLocal()),
        descripcionActividad: json["descripcion_actividad"] ?? "",
        nombres: json["nombres"] ?? "",
        apellidos: json["apellidos"] ?? "",
        nombres2: json["nombres2"] ?? "",
        apellidos2: json["apellidos2"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "tipo": tipo ?? "",
        "id_transaccion": idTransaccion ?? -1,
        "numero_horas": numeroHoras ?? -1,
        "fechaRegistro": fechaRegistro ?? "",
        "descripcion_actividad": descripcionActividad  ?? "",
        "nombres": nombres ?? "",
        "apellidos": apellidos ?? "",
        "nombres2": nombres2 ?? "",
        "apellidos2": apellidos2  ?? "",
      };
}
