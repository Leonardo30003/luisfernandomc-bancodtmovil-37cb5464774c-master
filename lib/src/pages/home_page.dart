import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../models/usuario_model.dart';
import '../providers/demandas_provider.dart';
import '../providers/general_provider.dart';
import '../providers/login_provider.dart';
import '../providers/miembros_provider.dart';
import '../providers/ofertas_provider.dart';
import '../utils/colores.dart';
import '../widgets/drawer_menu.dart';
import '../widgets/widgets_personalizados.dart';
import 'demandas_page.dart';
import 'miembros_page.dart';
import 'ofertas_page.dart';

class HomePage extends StatefulWidget {
  static const PAGE_ROUTE = "homepage";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Size screenSize;
  late LoginProvider _loginProvider;
  late Generalprovider _generalprovider;
  late MiembrosProvider _miembrosProvider;
  late OfertasProvider _ofertasProvider;
  late DemandasProvider _demandasProvider;
  UsuarioModel _usuarioLogin = UsuarioModel();

  //Lista de paginas de navegacion
  final List _pageList = [
    MiembrosPage(),
    OfertasPage(),
    DemandasPage(),
  ];

  @override
  void initState() {
    _loginProvider = Provider.of<LoginProvider>(context, listen: false);
    _generalprovider = Provider.of<Generalprovider>(context, listen: false);
    _miembrosProvider = Provider.of<MiembrosProvider>(context, listen: false);
    _ofertasProvider = Provider.of<OfertasProvider>(context, listen: false);
    _demandasProvider = Provider.of<DemandasProvider>(context, listen: false);
    _usuarioLogin = _loginProvider.usuario!;
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _generalprovider.indexNavegador = 0;
      // Consultar informacion de miembros
      await _miembrosProvider.consultarMiembrosList(_usuarioLogin.idUsuario!);
      await _generalprovider.consultarTodasCategorias();
      // Consultar informacion de ofertas
      await _ofertasProvider.obtenerCategorias();
      await _ofertasProvider.consultarOfertasMisOfertas(0, 100, _usuarioLogin.idUsuario!, 0);
      // Consultar informacion de demandas
      await _demandasProvider.obtenerCategorias();
      await _demandasProvider.consultarDemandasMisDemandas(0, 100, _usuarioLogin.idUsuario!, 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    _generalprovider = Provider.of<Generalprovider>(context);
    _miembrosProvider = Provider.of<MiembrosProvider>(context);
    _ofertasProvider = Provider.of<OfertasProvider>(context);
    _demandasProvider = Provider.of<DemandasProvider>(context);
    TextEditingController controllerBusqueda = TextEditingController();//para la busqueda
    return Scaffold(
      appBar: _generalprovider.isSearching
          ? WidgetsPersonalizados.appBarSearching(
              cancelSearch: () {
                _generalprovider.isSearching = false;
                switch (_generalprovider.indexNavegador) {
                  case 0:
                    _miembrosProvider.buscarMiembrosExistentes("", false);
                    break;
                  case 1:
                    _ofertasProvider.buscarOfertasExistente("", false);
                    break;
                  case 2:
                    _demandasProvider.buscarDemandasExistente("", false);
                    break;
                  default:
                }
              },

              searching: () {
                if (controllerBusqueda.text.isEmpty) {
                  WidgetsPersonalizados.mostrarToast(mensaje: "Debe ingresar un criterio de busqueda");
                } else {
                  switch (_generalprovider.indexNavegador) {
                    case 0:
                      _miembrosProvider.buscarMiembrosExistentes(controllerBusqueda.text, true);
                      break;
                    case 1:
                      _ofertasProvider.buscarOfertasExistente(controllerBusqueda.text, true);
                      break;
                    case 2:
                      _demandasProvider.buscarDemandasExistente(controllerBusqueda.text, true);
                      break;
                    default:
                  }
                }
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              searchController: controllerBusqueda,

            )
        : WidgetsPersonalizados.appBarNormalOption(
              title: "Banco del tiempo",
              elevation: 10.0,
              mostrarBackButton: false,
              optionsList: [
                Align(
                  child: Container(
                    //alignment: Alignment.bottomLeft,
                    margin: EdgeInsets.only(right: 600.00),
                    //transformAlignment: AlignmentDirectional.center,
                    child: Image.asset('assets/images/splash_banco.png', color: Colores.COLOR_PRIMARY ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    if (_miembrosProvider.listmiembros.isEmpty ||
                        _ofertasProvider.listOfertas.isEmpty ||
                        _demandasProvider.listDemandas.isEmpty) {
                      _generalprovider.isSearching = false;
                      WidgetsPersonalizados.mostrarToast(mensaje: "No existen elementos para realizar una búsqueda");
                    } else {
                      _generalprovider.isSearching = true;
                    }
                  },
                ),

              ],
              callBackButton: () {},

    ),
      // appBar: WidgetsPersonalizados.appBarNormalOption(
      //   title: "Banco del tiempo",
      //   elevation: 1.0,
      //   mostrarBackButton: false,
      //   optionsList: [
      //     // IconButton(
      //     //     icon: Icon(Icons.search),
      //     //     onPressed: () {
      //     //       _ofertasProvider.isSearching = true;
      //     //     }),
      //   ],
      //   callBackButton: () {},
      // ),
      drawer: DrawerMenu(),//menu
      body: this._pageList[_generalprovider.indexNavegador],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _generalprovider.indexNavegador,
          onTap: (int index) {
            _generalprovider.indexNavegador = index;
          },
          iconSize: 15.0,
          fixedColor: Colores.COLOR_PRIMARY,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.person_search), label: 'Miembros'),
            BottomNavigationBarItem(icon: Icon(Icons.event_note_outlined), label: 'Ofertas'),
            BottomNavigationBarItem(icon: Icon(Icons.speaker_notes_rounded), label: 'Demandas'),
          ]),
    );
  }
}
