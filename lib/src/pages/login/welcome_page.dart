import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../utils/colores.dart';
import '../../widgets/widgets_personalizados.dart';
import 'login_page.dart';

class WelcomePage extends StatelessWidget {
  static const PAGE_ROUTE = "welcomepage";
  double screenWidth = 0.0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colores.COLOR_GRIS_FONDO,
          ),
          SafeArea(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              padding: EdgeInsets.only(right: 30.0, left: 30.0, bottom: 50.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 40.0,
                  ),
                  AutoSizeText("Bienvenidos",
                      style: WidgetsPersonalizados.styleText.copyWith(color: Colores.COLOR_PRIMARY, fontSize: 60), maxLines: 1),
                  Container(
                    height: 10.0,
                  ),
                  AutoSizeText("Encuentra muchas ofertas de interés común que puedes aprovechar con tu tiempo",
                      style: WidgetsPersonalizados.styleText
                          .copyWith(fontSize: 26, fontWeight: FontWeight.normal, color: Colores.COLOR_PRIMARY),
                      maxLines: 2),
                  Container(
                    height: 40.0,
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              child: Image.asset('assets/images/splash_banco.png', height: 500.0,width: 500.0, color: Colores.COLOR_PRIMARY),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: EdgeInsets.only(right: 30.0, bottom: 30.0),
              child: WidgetsPersonalizados.actionRaisedButtonWidget(
                context: context,
                title: Icon(Icons.arrow_forward_rounded, color: Colores.COLOR_BLANCO, size: 30.0),
                color: Colores.COLOR_PRIMARY,
                textColor: Colores.COLOR_BLANCO,
                borderColor: Colores.COLOR_PRIMARY,
                screenWidth: screenWidth,
                callBack: () {
                  Navigator.pushReplacementNamed(context, LoginPage.PAGE_ROUTE);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
