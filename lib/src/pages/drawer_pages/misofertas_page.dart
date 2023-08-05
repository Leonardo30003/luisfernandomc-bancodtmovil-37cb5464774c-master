import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/oferta_model.dart';
import '../../models/usuario_model.dart';
import '../../models/usuarioaplicado_model.dart';
import '../../providers/general_provider.dart';
import '../../providers/login_provider.dart';
import '../../providers/ofertas_provider.dart';
import '../../utils/colores.dart';
import '../../utils/variables_globales.dart';
import '../../widgets/alert_personalizado.dart';
import '../../widgets/widgets_personalizados.dart';
import '../crear_ofertademanda_page.dart';

class MisOfertas extends StatefulWidget {
  static const PAGE_ROUTE = "misofertaspage";

  @override
  _MisOfertasState createState() => _MisOfertasState();
}

var refreshMisOfertasKey = GlobalKey<RefreshIndicatorState>();

class _MisOfertasState extends State<MisOfertas> {
  late Generalprovider _generalprovider;
  late OfertasProvider _ofertasProvider;
  late LoginProvider _loginProvider;
  UsuarioModel _usuarioLogin = UsuarioModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _generalprovider = Provider.of<Generalprovider>(context, listen: false);
    // _ofertasProvider = Provider.of<OfertasProvider>(context, listen: false);
    _loginProvider = Provider.of<LoginProvider>(context, listen: false);
    _usuarioLogin = _loginProvider.usuario!;
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      // await _ofertasProvider.obtenerCategorias();
      // await _ofertasProvider.consultarOfertasMisOfertas(0, 50, _loginProvider.usuario.idUsuario, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    _ofertasProvider = Provider.of<OfertasProvider>(context);
    // _generalprovider = Provider.of<Generalprovider>(context);
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colores.COLOR_GRIS_FONDO,
        padding: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
        child: RefreshIndicator(
          key: refreshMisOfertasKey,
          onRefresh: () async {
            await _ofertasProvider.consultarOfertasMisOfertas(0, 50, _loginProvider.usuario!.idUsuario!, 1);
          },
          color: Colores.COLOR_PRIMARY,
          child: _ofertasProvider.listMisOfertasMostrar.isEmpty
              ? ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    SizedBox(height:100),
                    Center(
                      child: AutoSizeText(_ofertasProvider.mensajeConsulta),
                    ),
                  ],
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: _ofertasProvider.listMisOfertasMostrar.length,
                  itemBuilder: (context, index) {
                    OfertaModel _ofertaSeleccionada = _ofertasProvider.listMisOfertasMostrar[index];
                    return WidgetsPersonalizados.cardOferta(
                      _ofertaSeleccionada,
                      opcionesList: [
                        TextButton(
                          child: Icon(Icons.edit_outlined, color: Colores.COLOR_PRIMARY),
                          onPressed: () async {
                            _ofertasProvider.ofertaSeleccionado = _ofertaSeleccionada;
                            _ofertasProvider.estadoEditarOferta = true;
                            Navigator.pushNamed(context, CrearOfertaDemandaPage.PAGE_ROUTE);
                          },
                        ),
                        _ofertaSeleccionada.estado == 0
                            ? TextButton(
                                child: Icon(Icons.visibility, color: Colores.COLOR_VERDE_DESABILITADO),
                                onPressed: () async {
                                  // estado 0 desabilitado, 1 visible
                                  await _ofertasProvider.editarOferta(
                                      context,
                                      1,
                                      _ofertaSeleccionada.titulo!,
                                      _ofertaSeleccionada.descripcionActividad!,
                                      _ofertaSeleccionada.idCategoria!,
                                      _ofertaSeleccionada.idOfertasDemandas!);
                                  await _ofertasProvider.consultarOfertasMisOfertas(0, 50, _usuarioLogin.idUsuario!, 1);
                                },
                              )
                            : TextButton(
                                child: Icon(Icons.visibility_off, color: Colores.COLOR_PRIMARY),
                                onPressed: () async {
                                  // estado 0 desabilitado, 1 visible
                                  await _ofertasProvider.editarOferta(
                                      context,
                                      0,
                                      _ofertaSeleccionada.titulo!,
                                      _ofertaSeleccionada.descripcionActividad!,
                                      _ofertaSeleccionada.idCategoria!,
                                      _ofertaSeleccionada.idOfertasDemandas!);
                                  await _ofertasProvider.consultarOfertasMisOfertas(0, 50, _usuarioLogin.idUsuario!, 1);
                                },
                              ),
                        _ofertaSeleccionada.numPostularon! > 0
                            ? TextButton(
                                onPressed: () async {
                                  await _ofertasProvider.consultarQuienesAplicaron(
                                      context, _ofertaSeleccionada.idOfertasDemandas!);
                                  AlertPersonalizado.alertInfoContenido(
                                    context,
                                    "Usuarios",
                                    Container(
                                      height: 300.0,
                                      child: ListView.builder(
                                          itemCount: _ofertasProvider.listQuienesAplicaron.length,
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (_, index) {
                                            UsuarioAplicadoModel _usuarioAplicado =
                                                _ofertasProvider.listQuienesAplicaron[index];
                                            return WidgetsPersonalizados.ListTitleMiembrosAplicados(
                                              _usuarioAplicado,
                                              WidgetsPersonalizados.iconPerso(
                                                Image(
                                                  image: AssetImage("assets/images/whatsapp.png"),
                                                  fit: BoxFit.contain,
                                                ),
                                                () async {
                                                  if (_usuarioAplicado.telefono!.length == 10) {
                                                    if (await canLaunch(GlobalVariables.URL_WHATSAPP +
                                                        "${_usuarioAplicado.telefono!.substring(1, 10)}")) {
                                                      // Navigator.pop(context);
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
                                            );
                                          }),
                                    ),
                                  ); // 0994682012
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      color: _ofertaSeleccionada.estado == 0
                                          ? Colores.COLOR_VERDE_DESABILITADO
                                          : Colores.COLOR_PRIMARY,
                                    ),
                                    AutoSizeText(
                                      " ${_ofertaSeleccionada.numPostularon}",
                                      style: TextStyle(color: Colores.COLOR_PRIMARY),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                        SizedBox(width: 8),
                      ],
                    );
                  },
                ),
        ),
      ),
    );
  }
}
