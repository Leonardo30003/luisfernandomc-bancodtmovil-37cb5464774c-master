import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/categoria_model.dart';
import '../models/demanda_model.dart';
import '../models/usuario_model.dart';
import '../providers/demandas_provider.dart';
import '../providers/general_provider.dart';
import '../providers/login_provider.dart';
import '../utils/colores.dart';
import '../utils/variables_globales.dart';
import '../widgets/alert_personalizado.dart';
import '../widgets/widgets_personalizados.dart';

class DemandasPage extends StatefulWidget {
  static const PAGE_ROUTE = "demandaspageroute";

  const DemandasPage({Key? key}) : super(key: key);

  @override
  _DemandasPageState createState() => _DemandasPageState();
}

var refreshDemandasKey = GlobalKey<RefreshIndicatorState>();

class _DemandasPageState extends State<DemandasPage> {
  late Generalprovider _generalprovider;
  late LoginProvider _loginProvider;
  late DemandasProvider _demandasProvider;
  UsuarioModel _usuarioLogin = UsuarioModel();
  late Size screenSize;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _generalprovider = Provider.of<Generalprovider>(context, listen: false);
    _loginProvider = Provider.of<LoginProvider>(context, listen: false);
    // _demandasProvider = Provider.of<DemandasProvider>(context, listen: false);
    _usuarioLogin = _loginProvider.usuario!;
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      // await _demandasProvider.obtenerCategorias();
      // await _demandasProvider.consultarDemandasMisDemandas(
      //     0, 100, _loginProvider.usuario.idUsuario, 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    _demandasProvider = Provider.of<DemandasProvider>(context);
    // _loginProvider = Provider.of<LoginProvider>(context);
    screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: RefreshIndicator(
        key: refreshDemandasKey,
        onRefresh: () async {
          await _demandasProvider.obtenerCategorias();
          await _demandasProvider.consultarDemandasMisDemandas(0, 100, _usuarioLogin.idUsuario!, 0);
        },
        color: Colores.COLOR_PRIMARY,
        child: _demandasProvider.listDemandas.isEmpty
            ? ListView(
                scrollDirection: Axis.vertical,
                children: [
                  SizedBox(height: 300),
                  Center(child: AutoSizeText(_demandasProvider.mensajeConsulta)),
                ],
              )
            : Column(
                children: [
                  _demandasProvider.listCategorias.isEmpty
                      ? Container()
                      : Container(
                          width: double.infinity,
                          color: Colores.COLOR_GRIS_FONDO,
                          height: 50.0,
                          padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
                          child: ListView.builder(
                            itemCount: _demandasProvider.listCategorias.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              CategoriaModel _categoriaActual = _demandasProvider.listCategorias[index];
                              return Center(
                                child: WidgetsPersonalizados.botonMenuOfertasDemandas(
                                  "${_categoriaActual.categoria}",
                                  Icons.sort,
                                  () async {
                                    await _demandasProvider.filtrarListDemandasMostrar(_categoriaActual.idCategoria!);
                                    _demandasProvider.indexMenuHorizontal = index;
                                    // _demandasProvider.isSearching = false;
                                  },
                                  5,
                                  _demandasProvider.indexMenuHorizontal == index
                                      ? Colores.COLOR_PRIMARY
                                      : Colors.black12,
                                  _demandasProvider.indexMenuHorizontal == index
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
                      height: double.infinity,
                      color: Colores.COLOR_GRIS_FONDO,
                      child: _demandasProvider.listDemandasMostrar.isEmpty
                          ? ListView(
                              scrollDirection: Axis.vertical,
                              children: [
                                SizedBox(
                                  height: 200,
                                ),
                                Center(child: AutoSizeText(_demandasProvider.mensajeConsulta)),
                              ],
                            )
                          : ListView.builder(
                              itemCount: _demandasProvider.listDemandasMostrar.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                DemandaModel _demandaActual = _demandasProvider.listDemandasMostrar[index];
                                return WidgetsPersonalizados.cardDemanda(
                                  _demandaActual,
                                  opcionesList: [
                                    _demandaActual.pagar == 0
                                        ? Container()
                                        : WidgetsPersonalizados.iconPerso(
                                            Image(
                                              image: AssetImage("assets/images/whatsapp.png"),
                                              fit: BoxFit.contain,
                                            ),
                                            () async {
                                              if (_demandaActual.telefono!.length == 10) {
                                                print("W 10");
                                                if (await canLaunch(GlobalVariables.URL_WHATSAPP +
                                                    "${_demandaActual.telefono!.substring(1, 10)}")) {
                                                  await launch(
                                                      GlobalVariables.URL_WHATSAPP +
                                                          "${_demandaActual.telefono!.substring(1, 10)}",
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
                                    TextButton(
                                      child: Text("Ver"),
                                      onPressed: () {
                                        AlertPersonalizado.alertOferta(
                                          context: context,
                                          screenSize: screenSize,
                                          editar: false,
                                          oferta: _demandaActual,
                                          callback: () {},
                                        );
                                      },
                                    ),
                                    _demandaActual.pagar == 0
                                        ? Container()
                                        : _demandaActual.isFavorito == 1
                                            ? IconButton(
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.redAccent,
                                                ),
                                                onPressed: () async {
                                                  await _demandasProvider.registrarDemandaFavorita(
                                                    context,
                                                    _demandaActual.idOfertasDemandas!,
                                                    _usuarioLogin.idUsuario!,
                                                    0,
                                                  );
                                                  await _demandasProvider.obtenerCategorias();
                                                  await _demandasProvider.consultarDemandasMisDemandas(
                                                      0, 100, _loginProvider.usuario!.idUsuario!, 0);
                                                },
                                              )
                                            : TextButton(
                                                child: Text("Aplicar"),
                                                onPressed: () async {
                                                  await _demandasProvider.registrarDemandaFavorita(
                                                    context,
                                                    _demandaActual.idOfertasDemandas!,
                                                    _usuarioLogin.idUsuario!,
                                                    1,
                                                  );
                                                  await _demandasProvider.obtenerCategorias();
                                                  await _demandasProvider.consultarDemandasMisDemandas(
                                                      0, 100, _usuarioLogin.idUsuario!, 0);
                                                },
                                              ),
                                    SizedBox(width: 8)
                                  ],
                                );
                              },
                            ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
