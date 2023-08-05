import '../../utils/variables_globales.dart';
import '../base_api.dart';
import '../response/categorias_response.dart';

class GeneralController {
  final BaseApi _baseApi = BaseApi();

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
          .post(GlobalVariables.URL_PRODUCCION + GlobalVariables.CATEGORIAS_TODAS, body: parameters, headers: headers)
          .timeout(const Duration(seconds: 30), onTimeout: () {
        return ResponseCategorias(en: -1, m: "Ocurrió un problema, intente nuevamente más tarde.", listCategorias: []);
      });
      print("INFO_TODAS_CATEGORIAS  >>>>>2 " + res.toString());
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
        return ResponseCategorias(en: -1, m: "Ocurrió un problema, intente nuevamente más tarde.", listCategorias: []);
      }
    } catch (onError) {
      print('ERROR : $onError');
    }
    return ResponseCategorias(en: -1, m: "Ocurrió un problema, intente nuevamente más tarde.", listCategorias: []);
  }
}
