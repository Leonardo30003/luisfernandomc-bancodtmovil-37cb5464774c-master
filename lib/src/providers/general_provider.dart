import 'package:flutter/material.dart';

import '../data/controllers/general_controller.dart';
import '../data/response/categorias_response.dart';
import '../models/categoria_model.dart';
import '../models/miembro_model.dart';
import '../models/oferta_model.dart';
import '../models/usuarioaplicado_model.dart';
import '../widgets/widgets_personalizados.dart';

class Generalprovider with ChangeNotifier {
  String _textMisOD = "Mis Ofertas";
  int _currentIndexMisOD = 0;
  int _indexNavegador = 0;
  bool _isSearching = false;
  OfertaModel _ofertaCreada = OfertaModel();

  //categorias
  List<CategoriaModel> _listTodasCategorias = [];
  List<String> _listStringcategorias = [];
  String _categoriaSeleccionada = "";

  String get textMisOD => _textMisOD;

  List<CategoriaModel> get listTodasCategorias => _listTodasCategorias;

  set listTodasCategorias(List<CategoriaModel> value) {
    _listTodasCategorias = value;
    notifyListeners();
  }

  set textMisOD(String value) {
    _textMisOD = value;
    notifyListeners();
  }

  List<String> get listStringcategorias => _listStringcategorias;

  set listStringcategorias(List<String> value) {
    _listStringcategorias = value;
    notifyListeners();
  }

  String get categoriaSeleccionada => _categoriaSeleccionada;

  set categoriaSeleccionada(String value) {
    _categoriaSeleccionada = value;
    notifyListeners();
  }

  int get currentIndexMisOD => _currentIndexMisOD;

  set currentIndexMisOD(int value) {
    _currentIndexMisOD = value;
    notifyListeners();
  }

  int get indexNavegador => _indexNavegador;

  set indexNavegador(int value) {
    _indexNavegador = value;
    notifyListeners();
  }

  bool get isSearching => _isSearching;

  set isSearching(bool value) {
    _isSearching = value;
    notifyListeners();
  }

  OfertaModel get ofertaCreada => _ofertaCreada;

  set ofertaCreada(OfertaModel value) {
    _ofertaCreada = value;
    notifyListeners();
  }

  Future<void> consultarTodasCategorias() async {
    ResponseCategorias _response = await GeneralController().obtenerCategorias();
    if (_response != null) {
      if (_response.en == 1) {
        listTodasCategorias = _response.listCategorias!;
        List<String> _listCat = [];
        // _listCat.add("TODOS");
        for (CategoriaModel item in _response.listCategorias!) {
          _listCat.add(item.categoria!);
        }
        listStringcategorias = _listCat;
        if (_listCat.isNotEmpty) {
          categoriaSeleccionada = _listCat[0];
        }
      } else {
        WidgetsPersonalizados.mostrarToast(mensaje: _response.m!);
      }
    }
  }

  Future<void> crearOfertaOfMiembro(MiembroModel miembroModel) async {
    print("MIEMBRO >> ${miembroModel.nombres}");
    OfertaModel _oferta = new OfertaModel();
    _oferta.idUsuario = miembroModel.idUsuario;
    _oferta.nombres = miembroModel.nombres;
    _oferta.apellidos = miembroModel.apellidos;
    _oferta.email = miembroModel.email;
    _oferta.descripcionActividad = "";
    _ofertaCreada = _oferta;
    notifyListeners();
  }

  Future<void> crearOfertaOfUsuarioA(UsuarioAplicadoModel usuarioAplicado) async {
    _ofertaCreada = OfertaModel();
    _ofertaCreada.idUsuario = usuarioAplicado.idUsuario;
    _ofertaCreada.nombres = usuarioAplicado.nombres;
    _ofertaCreada.apellidos = usuarioAplicado.apellidos;
    _ofertaCreada.email = usuarioAplicado.email;
    _ofertaCreada.descripcionActividad = "";
    notifyListeners();
  }

  Future<void> limpiarProvider() async {
    _listStringcategorias = [];
    _listTodasCategorias = [];
    notifyListeners();
  }
}
