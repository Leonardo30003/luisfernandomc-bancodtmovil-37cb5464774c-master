import '../../utils/variables_globales.dart';
import '../base_api.dart';
import '../response/categorias_response.dart';
import '../response/demanda_response.dart';
import '../response/general_response.dart';

class DemandasController {
  BaseApi _baseApi = new BaseApi();

  // misDemandas 0 = todas las demandas, 1 = mis demandas
  Future<DemandaResponse> obtenerDemandasList(
      int desde, int cuantos, int idUser, int misDemandas) async {
    Map<String, dynamic> parameters = {
      "desde": "$desde",
      "cuantos": "$cuantos",
      "idUsuario": "$idUser",
      "misDemandas": "$misDemandas",
    };

    Map<String, String> headers = {
      "version": "1.0.0",
      "accept": "application/json",
      "content-type": "application/x-www-form-urlencoded",
    };
    try {
      var res = await _baseApi
          .post(GlobalVariables.URL_PRODUCCION + GlobalVariables.LISTA_DEMANDAS,
              body: parameters, headers: headers)
          .timeout(Duration(seconds: 30), onTimeout: () {
        return DemandaResponse(
            en: -1, m: "Ocurrió un problema, intente nuevamente más tarde.", listDemandas: []);
      });
      print("DEMANDAS  >>>>>  " + parameters.toString());
      print("DEMANDAS  >>>>>  " + res.toString());
      DemandaResponse _responseApi = DemandaResponse.fromJson(res);
      if (_responseApi != null) {
        if (_responseApi.en == 1) {
          if (_responseApi.listDemandas != null) {
            return _responseApi;
          }
        } else {
          return DemandaResponse(en: -1, m: _responseApi.m ?? "", listDemandas: []);
        }
      } else {
        return DemandaResponse(
            en: -1, m: "Ocurrió un problema, intente nuevamente más tarde.", listDemandas: []);
      }
    } catch (onError) {
      print('ERROR : $onError');
    }
    return DemandaResponse(
        en: -1, m: "Ocurrió un problema, intente nuevamente más tarde.", listDemandas: []);
  }

  Future<ResponseCategorias> obtenerCategorias() async {
    Map<String, dynamic> parameters = {
      "usuario": "",
    };

    Map<String, String> headers = {
      "version": "1.0.0",
      "accept": "application/json",
      "content-type": "application/x-www-form-urlencoded",
    };
    //print("obtenerInfoBus>>>>>> " + GlobalVariables.GENERAL_BUS + GlobalVariables.BUS_INFORMACION_URL_POST_PROD);
    try {
      var res = await _baseApi
          .post(GlobalVariables.URL_PRODUCCION + GlobalVariables.CATEGORIAS_DEMANDAS,
          body: parameters, headers: headers)
          .timeout(Duration(seconds: 30), onTimeout: () {
        return ResponseCategorias(
            en: -1, m: "Ocurrió un problema, intente nuevamente más tarde.", listCategorias: []);
      });
      print("INFO_CATEGORIAS  >>>>>2 " + res.toString());
      ResponseCategorias _responseCategorias = ResponseCategorias.fromJson(res);
      if (_responseCategorias != null) {
        if (_responseCategorias.en == 1) {
          if (_responseCategorias.listCategorias != null) {
            return _responseCategorias;
          }
        } else {
          return ResponseCategorias(en: -1, m: _responseCategorias.m ?? "", listCategorias: []);
        }
      } else {
        return ResponseCategorias(
            en: -1, m: "Ocurrió un problema, intente nuevamente más tarde.", listCategorias: []);
      }
    } catch (onError) {
      print('ERROR : $onError');
    }
    return ResponseCategorias(
        en: -1, m: "Ocurrió un problema, intente nuevamente más tarde.", listCategorias: []);
  }

