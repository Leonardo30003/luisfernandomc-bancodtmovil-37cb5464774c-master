import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'src/pages/splash_screen_page.dart';
import 'src/providers/demandas_provider.dart';
import 'src/providers/drawer_provider.dart';
import 'src/providers/general_provider.dart';
import 'src/providers/login_provider.dart';
import 'src/providers/miembros_provider.dart';
import 'src/providers/ofertas_provider.dart';
import 'src/routes/routes.dart';
import 'src/utils/colores.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => MiembrosProvider()),
        ChangeNotifierProvider(create: (context) => OfertasProvider()),
        ChangeNotifierProvider(create: (context) => DemandasProvider()),
        ChangeNotifierProvider(create: (context) => DrawerProvider()),
        ChangeNotifierProvider(create: (context) => Generalprovider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Banco del Tiempo',
        theme: ThemeData(
          primaryColor: Colores.COLOR_PRIMARY,
          // accentColor: Colores.COLOR_BLANCO,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          iconTheme: const IconThemeData(color: Colores.COLOR_GRIS_HINT), // 1
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colores.COLOR_PRIMARY), // 1
          ),
        ),
        home: Container(),
        initialRoute: SplashScreen.PAGE_ROUTE,
        routes: routes,
      ),
    );
  }
}
