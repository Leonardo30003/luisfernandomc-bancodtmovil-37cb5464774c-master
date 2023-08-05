import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../../models/transaccion_model.dart';
import '../../../providers/drawer_provider.dart';
import '../../../providers/login_provider.dart';
import '../../../utils/colores.dart';
import '../../../widgets/widgets_personalizados.dart';

class HistorialPage extends StatefulWidget {
  static const PAGE_ROUTE = "historialpage";

  @override
  _HistorialPageState createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {
  late LoginProvider _loginProvider;
  late DrawerProvider _drawerProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginProvider = Provider.of<LoginProvider>(context, listen: false);
    _drawerProvider = Provider.of<DrawerProvider>(context, listen: false);
    print("INIT  >> HISTORIAL");
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (_loginProvider.usuario == null) {
        _loginProvider.usuario = await _loginProvider.obtenerUsuario();
      }
      await _drawerProvider.consultarTransacciones(0, 100, _loginProvider.usuario!.idUsuario!);
    });
  }

  @override
  Widget build(BuildContext context) {
    _drawerProvider = Provider.of<DrawerProvider>(context);

    return Scaffold(
      appBar: WidgetsPersonalizados.appBarNormalOption(
          title: "Transacciones",
          elevation: 0.0,
          mostrarBackButton: true,
          optionsList: [],
          callBackButton: () async{
            Navigator.pop(context);
          }),
      body: SafeArea(
        child: _drawerProvider.listTransacciones.isEmpty
            ? WidgetsPersonalizados.loadingCenter()
            : Container(
                child: ListView.builder(
                  itemCount: _drawerProvider.listTransacciones.length,
                  itemBuilder: (_, index) {
                    // return Text("${_drawerProvider.listTransacciones[index].descripcionActividad}");
                    TransaccionModel trans = _drawerProvider.listTransacciones[index];
                    return ListTile(
                      title: AutoSizeText("Transaccion de Horas."),
                      subtitle: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText("${trans.fechaRegistro}."),
                          AutoSizeText("${trans.descripcionActividad}."),
                          AutoSizeText(
                            "Usuario : ${verificarTipo(trans.tipo!) ? "${trans.nombres} ${trans.apellidos}" : "${trans.nombres2} ${trans.apellidos2}"}",
                          )
                        ],
                      ),
                      trailing: Container(
                        width: 70.0,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Icon(
                                Icons.access_time,
                                color: verificarTipo(trans.tipo!)
                                    ? Colores.COLOR_ROJO_BOTON
                                    : Colores.COLOR_PRIMARY,
                              ),
                            ),
                            AutoSizeText(
                              "${trans.numeroHoras} Horas",
                              style: TextStyle(
                                color: verificarTipo(trans.tipo!)
                                    ? Colores.COLOR_ROJO_BOTON
                                    : Colores.COLOR_PRIMARY,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }

  bool verificarTipo(String t) {
    bool tipo = false;
    if (t == "0") {
      tipo = true;
    } else {
      tipo = false;
    }
    return tipo;
  }
}
