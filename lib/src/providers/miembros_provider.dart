import 'package:flutter/material.dart';

import '../data/controllers/miembros_controller.dart';
import '../data/response/miembros_response.dart';
import '../models/miembro_model.dart';
import '../widgets/widgets_personalizados.dart';

class MiembrosProvider with ChangeNotifier {
  List<MiembroModel> _listmiembros = [];
  List<MiembroModel> _listMiembrosMostrar = [];
  String _mensajeConsulta = "Consultando....";

  MiembroModel _miembroSeleccionado = MiembroModel();

  List<MiembroModel> get listmiembros => _listmiembros;

  List<MiembroModel> get listMiembrosMostrar => _listMiembrosMostrar;

  MiembroModel get miembroSeleccionado => _miembroSeleccionado;

  set miembroSeleccionado(MiembroModel value) {
    _miembroSeleccionado = value;
    notifyListeners();
  }

  String get mensajeConsulta => _mensajeConsulta;

  Future<void> consultarMiembrosList(int idUser) async {
    MiembrosResponse response = await MiembrosController().obtenerMiembrosList(idUser);
    if (response != null) {
      if (response.en == 1) {
        _listmiembros = response.miembros!;
        _listMiembrosMostrar = response.miembros!;
        notifyListeners();
      } else {
        _mensajeConsulta = response.m!;
        notifyListeners();
        if (response.m!.isNotEmpty) {
          WidgetsPersonalizados.mostrarToast(mensaje: response.m!);
        }
      }
    }
  }

  Future<void> buscarMiembrosExistentes(String criterio, bool buscar) async {
    List<MiembroModel> _lista = [];
    print("BUSQUEDA   >> " + criterio);
    if (buscar) {
      for (MiembroModel item in listmiembros) {
        if (item.nombres!.toLowerCase().contains(criterio) ||
            item.nombres!.toUpperCase().contains(criterio) ||
            item.apellidos!.toLowerCase().contains(criterio) ||
            item.apellidos!.toUpperCase().contains(criterio) ||
            item.nombres!.contains(criterio) ||
            item.apellidos!.contains(criterio) ||
            item.telefono!.contains(criterio)) {
          print("BUSQUEDA ENCONTRADO  >> " + criterio);
          _lista.add(item);
        }
      }
      if (_lista.isNotEmpty) {
        _listMiembrosMostrar = _lista;
        notifyListeners();
      } else {
        WidgetsPersonalizados.mostrarToast(
            mensaje: "No existen miembros que coincidan con su búsqueda");
      }
    } else {
      _listMiembrosMostrar = listmiembros;
      notifyListeners();
    }
  }

  Future<void> limpiarProvider() async {
    _listmiembros = [];
    _listMiembrosMostrar = [];
    // _miembroSeleccionado = null;
    notifyListeners();
  }
}
