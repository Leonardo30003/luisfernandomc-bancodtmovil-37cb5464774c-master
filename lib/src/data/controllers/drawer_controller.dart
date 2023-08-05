import '../../utils/variables_globales.dart';
import '../base_api.dart';
import '../response/buscar_usuario_response.dart';
import '../response/general_response.dart';
import '../response/transacciones_response.dart';

class DrawerControllerA {
  BaseApi _baseApi = new BaseApi();

  //Recursos para las transacciones de horas
  Future<BuscarUsuarioResponse> buscarUsuario(String celular, int idUsuario) async {
    Map<String, dynamic> parameters = {
      "celular": celular,
      "idUsuario": "$idUsuario",
    };

    Map<String, String> headers = {
      "version": "1.0.0",
      "accept": "application/json",
      "content-type": "application/x-www-form-urlencoded",
    };
    //print("obtenerInfoBus>>>>>> " + GlobalVariables.GENERAL_BUS + GlobalVariables.BUS_INFORMACION_URL_POST_PROD);
    try {
      var res = await _baseApi
          .post(GlobalVariables.URL_PRODUCCION + GlobalVariables.BUSCAR_USUARIO, body: parameters, headers: headers)
          .timeout(Duration(seconds: 30), onTimeout: () {
        return BuscarUsuarioResponse(en: -1, m: "Ocurrió un problema, intente nuevamente más tarde.", usuario: null);
      });
      print("USUARIO CELULAR   >>>>>  " + res.toString());
      BuscarUsuarioResponse buscarUsuarioResponse = BuscarUsuarioResponse.fromJson(res);
      if (buscarUsuarioResponse != null) {
        if (buscarUsuarioResponse.en == 1) {
          if (buscarUsuarioResponse.usuario != null) {
            //cliente+token
            return buscarUsuarioResponse;
          } else {
            return BuscarUsuarioResponse(en: -1, m: buscarUsuarioResponse.m ?? "", usuario: null);
          }
        } else {
          return BuscarUsuarioResponse(en: -1, m: buscarUsuarioResponse.m ?? "", usuario: null);
        }
      } else {
        return BuscarUsuarioResponse(en: -1, m: "Ocurrió un problema, intente nuevamente más tarde.", usuario: null);
      }
    } catch (onError) {
      print('ERROR : $onError');
      return BuscarUsuarioResponse(en: -1, m: "Ocurrió un problema, intente nuevamente más tarde.", usuario: null);
    }
  }

  Future<ResponseGeneral> transferirHoras(
      {required int idUsuarioPaga,
      required int idUsuarioRecibe,
      required String detalle,
      required double valoracion,
      required int monto}) async {
    Map<String, dynamic> parameters = {
      "idUsuarioPaga": "$idUsuarioPaga",
      "idUsuarioRecibe": "$idUsuarioRecibe",
      "detalle": "$detalle",
      "valoracion": "$valoracion",
      "monto": "$monto",
    };

    Map<String, String> headers = {
      "version": "1.0.0",
      "accept": "application/json",
      "content-type": "application/x-www-form-urlencoded",
    };
    //print("obtenerInfoBus>>>>>> " + GlobalVariables.GENERAL_BUS + GlobalVariables.BUS_INFORMACION_URL_POST_PROD);
    try {
      var res = await _baseApi
          .post(GlobalVariables.URL_PRODUCCION + GlobalVariables.TRANSFERIR_TIEMPO, body: parameters, headers: headers)
          .timeout(Duration(seconds: 30), onTimeout: () {
        return ResponseGeneral(en: -1, m: "Ocurrió un problema, intente nuevamente más tarde.");
      });
      print("TRANSFERIR   >>>>>  " + res.toString());
      ResponseGeneral responseApi = ResponseGeneral.fromJson(res);
      if (responseApi != null) {
        if (responseApi.en == 1) {
          return responseApi;
        } else if (responseApi.error == 1) {
          return ResponseGeneral(en: -1, m: responseApi.m ?? "");
        } else {
          return ResponseGeneral(en: -1, m: responseApi.m ?? "");
        }
      } else {
        return ResponseGeneral(en: -1, m: "Ocurrió un problema, intente nuevamente más tarde.");
      }
    } catch (onError) {
      print('ERROR : $onError');
      return ResponseGeneral(en: -1, m: "Ocurrió un problema, intente nuevamente más tarde.");
    }
  }

  Future<TransaccionesResponse> consultarTransacciones(int desde, int cuantos, int idUsuario) async {
    Map<String, dynamic> parameters = {
      "desde": "$desde",
      "cuantos": "$cuantos",
      "idUsuario": "$idUsuario",
    };

    Map<String, String> headers = {
      "version": "1.0.0",
      "accept": "application/json",
      "content-type": "application/x-www-form-urlencoded",
    };
    //print("obtenerInfoBus>>>>>> " + GlobalVariables.GENERAL_BUS + GlobalVariables.BUS_INFORMACION_URL_POST_PROD);
    try {
      var res = await _baseApi
          .post(GlobalVariables.URL_PRODUCCION + GlobalVariables.OBTENER_TRANSACCIONES,
              body: parameters, headers: headers)
          .timeout(Duration(seconds: 30), onTimeout: () {
        return TransaccionesResponse(en: -1, m: "Ocurrió un problema, intente nuevamente más tarde.", lM: null);
      });
      print("LOGIN   >>>>>  " + res.toString());
      TransaccionesResponse transaccionesResponse = TransaccionesResponse.fromJson(res);
      if (transaccionesResponse != null) {
        if (transaccionesResponse.en == 1) {
          if (transaccionesResponse.lM != null) {
            return transaccionesResponse;
          } else {
            return TransaccionesResponse(en: -1, m: transaccionesResponse.m ?? "", lM: null);
          }
        } else {
          return TransaccionesResponse(en: -1, m: transaccionesResponse.m ?? "", lM: null);
        }
      } else {
        return TransaccionesResponse(en: -1, m: "Ocurrió un problema, intente nuevamente más tarde.", lM: null);
      }
    } catch (onError) {
      print('ERROR : $onError');
      return TransaccionesResponse(en: -1, m: "Ocurrió un problema, intente nuevamente más tarde.", lM: null);
    }
  }
}
