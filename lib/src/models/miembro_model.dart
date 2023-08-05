import 'dart:convert';

MiembroModel miembroModelFromJson(String str) => MiembroModel.fromJson(json.decode(str));

String miembroModelToJson(MiembroModel data) => json.encode(data.toJson());

class MiembroModel {
  MiembroModel({
    this.idUsuario,
    this.nombres,
    this.apellidos,
    this.email,
    this.imagen,
    this.telefono,
    this.usuario,
    this.calificacion,
    this.tiempo,
  });

  int? idUsuario = -1;
  String? nombres = "";
  String? apellidos = "";
  String? email = "";
  String? imagen = "";
  String? telefono = "";
  String? usuario = "";
  double? calificacion = 0.0;
  int? tiempo = 0;

  factory MiembroModel.fromJson(Map<String, dynamic> json) => MiembroModel(
    idUsuario: json["idUsuario"] ?? -1,
    nombres: json["nombres"] ?? "",
    apellidos: json["apellidos"] ?? "",
    email: json["email"] ?? "",
    imagen: json["imagen"] ?? "",
    telefono: json["telefono"] ?? "",
    usuario: json["usuario"] ?? "",
    calificacion: json["calificacion"].toDouble() ?? 0.0,
    tiempo: json["tiempo"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "idUsuario": idUsuario ?? -1,
    "nombres": nombres ?? "",
    "apellidos": apellidos ?? "",
    "email": email ?? "",
    "imagen": imagen ?? "",
    "telefono": telefono ?? "",
    "usuario": usuario ?? "",
    "calificacion": calificacion ?? 0.0,
    "tiempo": tiempo ?? 0,
  };
}
