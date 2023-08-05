
import '../../utils/variables_globales.dart';
import '../base_api.dart';
import '../response/miembros_response.dart';

class MiembrosController {
  BaseApi _baseApi = new BaseApi();

  Future<MiembrosResponse> obtenerMiembrosList(int idUser) async {
    Map<String, dynamic> parameters = {
      "idUsuario": "$idUser",
    };

    Map<String, String> headers = {
      "version": "1.0.0",
      "accept": "application/json",
      "content-type": "application/x-www-form-urlencoded",
    };
    try {
      var res = await _baseApi
          .post(GlobalVariables.URL_PRODUCCION + GlobalVariables.OBTENER_MIEMBROS,
              body: parameters, headers: headers)
          .timeout(Duration(seconds: 30), onTimeout: () {
        return MiembrosResponse(
            en: -1, m: "Ocurrió un problema, intente nuevamente más tarde.", miembros: []);
      });
      print("MIEMBROS  >>>>>  " + res.toString());
      MiembrosResponse _responseApi = MiembrosResponse.fromJson(res);
      if (_responseApi != null) {
        if (_responseApi.en == 1) {
          if (_responseApi.miembros != null) {
            return _responseApi;
          }
        } else {
          return MiembrosResponse(en: -1, m: _responseApi.m ?? "", miembros: []);
        }
      } else {
        return MiembrosResponse(
            en: -1, m: "Ocurrió un problema, intente nuevamente más tarde.", miembros: []);
      }
    } catch (onError) {
      print('ERROR : $onError');
    }
    return MiembrosResponse(
        en: -1, m: "Ocurrió un problema, intente nuevamente más tarde.", miembros: []);
  }
}
