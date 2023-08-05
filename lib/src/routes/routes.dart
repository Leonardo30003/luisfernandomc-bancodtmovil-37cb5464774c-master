import 'package:flutter/material.dart';

import '../pages/crear_ofertademanda_page.dart';
import '../pages/demandas_page.dart';
import '../pages/drawer_pages/misofertas_page.dart';
import '../pages/drawer_pages/misofertasdemandas_page.dart';
import '../pages/drawer_pages/perfil_page.dart';
import '../pages/drawer_pages/transacciones/historial_page.dart';
import '../pages/drawer_pages/transacciones/transferir_horas_page.dart';
import '../pages/home_page.dart';
import '../pages/login/login_page.dart';
import '../pages/login/registro_page.dart';
import '../pages/login/welcome_page.dart';
import '../pages/miembros_page.dart';
import '../pages/ofertas_page.dart';
import '../pages/splash_screen_page.dart';

final routes = <String, WidgetBuilder>{
  SplashScreen.PAGE_ROUTE: (BuildContext context) => SplashScreen(),
  WelcomePage.PAGE_ROUTE: (BuildContext context) => WelcomePage(),
  RegistroPage.PAGE_ROUTE: (BuildContext context) => RegistroPage(),
  LoginPage.PAGE_ROUTE: (BuildContext context) => LoginPage(),
  HomePage.PAGE_ROUTE: (BuildContext context) => HomePage(),

  MisOfertas.PAGE_ROUTE: (BuildContext context) => MisOfertas(),
  HistorialPage.PAGE_ROUTE: (BuildContext context) => HistorialPage(),
  TransferirHorasPage.PAGE_ROUTE: (BuildContext context) => TransferirHorasPage(),
  MisOfertasDemandasPage.PAGE_ROUTE: (BuildContext context) => MisOfertasDemandasPage(),
  PerfilPage.PAGE_ROUTE: (BuildContext context) => PerfilPage(),
  CrearOfertaDemandaPage.PAGE_ROUTE: (BuildContext context) => CrearOfertaDemandaPage(),
  MiembrosPage.PAGE_ROUTE: (BuildContext context) => MiembrosPage(),
  OfertasPage.PAGE_ROUTE: (BuildContext context) => OfertasPage(),
  DemandasPage.PAGE_ROUTE: (BuildContext context) => DemandasPage(),

};