  //
  Future<ResponseGeneral> registrarDemanda(
      String titulo, String descripcion, int idcategoria, int idUsuario) async {
    Map<String, dynamic> parameters = {
      "descripcionActividad": descripcion,
      "idCategoria": "$idcategoria",
      "idUsuario": "$idUsuario",
      "titulo": titulo,
    };

    Map<String, String> headers = {
      "version": "1.0.0",
      "accept": "application/json",
      "content-type": "application/x-www-form-urlencoded",
    };
    try {
      var res = await _baseApi
          .post(GlobalVariables.URL_PRODUCCION + GlobalVariables.REGISTRAR_DEMANDA,
              body: parameters, headers: headers)
          .timeout(Duration(seconds: 30), onTimeout: () {
        return ResponseGeneral(error: 1, m: "Ocurrió un problema, intente nuevamente más tarde.");
      });
      ResponseGeneral responseGeneral = ResponseGeneral.fromJson(res);
      if (responseGeneral != null) {
        return responseGeneral;
      } else {
        return ResponseGeneral(error: 1, m: "Ocurrió un problema, intente nuevamente más tarde.");
      }
    } catch (onError) {
      print('ERROR : $onError');
      return ResponseGeneral(error: 1, m: "Ocurrió un problema, intente nuevamente más tarde.");
    }
  }
  //
  // // estado 0 desabilitado, 1 visible
  Future<ResponseGeneral> editarDemanda(
      int estado, String titulo, String descripcion, int idcategoria, int idofertademanda) async {
    Map<String, dynamic> parameters = {
      "estado": "$estado",
      "descripcionActividad": "$descripcion",
      "idCategoria": "$idcategoria",
      "idOfertasDemandas": "$idofertademanda",
      "titulo": "$titulo",
    };

    Map<String, String> headers = {
      "version": "1.0.0",
      "accept": "application/json",
      "content-type": "application/x-www-form-urlencoded",
    };
    try {
      var res = await _baseApi
          .post(GlobalVariables.URL_PRODUCCION + GlobalVariables.EDITAR_DEMANDA,
              body: parameters, headers: headers)
          .timeout(Duration(seconds: 30), onTimeout: () {
        return ResponseGeneral(error: 1, m: "Ocurrió un problema, intente nuevamente más tarde.");
      });
      print("DEMANDA_EDIT  " + res.toString());
      ResponseGeneral responseGeneral = ResponseGeneral.fromJson(res);
      if (responseGeneral != null) {
        return responseGeneral;
      } else {
        return ResponseGeneral(error: 1, m: "Ocurrió un problema, intente nuevamente más tarde.");
      }
    } catch (onError) {
      print('ERROR : $onError');
      return ResponseGeneral(error: 1, m: "Ocurrió un problema, intente nuevamente más tarde.");
    }
  }
  //
  Future<ResponseGeneral> registrarDemandaFavorita(
      int idOfertaDemanda, int idUser, int estado) async {
    Map<String, dynamic> parameters = {
      "idOfertaDemanda": "$idOfertaDemanda",
      "idUsuario": "$idUser",
      "estado": "$estado",
    };

    Map<String, String> headers = {
      "version": "1.0.0",
      "accept": "application/json",
      "content-type": "application/x-www-form-urlencoded",
    };
    try {
      var res = await _baseApi
          .post(GlobalVariables.URL_PRODUCCION + GlobalVariables.REG_FAVORITO_DEMANDA,
              body: parameters, headers: headers)
          .timeout(Duration(seconds: 30), onTimeout: () {
        return ResponseGeneral(en: -1, m: "Ocurrió un problema, intente nuevamente más tarde.");
      });
      print("FAVORITOS DEMANDA >>>>>  " + res.toString());
      ResponseGeneral _responseApi = ResponseGeneral.fromJson(res);
      if (_responseApi != null) {
        if (_responseApi.en == 1) {
          return _responseApi;
        } else {
          return ResponseGeneral(en: -1, m: _responseApi.m ?? "");
        }
      } else {
        return ResponseGeneral(en: -1, m: "Ocurrió un problema, intente nuevamente más tarde.");
      }
    } catch (onError) {
      print('ERROR : $onError');
      return ResponseGeneral(en: -1, m: "Ocurrió un problema, intente nuevamente más tarde.");
    }
  }

  Future<ResponseGeneral> eliminarPostulanteDemanda(
      int idOfertaDemanda) async {
    Map<String, dynamic> parameters = {
      "idOfertaDemanda": "$idOfertaDemanda",
    };

    Map<String, String> headers = {
      "version": "1.0.0",
      "accept": "application/json",
      "content-type": "application/x-www-form-urlencoded",
    };
    try {
      var res = await _baseApi
          .post(GlobalVariables.URL_PRODUCCION + GlobalVariables.ELIMINAR_APLICADO,
          body: parameters, headers: headers)
          .timeout(Duration(seconds: 30), onTimeout: () {
        return ResponseGeneral(en: -1, m: "Ocurrió un problema, intente nuevamente más tarde.");
      });
      print("FAVORITOS DEMANDA >>>>>  " + res.toString());
      ResponseGeneral _responseApi = ResponseGeneral.fromJson(res);
      if (_responseApi != null) {
        if (_responseApi.en == 1) {
          return _responseApi;
        } else {
          return ResponseGeneral(en: -1, m: _responseApi.m ?? "");
        }
      } else {
        return ResponseGeneral(en: -1, m: "Ocurrió un problema, intente nuevamente más tarde.");
      }
    } catch (onError) {
      print('ERROR : $onError');
      return ResponseGeneral(en: -1, m: "Ocurrió un problema, intente nuevamente más tarde.");
    }
  }
}
