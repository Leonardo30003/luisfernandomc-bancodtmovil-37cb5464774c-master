import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:async';

import 'package:provider/provider.dart';

import '../providers/login_provider.dart';
import '../utils/colores.dart';
import 'home_page.dart';
import 'login/welcome_page.dart';

class SplashScreen extends StatefulWidget {
  static const PAGE_ROUTE = "splashScreen";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _logeado = false;

  @override
  void initState() {
    var _loginProvider = Provider.of<LoginProvider>(context, listen: false);
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _logeado = await _loginProvider.verificarLogeo();
      print("SPLASH LOGEADO >> $_logeado");
      if (_logeado) {
        _loginProvider.usuario = await _loginProvider.obtenerUsuario();
        String _user = await _loginProvider.recuperarUser();
        String _token = await _loginProvider.recuperarToken();
        await _loginProvider.realizarLogeo(context, _user, _token, false);
      }
      startSplashScreen();
    });
    super.initState();
  }

  startSplashScreen() {
    var duration = const Duration(seconds: 5);
    return Timer(duration, () {
      Navigator.pushReplacementNamed(
          context, _logeado ? HomePage.PAGE_ROUTE : WelcomePage.PAGE_ROUTE);
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(builder: (c) => widget.logeado ? Dashboard() : Login()),
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colores.COLOR_SPLASH,
      body: Center(
        child: Image(
          image: AssetImage("assets/images/splash_banco.png"),
        ),
      ),
    );
  }
}
