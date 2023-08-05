import 'dart:convert';

CategoriaModel categoriaModelFromJson(String str) => CategoriaModel.fromJson(json.decode(str));

String categoriaModelToJson(CategoriaModel data) => json.encode(data.toJson());

class CategoriaModel {
  CategoriaModel({
    this.idCategoria,
    this.categoria,
    this.logo,
  });

  int? idCategoria = 0;
  String? categoria = "";
  String? logo = "";

  factory CategoriaModel.fromJson(Map<String, dynamic> json) => CategoriaModel(
    idCategoria: json["idCategoria"] ?? 0,
    categoria: json["categoria"] ?? "",
    logo: json["logo"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "idCategoria": idCategoria ?? 0,
    "categoria": categoria ?? "",
    "logo": logo ?? "",
  };
}
