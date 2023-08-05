import 'dart:convert';

import 'package:intl/intl.dart';

OfertaModel ofertaModelFromJson(String str) => OfertaModel.fromJson(json.decode(str));

String ofertaModelToJson(OfertaModel data) => json.encode(data.toJson());

class OfertaModel {
  OfertaModel({
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

  int? isFavorito = -1;
  int? numPostularon = -1;
  int? pagar = -1;
  int? idOfertasDemandas = -1;
  String? fechaCreacion = "";
  String? descripcionActividad = "";
  String? titulo = "";
  int? idUsuario = -1;
  double? calificacion = 0.0;
  String? nombres = "";
  String? apellidos = "";
  int? idCategoria = -1;
  String? categoria = "";
  String? email = "";
  String? imagen = "";
  String? telefono = "";
  int? estado = 0;

  factory OfertaModel.fromJson(Map<String, dynamic> json) => OfertaModel(
        isFavorito: json["isFavorito"] ?? -1,
        numPostularon: json["numPostularon"] ?? 0,
        pagar: json["pagar"] ?? -1,
        idOfertasDemandas: json["idOfertasDemandas"] ?? -1,
        fechaCreacion: json["fecha_creacion"] == null
            ? ""
            : DateFormat('yyyy-MM-dd HH:mm:ss')
                .format(DateTime.parse(json["fecha_creacion"]).toLocal()),
        descripcionActividad: json["descripcion_actividad"],
        titulo: json["titulo"],
        idUsuario: json["idUsuario"] ?? -1,
        calificacion: json["calificacion"].toDouble() ?? 0.0,
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
        "isFavorito": isFavorito ?? -1,
        "numPostularon": numPostularon ?? 0,
        "pagar": pagar ?? -1,
        "idOfertasDemandas": idOfertasDemandas ?? -1,
        "fecha_creacion": fechaCreacion ?? "",
        "descripcion_actividad": descripcionActividad ?? "",
        "titulo": titulo ?? "",
        "idUsuario": idUsuario ?? -1,
        "calificacion": calificacion ?? 0.0,
        "nombres": nombres ?? "",
        "apellidos": apellidos ?? "",
        "idCategoria": idCategoria ?? -1,
        "categoria": categoria ?? "",
        "email": email ?? "",
        "imagen": imagen ?? "",
        "telefono": telefono ?? "",
        "estado": estado ?? 0
      };
}
