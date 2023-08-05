import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/controllers/drawer_controller.dart';
import '../data/response/buscar_usuario_response.dart';
import '../data/response/general_response.dart';
import '../data/response/transacciones_response.dart';
import '../models/transaccion_model.dart';
import '../models/usuario_busqueda_model.dart';
import '../widgets/await_dialogs.dart';
import '../widgets/widgets_personalizados.dart';

class DrawerProvider with ChangeNotifier {
  //TRANSFERIR HORAS
  TextEditingController _textEditingController = new TextEditingController();
  UsuarioBusquedaModel _usuarioBusquedaModel = UsuarioBusquedaModel();
  List<TransaccionModel> _listTransacciones = [];
  bool _mostrarProgress = false;
  bool _consultaExitosa = false;
  String _mensajeConsulta = "false";

  bool get mostrarProgress => _mostrarProgress;

  set mostrarProgress(bool value) {
    _mostrarProgress = value;
    notifyListeners();
  }

  bool get consultaExitosa => _consultaExitosa;

  String get mensajeConsulta => _mensajeConsulta;

  List<TransaccionModel> get listTransacciones => _listTransacciones;

  set listTransacciones(List<TransaccionModel> value) {
    _listTransacciones = value;
    notifyListeners();
  }

  TextEditingController get textEditingController => _textEditingController;

  set textEditingController(TextEditingController value) {
    _textEditingController = value;
    notifyListeners();
  }

  UsuarioBusquedaModel get usuarioBusquedaModel => _usuarioBusquedaModel;

  set usuarioBusquedaModel(UsuarioBusquedaModel value) {
    _usuarioBusquedaModel = value;
    notifyListeners();
  }

  Future<void> getUsuariosExistentes(BuildContext context, String celular, int idPersona) async {
    print("HORAS  >>  " + celular);
    mostrarProgress = true;
    BuscarUsuarioResponse buscarUsuarioResponse =
        await DrawerControllerA().buscarUsuario(celular, idPersona);
    if (buscarUsuarioResponse.usuario != null) {
      usuarioBusquedaModel = buscarUsuarioResponse.usuario!;
    } else {
      WidgetsPersonalizados.mostrarToast(mensaje: "${buscarUsuarioResponse.m}");
    }
    mostrarProgress = false;
  }

  Future<void> trasferirHoras( BuildContext context,
      {required int idUsuarioP, required int idUsuarioR, required String detalle, required double valoracion, required int monto}) async {
    AwaitsDialogs progressDialog = AwaitsDialogs(context);
    progressDialog.show("Consultando.", "Espere por favor...");
    ResponseGeneral responseGeneral = await DrawerControllerA().transferirHoras(
      idUsuarioPaga: idUsuarioP,
      idUsuarioRecibe: idUsuarioR,
      detalle: detalle,
      valoracion: valoracion,
      monto: monto,
    );
    if (responseGeneral != null) {
      if (responseGeneral.en == 1) {
        _consultaExitosa = true;
        _mensajeConsulta = responseGeneral.m!;
        notifyListeners();
        progressDialog.hide();
      }  else {
        _consultaExitosa = false;
        _mensajeConsulta = responseGeneral.m!;
        notifyListeners();
        progressDialog.hide();
        // WidgetsPersonalizados.mostrarToast(mensaje: "${responseGeneral.m}");
      }
    }
  }

  Future<void> consultarTransacciones(int desde, int cuantos, int idUsuario) async {
    TransaccionesResponse transaccionesResponse =
        await DrawerControllerA().consultarTransacciones(desde, cuantos, idUsuario);
    if (transaccionesResponse.lM != null) {
      listTransacciones = transaccionesResponse.lM!;
    } else {
      _listTransacciones = [];
      WidgetsPersonalizados.mostrarToast(mensaje: "${transaccionesResponse.m}");
    }
  }
}
