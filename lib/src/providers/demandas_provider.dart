import 'package:bancodetiempo/src/widgets/await_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

import '../data/controllers/demandas_controllers.dart';
import '../data/controllers/ofertas_controllers.dart';
import '../data/response/categorias_response.dart';
import '../data/response/demanda_response.dart';
import '../data/response/general_response.dart';
import '../data/response/quienesaplicaron_response.dart';
import '../models/categoria_model.dart';
import '../models/demanda_model.dart';
import '../models/usuarioaplicado_model.dart';
import '../widgets/widgets_personalizados.dart';

class DemandasProvider with ChangeNotifier {
  List<DemandaModel> _listDemandas = [];
  List<DemandaModel> _listDemandasMostrar = [];
  List<DemandaModel> _listMisDemandasMostrar = [];
  List<CategoriaModel> _listCategorias = [];
  List<UsuarioAplicadoModel> _listQuienesAplicaron = [];
  List<String> _listStringcategorias = [];
  String _mensajeConsulta = "No existen demandas a mostrar";

  //
  DemandaModel _demandaSeleccionada = DemandaModel();
  bool _estadoEditarDemanda = false;
  int _indexMenuHorizontal = 0;

  List<DemandaModel> get listDemandas => _listDemandas;

  List<DemandaModel> get listDemandasMostrar => _listDemandasMostrar;

  List<DemandaModel> get listMisDemandasMostrar => _listMisDemandasMostrar;

  List<CategoriaModel> get listCategorias => _listCategorias;

  set listCategorias(List<CategoriaModel> value) {
    _listCategorias = value;
    notifyListeners();
  }

  DemandaModel get demandaSeleccionada => _demandaSeleccionada;

  set demandaSeleccionada(DemandaModel value) {
    _demandaSeleccionada = value;
    notifyListeners();
  }

  bool get estadoEditarDemanda => _estadoEditarDemanda;

  set estadoEditarDemanda(bool value) {
    _estadoEditarDemanda = value;
    notifyListeners();
  }

  List<UsuarioAplicadoModel> get listQuienesAplicaron => _listQuienesAplicaron;

  List<String> get listStringcategorias => _listStringcategorias;

  String get mensajeConsulta => _mensajeConsulta;

  int get indexMenuHorizontal => _indexMenuHorizontal;

  set indexMenuHorizontal(int value) {
    _indexMenuHorizontal = value;
    notifyListeners();
  }

  /// 0 = todas las demandas, 1 = mis demandas
  Future<void> consultarDemandasMisDemandas(int desde, int cuantos, int idUser, int misDemandas) async {
    DemandaResponse res = await DemandasController().obtenerDemandasList(desde, cuantos, idUser, misDemandas);
    if (res != null) {
      if (res.en == 1) {
        // verifica si se consulta todas las ofertas o solo las del usuario
        if (misDemandas == 0) {
          _listDemandas = res.listDemandas!;
          _listDemandasMostrar = res.listDemandas!;
          _indexMenuHorizontal = 0;
          notifyListeners();
        } else {
          // print("MIS_DEMANDAS  >> ${res.listDemandas.length}");
          _listMisDemandasMostrar = res.listDemandas!;
          notifyListeners();
        }
      } else {
        if (misDemandas == 0) {
          _listDemandas = [];
          _listDemandasMostrar = [];
          _indexMenuHorizontal = 0;
          _mensajeConsulta = res.m!;
          notifyListeners();
        } else {
          // print("MIS_DEMANDAS  >> ${res.listDemandas.length}");
          _listMisDemandasMostrar = [];
          _mensajeConsulta = res.m!;
          notifyListeners();
        }
        if (res.m != "") {
          WidgetsPersonalizados.mostrarToast(mensaje: res.m ?? "");
        }
      }
    }
  }

