import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../models/usuario_model.dart';
import '../../providers/demandas_provider.dart';
import '../../providers/general_provider.dart';
import '../../providers/login_provider.dart';
import '../../providers/miembros_provider.dart';
import '../../providers/ofertas_provider.dart';
import '../../utils/colores.dart';
import '../../widgets/widgets_personalizados.dart';
import '../crear_ofertademanda_page.dart';
import 'misdemandas_page.dart';
import 'misofertas_page.dart';

class MisOfertasDemandasPage extends StatefulWidget {
  const MisOfertasDemandasPage({Key? key}) : super(key: key);
  static const PAGE_ROUTE = "transaccionespage";

  @override
  _MisOfertasDemandasPageState createState() => _MisOfertasDemandasPageState();
}

class _MisOfertasDemandasPageState extends State<MisOfertasDemandasPage> {
  late Generalprovider _generalprovider;
  late LoginProvider _loginProvider;
  late MiembrosProvider _miembrosProvider;
  late OfertasProvider _ofertasProvider;
  late DemandasProvider _demandasProvider;
  UsuarioModel _usuarioLogin = UsuarioModel();

  //Lista de paginas de navegacion
  final List _pageList = [MisOfertas(), MisDemandas()];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _generalprovider = Provider.of<Generalprovider>(context, listen: false);
    _loginProvider = Provider.of<LoginProvider>(context, listen: false);
    _miembrosProvider = Provider.of<MiembrosProvider>(context, listen: false);
    _ofertasProvider = Provider.of<OfertasProvider>(context, listen: false);
    _demandasProvider = Provider.of<DemandasProvider>(context, listen: false);
    _usuarioLogin = _loginProvider.usuario!;
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await _ofertasProvider.consultarOfertasMisOfertas(0, 50, _usuarioLogin.idUsuario!, 1);
      await _demandasProvider.consultarDemandasMisDemandas(0, 50, _usuarioLogin.idUsuario!, 1);
      // _generalprovider.currentIndexMisOD = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    _generalprovider = Provider.of<Generalprovider>(context);
    return Scaffold(
      appBar: WidgetsPersonalizados.appBarNormalOption(
        title: _generalprovider.textMisOD,
        elevation: 1.0,
        mostrarBackButton: true,
        optionsList: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, CrearOfertaDemandaPage.PAGE_ROUTE);
            },
          ),
          Container(
            width: 10.0,
          )
        ],
        callBackButton: () async {
          print("ONTAP BACK");
          await _miembrosProvider.consultarMiembrosList(_usuarioLogin.idUsuario!);
          _ofertasProvider.obtenerCategorias();
          _ofertasProvider.consultarOfertasMisOfertas(0, 100, _usuarioLogin.idUsuario!, 0);
          _demandasProvider.obtenerCategorias();
          _demandasProvider.consultarDemandasMisDemandas(0, 100, _usuarioLogin.idUsuario!, 0);
          Navigator.pop(context);
        },
      ),
      body: this._pageList[_generalprovider.currentIndexMisOD],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _generalprovider.currentIndexMisOD,
          onTap: (int index) {
            _generalprovider.currentIndexMisOD = index;
            if (index == 0) {
              _generalprovider.textMisOD = "Mis Ofertas";

            } else {
              _generalprovider.textMisOD = "Mis Demandas";
            }
          },
          iconSize: 25.0,
          fixedColor: Colores.COLOR_PRIMARY,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.event_note_outlined), label: 'Mis Ofertas'),

            BottomNavigationBarItem(icon: Icon(Icons.speaker_notes_rounded), label: 'Mis Demandas'),
          ]),
    );
  }

}
