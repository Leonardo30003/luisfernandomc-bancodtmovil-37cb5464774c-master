import 'dart:convert';

UsuarioAplicadoModel usuarioAplicadoModelFromJson(String str) => UsuarioAplicadoModel.fromJson(json.decode(str));

String usuarioAplicadoModelToJson(UsuarioAplicadoModel data) => json.encode(data.toJson());

class UsuarioAplicadoModel {
  UsuarioAplicadoModel({
    this.idUsuario,
    this.nombres,
    this.apellidos,
    this.telefono,
    this.email,
    this.imagen,
  });

  int? idUsuario = -1;
  String? nombres = "";
  String? apellidos = "";
  String? telefono = "";
  String? email = "";
  String? imagen = "";

  factory UsuarioAplicadoModel.fromJson(Map<String, dynamic> json) => UsuarioAplicadoModel(
        idUsuario: json["idUsuario"] ?? -1,
        nombres: json["nombres"] ?? "",
        apellidos: json["apellidos"] ?? "",
        telefono: json["telefono"] ?? "",
        email: json["email"] ?? "",
        imagen: json["imagen"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "idUsuario": idUsuario ?? -1,
        "nombres": nombres ?? "",
        "apellidos": apellidos ?? "",
        "telefono": telefono ?? "",
        "email": email ?? "",
        "imagen": imagen ?? "",
      };
}
