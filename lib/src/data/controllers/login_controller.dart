import 'dart:developer';

import '../../utils/variables_globales.dart';
import '../base_api.dart';
import '../response/login_response.dart';

class LoginController {
  BaseApi _baseApi = new BaseApi();

  Future<LoginResponse> logearUsuario(String user, String pass) async {
    Map<String, dynamic> parameters = {
      "usuario": user,
      "clave": pass,
    };

    Map<String, String> headers = {
      "Access-Control-Allow-Origin": "*",
      "version": "1.0.0",
      "accept": "application/json",
      "content-type": "application/x-www-form-urlencoded",
    };
    //print("obtenerInfoBus>>>>>> " + GlobalVariables.GENERAL_BUS + GlobalVariables.BUS_INFORMACION_URL_POST_PROD);
    try {
      log("LOGIN   <<<<  1");
      var res = await _baseApi
          .post(GlobalVariables.URL_PRODUCCION + GlobalVariables.LOGIN_USUARIO, body: parameters, headers: headers)
          // .post(GlobalVariables.URL_PRODUCCION, body: parameters, headers: headers, recurso: GlobalVariables.LOGIN_USUARIO)
          .timeout(const Duration(seconds: 10), onTimeout: () {
        log("LOGIN   <<<<  2");
        log("LLEGA HASTA AQUI ");
        return LoginResponse(en: -1, m: "Ocurrió un problema, intente nuevamente más tarde.", usuario: null);
      });

      log("LOGIN   <<<<  3");

      print("LOGIN   >>>>>  " + res.toString());
      LoginResponse loginResponse = LoginResponse.fromJson(res);
      if (loginResponse != null) {
        if (loginResponse.en == 1) {
          if (loginResponse.usuario != null) {
            //cliente+token
            return loginResponse;
          } else {
            return LoginResponse(en: -1, m: loginResponse.m ?? "", usuario: null);
          }
        } else {
          return LoginResponse(en: -1, m: loginResponse.m ?? "", usuario: null);
        }
      } else {
        return LoginResponse(en: -1, m: "Ocurrió un problema, intente nuevamente más tarde.", usuario: null);
      }
    } catch (onError) {
      print('ERROR :::: $onError');
      return LoginResponse(en: -1, m: "Ocurrió un problema, intente nuevamente más tarde.", usuario: null);
    }
  }
}
