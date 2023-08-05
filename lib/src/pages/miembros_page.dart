import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/miembro_model.dart';
import '../providers/general_provider.dart';
import '../providers/login_provider.dart';
import '../providers/miembros_provider.dart';
import '../providers/ofertas_provider.dart';
import '../utils/colores.dart';
import '../utils/variables_globales.dart';
import '../widgets/alert_personalizado.dart';
import '../widgets/widgets_personalizados.dart';
import 'drawer_pages/transacciones/transferir_horas_page.dart';

class MiembrosPage extends StatefulWidget {
  static const PAGE_ROUTE = "miembrospageroute";

  const MiembrosPage({Key? key}) : super(key: key);

  @override
  _MiembrosPageState createState() => _MiembrosPageState();
}

var refreshMiembrosKey = GlobalKey<RefreshIndicatorState>();

class _MiembrosPageState extends State<MiembrosPage> {
  late Generalprovider _generalprovider;
  late LoginProvider _loginProvider;
  late MiembrosProvider _miembrosProvider;
  late OfertasProvider _ofertasProvider;
  late Size _screenSize;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _generalprovider = Provider.of<Generalprovider>(context, listen: false);
    _loginProvider = Provider.of<LoginProvider>(context, listen: false);
    _miembrosProvider = Provider.of<MiembrosProvider>(context, listen: false);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      // await _miembrosProvider.getMiembrosList(_loginProvider.usuario.idUsuario);
    });
  }

  @override
  Widget build(BuildContext context) {
    _miembrosProvider = Provider.of<MiembrosProvider>(context);
    _ofertasProvider = Provider.of<OfertasProvider>(context);
    _screenSize = MediaQuery.of(context).size;
    // MiembroModel miembro;
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colores.COLOR_GRIS_FONDO,
        child: RefreshIndicator(
          key: refreshMiembrosKey,
          color: Colores.COLOR_PRIMARY,
          onRefresh: () async {
            await _miembrosProvider.consultarMiembrosList(_loginProvider.usuario!.idUsuario!);
          },
          child: _miembrosProvider.listMiembrosMostrar.isEmpty
              ? ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    SizedBox(height: 200),
                    Center(
                      child: AutoSizeText(_ofertasProvider.mensajeConsulta),
                    ),
                  ],
                )
              : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
                  scrollDirection: Axis.vertical,
                  itemCount: _miembrosProvider.listMiembrosMostrar.length,
                  itemBuilder: (_, index) {
                    MiembroModel _miembroSeleccionado = _miembrosProvider.listMiembrosMostrar[index];
                    return WidgetsPersonalizados.titleMiembro(
                      _miembroSeleccionado,
                      () {
                        AlertPersonalizado.alertMiembro(
                          context: context,
                          screenSize: _screenSize,
                          miembro: _miembroSeleccionado,
                          elementos: [
                            WidgetsPersonalizados.iconPerso(
                              Icon(Icons.more_time, color: Colores.COLOR_PRIMARY, size: 23.0),
                              () async {
                                if (_loginProvider.usuario!.tiempo! > 0) {
                                  await _generalprovider.crearOfertaOfMiembro(_miembroSeleccionado);
                                  _ofertasProvider.ofertaSeleccionado = _generalprovider.ofertaCreada;
                                  Navigator.pop(context);
                                  Navigator.pushNamed(context, TransferirHorasPage.PAGE_ROUTE, arguments: "miembros");
                                } else {
                                  WidgetsPersonalizados.mostrarToast(
                                      mensaje:
                                          "Actualmente no cuenta con horas suficientes para realizar una tranferencia");
                                }
                              },
                            ),
                            SizedBox(width: 10.0),
                            WidgetsPersonalizados.iconPerso(
                              Image(image: AssetImage("assets/images/whatsapp.png"), fit: BoxFit.contain),
                              () async {
                                if (_miembroSeleccionado.telefono!.length == 10) {
                                  print("W 10");
                                  if (await canLaunch(GlobalVariables.URL_WHATSAPP +
                                      "${_miembroSeleccionado.telefono!.substring(1, 10)}")) {
                                    await launch(
                                        GlobalVariables.URL_WHATSAPP +
                                            "${_miembroSeleccionado.telefono!.substring(1, 10)}",
                                        forceSafariVC: false);
                                  }
                                } else {
                                  Navigator.pop(context);
                                  WidgetsPersonalizados.mostrarToast(mensaje: "El número registrado no es válido.");
                                }
                              },
                              ancho: 25,
                            ),
                          ],
                        );
                      },
                    );
                  }),
        ),
      ),
    );
  }
}
