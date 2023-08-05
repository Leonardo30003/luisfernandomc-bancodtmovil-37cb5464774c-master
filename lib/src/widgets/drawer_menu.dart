import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/assets.dart';
import '../models/usuario_model.dart';
import '../pages/drawer_pages/misofertasdemandas_page.dart';
import '../pages/drawer_pages/perfil_page.dart';
import '../pages/drawer_pages/transacciones/historial_page.dart';
import '../pages/login/login_page.dart';
import '../providers/demandas_provider.dart';
import '../providers/general_provider.dart';
import '../providers/login_provider.dart';
import '../providers/miembros_provider.dart';
import '../providers/ofertas_provider.dart';
import '../utils/colores.dart';
import '../utils/variables_globales.dart';

class DrawerMenu extends StatelessWidget {
  // DrawerProvider _drawerProvider;
  @override
  Widget build(BuildContext context) {
    Generalprovider _generalProvider = Provider.of<Generalprovider>(context);
    LoginProvider _loginProvider = Provider.of<LoginProvider>(context);
    MiembrosProvider _miembrosProviders = Provider.of<MiembrosProvider>(context);
    OfertasProvider _ofertasProvides = Provider.of<OfertasProvider>(context);
    DemandasProvider _demandasProviders = Provider.of<DemandasProvider>(context);
    TextStyle stileTitle = TextStyle(color: Colores.COLOR_BLANCO, fontSize: 20.0, fontWeight: FontWeight.bold);
    TextStyle stileSubTitle = TextStyle(color: Colores.COLOR_BLANCO, fontSize: 16.0, fontWeight: FontWeight.normal);
    UsuarioModel usuarioModel = _loginProvider.usuario!;
    return Drawer(
      child: Stack(
        children: <Widget>[
          Container(
            height: 200,
            width: double.maxFinite,
            color: Colores.COLOR_VERDE_DESABILITADO,
            // padding: EdgeInsets.only(top: 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 20.0),
                Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: usuarioModel.imagen == ""
                          ? const AssetImage(Assets.imagesPlaceholder) as ImageProvider
                          : NetworkImage(GlobalVariables.URL_IMAGE + usuarioModel.imagen!),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Container(
                    // height: 50.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5.0),
                        AutoSizeText(
                          "${usuarioModel.nombres} ${usuarioModel.apellidos}",
                          style: stileSubTitle,
                          minFontSize: 10.0,
                          overflow: TextOverflow.fade,
                        ),
                        SizedBox(height: 5.0),
                        AutoSizeText(
                          "${usuarioModel.telefono}",
                          style: stileSubTitle,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            // height: MediaQuery.of(context).size.height - 160,
            margin: EdgeInsets.only(top: 150),
            decoration: const BoxDecoration(
              color: Colores.COLOR_GRIS_BORDER,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(7.0), topRight: Radius.circular(7.0)),
              boxShadow: [
                BoxShadow(color: Colors.black26, blurRadius: 1.0, spreadRadius: 0.0, offset: Offset(0.0, -2.0)),
              ],
            ),
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.person, color: Colors.grey, size: 40),
                  title: const Text('Perfil', style: TextStyle(fontSize: 14)),
                  onTap: () async {
                    // infoBusProvider.clear();
                    Navigator.pop(context);
                    String _user = await _loginProvider.recuperarUser();
                    String _token = await _loginProvider.recuperarToken();
                    _loginProvider.realizarLogeo(context, _user, _token, false);
                    Navigator.of(context).pushNamed(PerfilPage.PAGE_ROUTE);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.article_outlined, color: Colors.grey, size: 40),
                  title: const Text('Mis Ofertas-Demandas', style: TextStyle(fontSize: 14)),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed(MisOfertasDemandasPage.PAGE_ROUTE);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.article_outlined,
                    color: Colors.grey,
                    size: 40,
                  ),
                  title: Text(
                    'Transacciones',
                    style: TextStyle(fontSize: 14),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    // Navigator.of(context).pushNamed(TransaccionesPage.PAGE_ROUTE);
                    Navigator.of(context).pushNamed(HistorialPage.PAGE_ROUTE);
                  },
                ),
                // ListTile(
                //   leading: Icon(Icons.help, color: Colors.grey, size: 20),
                //   title: const Text('Ayuda', style: TextStyle(fontSize: 14)),
                //   onTap: () {
                //     // infoBusProvider.clear();
                //     Navigator.pop(context);
                //     // Navigator.of(context).pushNamed(ConsultarDespachosPage.PAGE_ROUTE);
                //   },
                // ),
                // ListTile(
                //   leading: const Icon(Icons.app_blocking_outlined, color: Colors.grey, size: 20),
                //   title: const Text('Acerca de', style: TextStyle(fontSize: 14)),
                //   onTap: () {
                //     // infoBusProvider.clear();
                //     Navigator.pop(context);
                //     // Navigator.of(context).pushNamed(ConsultarDespachosPage.PAGE_ROUTE);
                //   },
                // ),
                ListTile(
                  leading: const Icon(Icons.power_settings_new_outlined, color: Colors.grey, size: 40),
                  title: const Text('Cerrar Sesión', style: TextStyle(fontSize: 14)),
                  onTap: () async {
                    // ProgressDialog progressDialog = ProgressDialog(context);
                    // progressDialog.show("Deslogeando, espere por favor...");
                    await _loginProvider.deslogearApp();
                    await _generalProvider.limpiarProvider();
                    await _miembrosProviders.limpiarProvider();
                    await _ofertasProvides.limpiarProvider();
                    await _demandasProviders.limpiarProvider();
                    // progressDialog.hide();
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, LoginPage.PAGE_ROUTE);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
