import 'dart:convert';

UsuarioModel usuarioModelFromJson(String str) => UsuarioModel.fromJson(json.decode(str));

String usuarioModelToJson(UsuarioModel data) => json.encode(data.toJson());

class UsuarioModel {
  UsuarioModel({
    this.idPersona,
    this.nombres,
    this.apellidos,
    this.telefono,
    this.usuario,
    this.idUsuario,
    this.tiempo,
    this.direccion,
    this.email,
    this.imagen,
    this.calificacion,
    this.npublicaciones,
  });

  int? npublicaciones = 0;
  int? idPersona = -1;
  String? nombres = "";
  String? apellidos = "";
  String? telefono = "";
  String? usuario = "";
  int? idUsuario = -1;
  int? tiempo = 0;
  String? direccion = "";
  String? email = "";
  String? imagen = "";
  double? calificacion = 0.0;

  factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        npublicaciones: json["num_publicaciones"] ?? 0,
        idPersona: json["id_persona"] ?? -1,
        nombres: json["nombres"] ?? "",
        apellidos: json["apellidos"] ?? "",
        telefono: json["telefono"] ?? "",
        usuario: json["usuario"] ?? "",
        idUsuario: json["idUsuario"] ?? -1,
        tiempo: json["tiempo"] ?? 0,
        direccion: json["direccion"] ?? "",
        email: json["email"] ?? "",
        imagen: json["imagen"] ?? "",
        calificacion: json["calificacion"].toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "num_publicaciones": npublicaciones ?? 0,
        "id_persona": idPersona ?? -1,
        "nombres": nombres ?? "",
        "apellidos": apellidos ?? "",
        "telefono": telefono ?? "",
        "usuario": usuario ?? "",
        "idUsuario": idUsuario ?? -1,
        "tiempo": tiempo ?? "",
        "direccion": direccion ?? "",
        "email": email ?? "",
        "imagen": imagen ?? "",
        "calificacion": calificacion ?? 0.0,
      };
}