  Future<void> obtenerCategorias() async {
    ResponseCategorias _response = await DemandasController().obtenerCategorias();
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
        if (_response.m != "") {
          WidgetsPersonalizados.mostrarToast(mensaje: _response.m ?? "");
        }
      }
    }
  }

  Future<void> registrarDemanda(
      BuildContext context, String titulo, String descripcion, int idcategoria, int idUsuario) async {
    AwaitsDialogs progressDialog = AwaitsDialogs(context);
    progressDialog.show("Consultando.", "Espere por favor...");
    ResponseGeneral _response =
        await DemandasController().registrarDemanda(titulo, descripcion, idcategoria, idUsuario);
    if (_response != null) {
      progressDialog.hide();
      if (_response.m!.isNotEmpty) {
        WidgetsPersonalizados.mostrarToast(mensaje: _response.m!);
      }
    } else {
      progressDialog.hide();
    }
  }

  Future<void> registrarDemandaFavorita(BuildContext context, int idOfertaDemanda, int idUser, int estado) async {
    AwaitsDialogs progressDialog = AwaitsDialogs(context);
    if (estado == 1) {
      progressDialog.show("Aplicando a la demanda..", "Espere por favor...");
    } else {
      progressDialog.show("Quitando demanda aplicada.", "Espere por favor...");
    }
    ResponseGeneral _response = await DemandasController().registrarDemandaFavorita(idOfertaDemanda, idUser, estado);
    if (_response != null) {
      progressDialog.hide();
      if (_response.m != "") {
        WidgetsPersonalizados.mostrarToast(mensaje: _response.m!);
      }
    } else {
      progressDialog.hide();
    }
  }

  Future<void> editarDemanda(
      BuildContext context, int estado, String titulo, String descripcion, int idcategoria, int idOfertaDemanda) async {
    AwaitsDialogs progressDialog = AwaitsDialogs(context);
    progressDialog.show("Consultando.", "Espere por favor...");
    ResponseGeneral _response =
        await DemandasController().editarDemanda(estado, titulo, descripcion, idcategoria, idOfertaDemanda);
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

  Future<void> filtrarListDemandasMostrar(int idCateg) async {
    print("FILTRAR >> $idCateg");
    if (idCateg == 0) {
      _listDemandasMostrar = listDemandas;
      notifyListeners();
    } else {
      List<DemandaModel> _listDem = [];
      for (DemandaModel item in listDemandas) {
        if (item.idCategoria == idCateg) {
          _listDem.add(item);
        }
      }
      if (_listDem.isEmpty) {
        _mensajeConsulta = "No existen demandas en esta categoria";
      }
      _listDemandasMostrar = _listDem;
      notifyListeners();
    }
  }

  Future<void> eliminarPostulanteDemanda(BuildContext context, int idOfertaDemanda) async {
    AwaitsDialogs progressDialog = AwaitsDialogs(context);
    progressDialog.show("Eliminando postulante.", "Espere por favor...");
    // if (estado == 1) {
    // } else {
    //   progressDialog.show("Quitando demanda aplicada...");
    // }
    ResponseGeneral _response = await DemandasController().eliminarPostulanteDemanda(idOfertaDemanda);
    if (_response != null) {
      progressDialog.hide();
      if (_response.m != "") {
        WidgetsPersonalizados.mostrarToast(mensaje: _response.m!);
      }
    } else {
      progressDialog.hide();
    }
  }

  Future<void> buscarDemandasExistente(String criterio, bool buscar) async{
    List<DemandaModel> _listDemand = [];
    print("BUSQUEDA   >> " + criterio);
    if (buscar) {
      for (DemandaModel item in listDemandas) {
        if (item.titulo!.toLowerCase().contains(criterio) ||
            item.titulo!.toUpperCase().contains(criterio) ||
            item.descripcionActividad!.toUpperCase().contains(criterio) ||
            item.descripcionActividad!.toUpperCase().contains(criterio) ||
            item.titulo!.contains(criterio) ||
            item.descripcionActividad!.contains(criterio)) {
          _listDemand.add(item);
        }
      }

      if (_listDemand.isNotEmpty) {
        _listDemandasMostrar = _listDemand;
        notifyListeners();
      } else {
        WidgetsPersonalizados.mostrarToast(mensaje: "No existen demandas que coincidan con su búsqueda");
      }
    } else {
      _listDemandasMostrar = listDemandas;
      _indexMenuHorizontal = 0;
      notifyListeners();
    }
  }

  Future<void> limpiarProvider() async{
    _listDemandas = [];
    _listDemandasMostrar = [];
    _listMisDemandasMostrar = [];
    _listQuienesAplicaron = [];
    _listCategorias = [];
    _listStringcategorias = [];
    // _demandaSeleccionada = null;
    notifyListeners();
  }
}
