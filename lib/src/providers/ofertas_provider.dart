import 'package:flutter/material.dart';

import '../data/controllers/ofertas_controllers.dart';
import '../data/response/categorias_response.dart';
import '../data/response/general_response.dart';
import '../data/response/ofertas_response.dart';
import '../data/response/quienesaplicaron_response.dart';
import '../models/categoria_model.dart';
import '../models/oferta_model.dart';
import '../models/usuarioaplicado_model.dart';
import '../widgets/await_dialogs.dart';
import '../widgets/widgets_personalizados.dart';

class OfertasProvider with ChangeNotifier {
  // Ofertas
  List<OfertaModel> _listOfertas = [];
  List<OfertaModel> _listOfertasMostrar = [];
  List<OfertaModel> _listMisOfertasMostrar = [];
  List<UsuarioAplicadoModel> _listQuienesAplicaron = [];
  List<String> _categorias = [];
  List<String> _listStringcategorias = [];
  List<CategoriaModel> _listCategorias = [];
  OfertaModel _ofertaSeleccionado = OfertaModel();
  String _mensajeConsulta = "";

  //Estados
  bool _estadoEditarOferta = false;
  int _posicionMenuHorizontal = 0;

  //Barra de busqueda
  bool _isSearching = false;
  bool _okTranferencia = false;

  //guarda la lista de ofertas
  List<OfertaModel> get listOfertas => _listOfertas;

  List<String> get categorias => _categorias;

  set categorias(List<String> value) {
    _categorias = value;
    notifyListeners();
  }

  List<CategoriaModel> get listCategorias => _listCategorias;

  set listCategorias(List<CategoriaModel> value) {
    _listCategorias = value;
    notifyListeners();
  }

  List<String> get listStringcategorias => _listStringcategorias;

  set listStringcategorias(List<String> value) {
    _listStringcategorias = value;
    notifyListeners();
  }

  bool get isSearching => _isSearching;

  set isSearching(bool value) {
    _isSearching = value;
    notifyListeners();
  }

  List<OfertaModel> get listOfertasMostrar => _listOfertasMostrar;

  List<OfertaModel> get listMisOfertasMostrar => _listMisOfertasMostrar;

  OfertaModel get ofertaSeleccionado => _ofertaSeleccionado;

  set ofertaSeleccionado(OfertaModel value) {
    _ofertaSeleccionado = value;
    notifyListeners();
  }

  bool get estadoEditarOferta => _estadoEditarOferta;

  set estadoEditarOferta(bool value) {
    _estadoEditarOferta = value;
    notifyListeners();
  }

  bool get okTranferencia => _okTranferencia;

  set okTranferencia(bool value) {
    _okTranferencia = value;
    notifyListeners();
  }

  List<UsuarioAplicadoModel> get listQuienesAplicaron => _listQuienesAplicaron;

  int get posicionMenuHorizontal => _posicionMenuHorizontal;

  set posicionMenuHorizontal(int value) {
    _posicionMenuHorizontal = value;
    notifyListeners();
  }

  String get mensajeConsulta => _mensajeConsulta;

  Future<void> obtenerCategorias() async {
    ResponseCategorias _response = await OfertasCOntroller().obtenerCategorias();
    if (_response != null) {
      if (_response.en == 1) {
        _listCategorias = _response.listCategorias!;
        List<String> _listCat = [];
        for (CategoriaModel item in _response.listCategorias!) {
          _listCat.add(item.categoria!);
        }
        _listStringcategorias = _listCat;
        notifyListeners();
      } else {
        if (_response.m!.isNotEmpty) {
          WidgetsPersonalizados.mostrarToast(mensaje: _response.m!);
        }
      }
    }
  }

  Future<void> registrarOferta(
      BuildContext context, String titulo, String descripcion, int idcategoria, int idUsuario) async {
    AwaitsDialogs progressDialog = AwaitsDialogs(context);
    progressDialog.show("Consultando.", "Espere por favor...");
    ResponseGeneral _response = await OfertasCOntroller().registrarOferta(titulo, descripcion, idcategoria, idUsuario);
    print("REGISTRAR Oferta  >> $_response ");
    if (_response != null) {
      progressDialog.hide();
      if (_response.m!.isNotEmpty) {
        WidgetsPersonalizados.mostrarToast(mensaje: _response.m!);
      }
    } else {
      progressDialog.hide();
    }
  }

