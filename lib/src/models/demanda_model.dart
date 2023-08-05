import 'dart:convert';

import 'package:intl/intl.dart';

DemandaModel demandaModelFromJson(String str) => DemandaModel.fromJson(json.decode(str));

String demandaModelToJson(DemandaModel data) => json.encode(data.toJson());

class DemandaModel {
  DemandaModel({
    this.isFavorito,
    this.numPostularon,
    this.pagar,
    this.idOfertasDemandas,
    this.fechaCreacion,
    this.descripcionActividad,
    this.titulo,
    this.idUsuario,
    this.calificacion,
    this.nombres,
    this.apellidos,
    this.idCategoria,
    this.categoria,
    this.email,
    this.imagen,
    this.telefono,
    this.estado,
  });

  int? isFavorito = 0;
  int? numPostularon = 0;
  int? pagar = 0;
  int? idOfertasDemandas = -1;
  String? fechaCreacion = "";
  String? descripcionActividad = "";
  String? titulo = "";
  int? idUsuario = -1;
  int? calificacion = -1;
  String? nombres = "";
  String? apellidos = "";
  int? idCategoria = -1;
  String? categoria = "";
  String? email = "";
  String? imagen = "";
  String? telefono = "";
  int? estado = 0;

  factory DemandaModel.fromJson(Map<String, dynamic> json) => DemandaModel(
        isFavorito: json["isFavorito"] ?? 0,
        numPostularon: json["numPostularon"] ?? 0,
        pagar: json["pagar"] ?? 0,
        idOfertasDemandas: json["idOfertasDemandas"],
        fechaCreacion: json["fecha_creacion"] == null
            ? ""
            : DateFormat('yyyy-MM-dd HH:mm:ss')
                .format(DateTime.parse(json["fecha_creacion"]).toLocal()),
        descripcionActividad: json["descripcion_actividad"]  ?? "",
        titulo: json["titulo"]  ?? "",
        idUsuario: json["idUsuario"]  ?? -1,
        calificacion: json["calificacion"]  ?? -1,
        nombres: json["nombres"] ?? "",
        apellidos: json["apellidos"] ?? "",
        idCategoria: json["idCategoria"] ?? -1,
        categoria: json["categoria"] ?? "",
        email: json["email"] ?? "",
        imagen: json["imagen"] ?? "",
        telefono: json["telefono"] ?? "",
        estado: json["estado"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "isFavorito": isFavorito,
        "numPostularon": numPostularon,
        "pagar": pagar,
        "idOfertasDemandas": idOfertasDemandas,
        "fecha_creacion": fechaCreacion,
        "descripcion_actividad": descripcionActividad,
        "titulo": titulo,
        "idUsuario": idUsuario,
        "calificacion": calificacion,
        "nombres": nombres,
        "apellidos": apellidos,
        "idCategoria": idCategoria,
        "categoria": categoria,
        "email": email ?? "",
        "imagen": imagen,
        "telefono": telefono,
        "estado": estado ?? 0
      };
}
