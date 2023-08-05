import '../../utils/variables_globales.dart';
import '../base_api.dart';
import '../response/categorias_response.dart';
import '../response/general_response.dart';
import '../response/ofertas_response.dart';
import '../response/quienesaplicaron_response.dart';

class OfertasCOntroller {
  BaseApi _baseApi = new BaseApi();

  // misOfertas o = todas las ofertas, 1 = mis ofertas
  Future<OfertasResponse> obtenerOfertasList(
      int desde, int cuantos, int idUser, int misOfertas) async {
    Map<String, dynamic> parameters = {
      "desde": "$desde",
      "cuantos": "$cuantos",
      "idUsuario": "$idUser",
      "misOfertas": "$misOfertas",
    };

    Map<String, String> headers = {
      "version": "1.0.0",
      "accept": "application/json",
      "content-type": "application/x-www-form-urlencoded",
    };
    try {
      var res = await _baseApi
          .post(GlobalVariables.URL_PRODUCCION + GlobalVariables.LISTA_OFERTAS,
              body: parameters, headers: headers)
          .timeout(Duration(seconds: 30), onTimeout: () {
        return OfertasResponse(
            en: -1, m: "Ocurrió un problema, intente nuevamente más tarde.", listOfertas: []);
      });
      print("OFERTAS  >>>>>  " + res.toString());
      OfertasResponse _responseApi = OfertasResponse.fromJson(res);
      if (_responseApi != null) {
        if (_responseApi.en == 1) {
          if (_responseApi.listOfertas != null) {
            return _responseApi;
          }
        } else {
          return OfertasResponse(en: -1, m: _responseApi.m ?? "", listOfertas: []);
        }
      } else {
        return OfertasResponse(
            en: -1, m: "Ocurrió un problema, intente nuevamente más tarde.", listOfertas: []);
      }
    } catch (onError) {
      print('ERROR : $onError');
    }
    return OfertasResponse(
        en: -1, m: "Ocurrió un problema, intente nuevamente más tarde.", listOfertas: []);
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
          .post(GlobalVariables.URL_PRODUCCION + GlobalVariables.CATEGORIAS_OFERTAS,
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

  Future<ResponseGeneral> registrarOferta(
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
          .post(GlobalVariables.URL_PRODUCCION + GlobalVariables.REGISTRAR_OFERTA,
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

  // estado 0 desabilitado, 1 visible
  Future<ResponseGeneral> editarOferta(
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
          .post(GlobalVariables.URL_PRODUCCION + GlobalVariables.EDITAR_OFERTA,
              body: parameters, headers: headers)
          .timeout(Duration(seconds: 30), onTimeout: () {
        return ResponseGeneral(error: 1, m: "Ocurrió un problema, intente nuevamente más tarde.");
      });
      print("EDITAR OFERTA >> " + res.toString());
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

  Future<ResponseGeneral> registrarOfertaFavorita(
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
          .post(GlobalVariables.URL_PRODUCCION + GlobalVariables.REGISTRAR_FAVORITO,
              body: parameters, headers: headers)
          .timeout(Duration(seconds: 30), onTimeout: () {
        return ResponseGeneral(en: -1, m: "Ocurrió un problema, intente nuevamente más tarde.");
      });
      print("FAVORITOS  >>>>>  " + res.toString());
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

  Future<QuienesAplicaronResponse> quienesAplicaron(int idOF) async {
    Map<String, dynamic> parameters = {
      "idOfertasDemandas": "$idOF",
    };

    Map<String, String> headers = {
      "version": "1.0.0",
      "accept": "application/json",
      "content-type": "application/x-www-form-urlencoded",
    };
    //print("obtenerInfoBus>>>>>> " + GlobalVariables.GENERAL_BUS + GlobalVariables.BUS_INFORMACION_URL_POST_PROD);
    try {
      var res = await _baseApi
          .post(GlobalVariables.URL_PRODUCCION + GlobalVariables.QUIENES_APLICARON,
          body: parameters, headers: headers)
          .timeout(Duration(seconds: 30), onTimeout: () {
        return ResponseCategorias(
            en: -1, m: "Ocurrió un problema, intente nuevamente más tarde.", listCategorias: []);
      });
      print("APLICARON  >>>>> " + res.toString());
      QuienesAplicaronResponse _responseApi = QuienesAplicaronResponse.fromJson(res);
      if (_responseApi != null) {
        if (_responseApi.en == 1) {
          if (_responseApi.listAplicaron != null) {
            return _responseApi;
          }
        } else {
          return QuienesAplicaronResponse(en: -1, m: _responseApi.m , listAplicaron: []);
        }
      } else {
        return QuienesAplicaronResponse(
            en: -1, m: "Ocurrió un problema, intente nuevamente más tarde.", listAplicaron: []);
      }
    } catch (onError) {
      print('ERROR : $onError');
    }
    return QuienesAplicaronResponse(
        en: -1, m: "Ocurrió un problema, intente nuevamente más tarde.", listAplicaron: []);
  }
}