  // 0 = todas las ofertas, 1 = mis ofertas
  Future<void> consultarOfertasMisOfertas(int desde, int cuantos, int idUser, int misOfer) async {
    OfertasResponse res = await OfertasCOntroller().obtenerOfertasList(desde, cuantos, idUser, misOfer);
    if (res != null) {
      if (res.en == 1) {
        // verifica si se consulta todas las ofertas o solo las del usuario
        if (misOfer == 0) {
          _listOfertas = res.listOfertas!;
          _listOfertasMostrar = res.listOfertas!;
          _posicionMenuHorizontal = 0;
          notifyListeners();
        } else {
          _listMisOfertasMostrar = res.listOfertas!;
          notifyListeners();
        }
      } else {
        if (misOfer == 0) {
          _listOfertas = [];
          _listOfertasMostrar = [];
          _posicionMenuHorizontal = 0;
          _mensajeConsulta = res.m!;
          notifyListeners();
        } else {
          _listMisOfertasMostrar = [];
          _mensajeConsulta = res.m!;
          notifyListeners();
        }
        if (res.m!.isNotEmpty) {
          WidgetsPersonalizados.mostrarToast(mensaje: res.m!);
        }
      }
    }
  }

  Future<void> getListOfertasMostrar(int idCateg) async {
    print("FILTRAR >> $idCateg");
    if (idCateg == 0) {
      _listOfertasMostrar = listOfertas;
      notifyListeners();
    } else {
      List<OfertaModel> _listOfert = [];
      for (OfertaModel item in listOfertas) {
        if (item.idCategoria == idCateg) {
          _listOfert.add(item);
        }
      }
      if (_listOfert.isEmpty) {
        _mensajeConsulta = "No existen ofertas en esta categoria";
      }
      _listOfertasMostrar = _listOfert;
      notifyListeners();
    }
  }

  Future<void> buscarOfertasExistente(String criterio, bool buscar) async {
    List<OfertaModel> _listOfert = [];
    print("BUSQUEDA   >> " + criterio);
    if (buscar) {
      for (OfertaModel item in listOfertas) {
        if (item.titulo!.toLowerCase().contains(criterio) ||
            item.titulo!.toUpperCase().contains(criterio) ||
            item.descripcionActividad!.toUpperCase().contains(criterio) ||
            item.descripcionActividad!.toUpperCase().contains(criterio) ||
            item.titulo!.contains(criterio) ||
            item.descripcionActividad!.contains(criterio)) {
          _listOfert.add(item);
        }
      }
      if (_listOfert.isNotEmpty) {
        _listOfertasMostrar = _listOfert;
        notifyListeners();
      } else {
        WidgetsPersonalizados.mostrarToast(mensaje: "No existen ofertas que coincidan con su búsqueda");
      }
    } else {
      _listOfertasMostrar = listOfertas;
      _posicionMenuHorizontal = 0;
      notifyListeners();
    }
  }

  Future<void> registrarOfertaFavorita(BuildContext context, int idOfertaDemanda, int idUser, int estado) async {
    AwaitsDialogs progressDialog = AwaitsDialogs(context);
    if (estado == 1) {
      progressDialog.show("Aplicando a la oferta.", "Espere por favor...");
    } else {
      progressDialog.show("Quitando oferta aplicada.", "Espere por favor...");
    }
    ResponseGeneral _response = await OfertasCOntroller().registrarOfertaFavorita(idOfertaDemanda, idUser, estado);
    if (_response != null) {
      progressDialog.hide();
      if (_response.m!.isNotEmpty) {
        WidgetsPersonalizados.mostrarToast(mensaje: _response.m!);
      }
    } else {
      progressDialog.hide();
    }
  }

  Future<void> editarOferta(
      BuildContext context, int estado, String titulo, String descripcion, int idcategoria, int idOfertaDemanda) async {
    AwaitsDialogs progressDialog = AwaitsDialogs(context);
    progressDialog.show("Consultando.", "Espere por favor...");
    ResponseGeneral _response =
        await OfertasCOntroller().editarOferta(estado, titulo, descripcion, idcategoria, idOfertaDemanda);
    print("EDITAR Oferta  >> $_response ");
    if (_response != null) {
      progressDialog.hide();
      if (_response.m!.isNotEmpty) {
        WidgetsPersonalizados.mostrarToast(mensaje: _response.m!);
      }
    } else {
      progressDialog.hide();
    }
  }

  Future<void> consultarQuienesAplicaron(BuildContext context, int idOfertaDemanda) async {
    AwaitsDialogs progressDialog = AwaitsDialogs(context);
    progressDialog.show("Consultando.", "Espere por favor...");
    QuienesAplicaronResponse _response = await OfertasCOntroller().quienesAplicaron(idOfertaDemanda);
    if (_response != null) {
      _listQuienesAplicaron = _response.listAplicaron!;
      notifyListeners();
      progressDialog.hide();
      if (_response.m!.isNotEmpty) {
        WidgetsPersonalizados.mostrarToast(mensaje: _response.m!);
      }
    } else {
      progressDialog.hide();
    }
  }

  Future<void> limpiarProvider() async {
    _listOfertasMostrar = [];
    _listOfertas = [];
    _listMisOfertasMostrar = [];
    _listQuienesAplicaron = [];
    _listCategorias = [];
    _listStringcategorias = [];
    // _ofertaSeleccionado = null;
    notifyListeners();
  }
}
