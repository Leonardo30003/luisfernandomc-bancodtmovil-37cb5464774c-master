import 'package:auto_size_text/auto_size_text.dart';
import 'package:bancodetiempo/src/models/usuario_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/categoria_model.dart';
import '../models/oferta_model.dart';
import '../providers/general_provider.dart';
import '../providers/login_provider.dart';
import '../providers/ofertas_provider.dart';
import '../utils/colores.dart';
import '../utils/variables_globales.dart';
import '../widgets/alert_personalizado.dart';
import '../widgets/widgets_personalizados.dart';
import 'drawer_pages/transacciones/transferir_horas_page.dart';

class OfertasPage extends StatefulWidget {
  static const PAGE_ROUTE = "ofertaspageroute";

  const OfertasPage({Key? key}) : super(key: key);

  @override
  _OfertasPageState createState() => _OfertasPageState();
}

var refreshOfertasKey = GlobalKey<RefreshIndicatorState>();

class _OfertasPageState extends State<OfertasPage> {
  late Generalprovider _generalprovider;
  late LoginProvider _loginProvider;
  late OfertasProvider _ofertasProvider;
  late Size screenSize;
  UsuarioModel _usuarioLogin = UsuarioModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _generalprovider = Provider.of<Generalprovider>(context, listen: false);
    _loginProvider = Provider.of<LoginProvider>(context, listen: false);
    _usuarioLogin = _loginProvider.usuario!;
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      // await _ofertasProvider.obtenerCategorias();
      // await _ofertasProvider.consultarOfertasMisOfertas(
      //     0, 100, _loginProvider.usuario.idUsuario, 0);
      // _ofertasProvider.posicionMenuHorizontal = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    _ofertasProvider = Provider.of<OfertasProvider>(context);
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colores.COLOR_GRIS_FONDO,
        child: RefreshIndicator(
          key: refreshOfertasKey,
          onRefresh: () async {
            await _ofertasProvider.obtenerCategorias();
            await _ofertasProvider.consultarOfertasMisOfertas(0, 100, _usuarioLogin.idUsuario!, 0);
          },
          color: Colores.COLOR_PRIMARY,
          child: _ofertasProvider.listOfertas.isEmpty
              ? ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    SizedBox(
                      height: 200,
                    ),
                    Center(child: AutoSizeText(_ofertasProvider.mensajeConsulta)),
                  ],
                )
              : Column(
                  children: [
                    (_ofertasProvider.listCategorias.isEmpty)
                        ? Container()
                        : Container(
                            width: double.infinity,
                            height: 50.0,
                            padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
                            // color: Colores.COLOR_PRIMARY,
                            child: ListView.builder(
                              itemCount: _ofertasProvider.listCategorias.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                CategoriaModel _categoria = _ofertasProvider.listCategorias[index];
                                return Center(
                                  child: WidgetsPersonalizados.botonMenuOfertasDemandas(
                                    "${_categoria.categoria}",
                                    Icons.sort,
                                    () async {
                                      await _ofertasProvider
                                          .getListOfertasMostrar(_categoria.idCategoria!);
                                      _ofertasProvider.posicionMenuHorizontal = index;
                                    },
                                    5,
                                    _ofertasProvider.posicionMenuHorizontal == index
                                        ? Colores.COLOR_PRIMARY
                                        : Colors.black12,
                                    _ofertasProvider.posicionMenuHorizontal == index
                                        ? Colores.COLOR_BLANCO
                                        : Colores.COLOR_PRIMARY,
                                  ),
                                );
                              },
                            ),
                          ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                        width: double.infinity,
                        // color: Colores.COLOR_PRIMARY,
                        // height: 40.0,
                        child: ListView.builder(
                          itemCount: _ofertasProvider.listOfertasMostrar.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            OfertaModel _ofertaActual = _ofertasProvider.listOfertasMostrar[index];
                            return WidgetsPersonalizados.cardOferta(
                              _ofertaActual,
                              opcionesList: [
                                _ofertaActual.pagar == 0
                                    ? Container()
                                    : WidgetsPersonalizados.iconPerso(
                                        Image(
                                          image: AssetImage("assets/images/whatsapp.png"),
                                          fit: BoxFit.contain,
                                        ),
                                        () async {
                                          if (_ofertaActual.telefono!.length == 10) {
                                            print("W 10");
                                            if (await canLaunch(GlobalVariables.URL_WHATSAPP +
                                                "${_ofertaActual.telefono!.substring(1, 10)}")) {
                                              await launch(
                                                  GlobalVariables.URL_WHATSAPP +
                                                      "${_ofertaActual.telefono!.substring(1, 10)}",
                                                  forceSafariVC: false);
                                            }
                                          } else {
                                            Navigator.pop(context);
                                            WidgetsPersonalizados.mostrarToast(
                                                mensaje: "El número registrado no es válido.");
                                          }
                                        },
                                        ancho: 25,
                                      ),
                                SizedBox(width: 10.0),
                                _ofertaActual.isFavorito == 1
                                    ? IconButton(
                                        icon: Icon(
                                          Icons.more_time,
                                          color: Colores.COLOR_PRIMARY,
                                          size: 20.0,
                                        ),
                                        onPressed: () async {
                                          if (_usuarioLogin.tiempo! > 0) {
                                            _ofertasProvider.ofertaSeleccionado = _ofertaActual;
                                            Navigator.pushNamed(
                                                context, TransferirHorasPage.PAGE_ROUTE,
                                                arguments: "ofertas");
                                          } else {
                                            WidgetsPersonalizados.mostrarToast(
                                                mensaje:
                                                    "Actualmente no cuenta con horas suficientes para tranferir");
                                          }
                                        },
                                      )
                                    : Container(),
                                TextButton(
                                  child: Text("Ver"),
                                  onPressed: () {
                                    AlertPersonalizado.alertOferta(
                                      context: context,
                                      screenSize: screenSize,
                                      editar: false,
                                      oferta: _ofertaActual,
                                      callback: () {},
                                    );
                                  },
                                ),
                                _ofertaActual.pagar == 0
                                    ? Container()
                                    : _ofertaActual.isFavorito == 1
                                        ? IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.redAccent,
                                            ),
                                            onPressed: () async {
                                              await _ofertasProvider.registrarOfertaFavorita(
                                                context,
                                                _ofertaActual.idOfertasDemandas!,
                                                _usuarioLogin.idUsuario!,
                                                0,
                                              );
                                              await _ofertasProvider.obtenerCategorias();
                                              await _ofertasProvider.consultarOfertasMisOfertas(
                                                  0, 100, _usuarioLogin.idUsuario!, 0);
                                            },
                                          )
                                        : TextButton(
                                            child: Text("Aplicar"),
                                            onPressed: () async {
                                              await _ofertasProvider.registrarOfertaFavorita(
                                                context,
                                                _ofertaActual.idOfertasDemandas!,
                                                _usuarioLogin.idUsuario!,
                                                1,
                                              );
                                              await _ofertasProvider.obtenerCategorias();
                                              await _ofertasProvider.consultarOfertasMisOfertas(
                                                  0, 100, _loginProvider.usuario!.idUsuario!, 0);
                                            },
                                          ),
                                SizedBox(width: 8),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
