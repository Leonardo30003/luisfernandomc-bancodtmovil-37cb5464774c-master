import 'package:auto_size_text/auto_size_text.dart';
import 'package:bancodetiempo/src/pages/drawer_pages/transacciones/transferir_horas_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/demanda_model.dart';
import '../../models/oferta_model.dart';
import '../../models/usuario_model.dart';
import '../../models/usuarioaplicado_model.dart';
import '../../providers/demandas_provider.dart';
import '../../providers/general_provider.dart';
import '../../providers/login_provider.dart';
import '../../providers/ofertas_provider.dart';
import '../../utils/colores.dart';
import '../../utils/variables_globales.dart';
import '../../widgets/alert_personalizado.dart';
import '../../widgets/widgets_personalizados.dart';
import '../crear_ofertademanda_page.dart';

class MisDemandas extends StatefulWidget {
  static const PAGE_ROUTE = "misofertaspage";

  @override
  _MisDemandasState createState() => _MisDemandasState();
}

var refreshMisDemandas = GlobalKey<RefreshIndicatorState>();

class _MisDemandasState extends State<MisDemandas> {
  late Generalprovider _generalprovider;
  late DemandasProvider _demandasProvider;
  late OfertasProvider _ofertasProvider;
  late LoginProvider _loginProvider;
  OfertaModel _ofertaModel = OfertaModel();
  UsuarioModel _usuarioLogin = UsuarioModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _generalprovider = Provider.of<Generalprovider>(context, listen: false);
    _loginProvider = Provider.of<LoginProvider>(context, listen: false);
    _ofertasProvider = Provider.of<OfertasProvider>(context, listen: false);
    _usuarioLogin = _loginProvider.usuario!;
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      // await _demandasProvider.obtenerCategorias();
      // await _demandasProvider.consultarDemandasMisDemandas(
      //     0, 50, _loginProvider.usuario.idUsuario, 1);
    });
  }

  @override
  Widget build(BuildContext contextP) {
    final Size screenSize = MediaQuery.of(contextP).size;
    _demandasProvider = Provider.of<DemandasProvider>(contextP);
    return SafeArea(
      child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colores.COLOR_GRIS_FONDO,
          padding: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
          child: RefreshIndicator(
            key: refreshMisDemandas,
            onRefresh: () async {
              await _demandasProvider.consultarDemandasMisDemandas(0, 50, _usuarioLogin.idUsuario!, 1);
            },
            color: Colores.COLOR_PRIMARY,
            child: _demandasProvider.listMisDemandasMostrar.isEmpty
                ? ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      SizedBox(height: 200),
                      Center(child: AutoSizeText(_demandasProvider.mensajeConsulta)),
                    ],
                  )
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: _demandasProvider.listMisDemandasMostrar.length,
                    itemBuilder: (context, index) {
                      DemandaModel _demandaActual = _demandasProvider.listMisDemandasMostrar[index];
                      return WidgetsPersonalizados.cardDemanda(
                        _demandaActual,
                        opcionesList: [
                          TextButton(
                            child: Icon(Icons.edit_outlined, color: Colores.COLOR_PRIMARY),
                            onPressed: () async {
                              _demandasProvider.demandaSeleccionada = _demandaActual;
                              _demandasProvider.estadoEditarDemanda = true;
                              Navigator.pushNamed(context, CrearOfertaDemandaPage.PAGE_ROUTE);
                            },
                          ),
                          _demandaActual.estado == 0
                              ? TextButton(
                                  child: Icon(
                                    Icons.visibility,
                                    color: Colores.COLOR_VERDE_DESABILITADO,
                                  ),
                                  onPressed: () async {
                                    await _demandasProvider.editarDemanda(
                                        context,
                                        1,
                                        _demandaActual.titulo!,
                                        _demandaActual.descripcionActividad!,
                                        _demandaActual.idCategoria!,
                                        _demandaActual.idOfertasDemandas!);
                                    _demandasProvider.consultarDemandasMisDemandas(0, 50, _usuarioLogin.idUsuario!, 1);
                                  },
                                )
                              : TextButton(
                                  child: Icon(Icons.visibility_off, color: Colores.COLOR_PRIMARY),
                                  onPressed: () async {
                                    // estado 0 desabilitado, 1 visible
                                    await _demandasProvider.editarDemanda(
                                        context,
                                        0,
                                        _demandaActual.titulo!,
                                        _demandaActual.descripcionActividad!,
                                        _demandaActual.idCategoria!,
                                        _demandaActual.idOfertasDemandas!);
                                    _demandasProvider.consultarDemandasMisDemandas(
                                        0, 50, _loginProvider.usuario!.idUsuario!, 1);
                                  },
                                ),
                          _demandaActual.numPostularon! > 0
                              ? TextButton(
                                  onPressed: () async {
                                    await _demandasProvider.consultarQuienesAplicaron(
                                        context, _demandaActual.idOfertasDemandas!);
                                    UsuarioAplicadoModel _usuarioAplicado = _demandasProvider.listQuienesAplicaron[0];
                                    await _generalprovider.crearOfertaOfUsuarioA(_usuarioAplicado);
                                    _ofertasProvider.ofertaSeleccionado = _generalprovider.ofertaCreada;
                                    AlertPersonalizado.alertInfoContenido(
                                      context,
                                      "Usuarios",
                                      WidgetsPersonalizados.cardMiembroAplicado(_usuarioAplicado, opcionesList: [
                                        WidgetsPersonalizados.iconPerso(
                                          Image(
                                            image: AssetImage("assets/images/whatsapp.png"),
                                            fit: BoxFit.contain,
                                          ),
                                          () async {
                                            if (_usuarioAplicado.telefono!.length == 10) {
                                              if (await canLaunch(GlobalVariables.URL_WHATSAPP +
                                                  "${_usuarioAplicado.telefono!.substring(1, 10)}")) {
                                                await launch(
                                                    GlobalVariables.URL_WHATSAPP +
                                                        "${_usuarioAplicado.telefono!.substring(1, 10)}",
                                                    forceSafariVC: false);
                                              }
                                            } else {
                                              Navigator.pop(context);
                                              WidgetsPersonalizados.mostrarToast(
                                                  mensaje: "El número registrado no es válido.");
                                            }
                                          },
                                        ),
                                        SizedBox(width: 10.0),
                                        WidgetsPersonalizados.iconPerso(
                                          Icon(Icons.more_time, color: Colores.COLOR_PRIMARY, size: 20.0),
                                          () {
                                            Navigator.pop(context);
                                            Navigator.pushNamed(context, TransferirHorasPage.PAGE_ROUTE,
                                                arguments: "misdemandas");
                                          },
                                        ),
                                        SizedBox(width: 10.0),
                                        WidgetsPersonalizados.iconPerso(
                                          Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                            size: 20.0,
                                          ),
                                          () async {
                                            Navigator.pop(context);
                                            await _demandasProvider.eliminarPostulanteDemanda(
                                                context, _demandaActual.idOfertasDemandas!);
                                            _demandasProvider.consultarDemandasMisDemandas(
                                                0, 50, _loginProvider.usuario!.idUsuario!, 1);
                                          },
                                        ),
                                      ]),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.person,
                                        color: Colores.COLOR_PRIMARY,
                                      ),
                                      AutoSizeText(
                                        " ${_demandaActual.numPostularon}",
                                        style: TextStyle(color: Colores.COLOR_PRIMARY),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                          SizedBox(
                            width: 8,
                          )
                        ],
                      );
                    },
                  ),
          )),
    );
  }
}
