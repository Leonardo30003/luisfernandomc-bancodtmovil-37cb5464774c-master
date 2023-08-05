
class UsuarioBusquedaModel {
  UsuarioBusquedaModel({
    this.idPersona,
    this.nombres,
    this.apellidos,
    this.telefono,
    this.usuario,
    this.idUsuario,
  });

  int? idPersona = -1;
  String? nombres = "";
  String? apellidos = "";
  String? telefono = "";
  String? usuario = "";
  int? idUsuario = -1;

  factory UsuarioBusquedaModel.fromJson(Map<String, dynamic> json) => UsuarioBusquedaModel(
    idPersona: json["id_persona"] ?? -1,
    nombres: json["nombres"] ?? "",
    apellidos: json["apellidos"] ?? "",
    telefono: json["telefono"] ?? "",
    usuario: json["usuario"] ?? "",
    idUsuario: json["idUsuario"] ?? -1,
  );

  Map<String, dynamic> toJson() => {
    "id_persona": idPersona ?? -1,
    "nombres": nombres ?? "",
    "apellidos": apellidos ?? "",
    "telefono": telefono ?? "",
    "usuario": usuario  ?? "",
    "idUsuario": idUsuario  ?? -1,
  };
}
