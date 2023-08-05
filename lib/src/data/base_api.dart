import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';
// import 'package:device_info/device_info.dart';
import 'package:http/http.dart' as http;

class BaseApi {
  static BaseApi _instance = new BaseApi.internal();

  BaseApi.internal();

  // final _encod = Encoding.getByName('utf-8');


  factory BaseApi() => _instance;

  final JsonDecoder _decoder = new JsonDecoder();

  Future<dynamic> get(String url) {
    return http.get(Uri.parse(url)).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      print(">>>>>>>>>>>>>>><get " + res);
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("ERROR> $res code $statusCode");
      }
      return _decoder.convert(res);
    });
  }

  // Future<dynamic> baseApi(String url, {Map headers, body}) async {
  //   try {
  //     final resp = await http.post(url, headers: headers, body: body).timeout(Duration(seconds: 30));
  //     print('Response >>>> ' + resp.body);
  //     final decodedData = json.decode(resp.body);
  //     return (decodedData);
  //   } on TimeoutException {
  //     print('Tiempo de espera agotado');
  //     return {"en": -1, "m": "Tiempo de espera agotado."};
  //   } on FormatException {
  //     print('Bad response');
  //     rethrow;
  //   } on HttpException {
  //     return {"en": -1, "m": "Sin conexión a Internet."};
  //   } on SocketException {
  //     return {"en": -1, "m": "Sin conexión a Internet."};
  //   } catch (e) {
  //     print(e);
  //     return {"en": -1, "m": "Error de comunicación, vuelva a intentar."};
  //   }
  // }

  Future<dynamic> post(String url, {Map<String, String>? headers, body, recurso}) {
/*    Uri dir;
    if (Platform.isAndroid || Platform.isIOS) {
      print("PLATAFORM  >>>  MOBILE");
      dir = Uri.parse(url);
    } else {
      print("PLATAFORM  >>>  OTROS WEB");
      dir = Uri.https(url, recurso);
    }*/
    // Uri dir = Uri.https(url, recurso);
    Uri dir = Uri.parse(url);
    // return http.post(Uri.parse(url), headers: headers, body: body ).then((http.Response response) {
    return http.post(dir, headers: headers, body: body ).then((http.Response response) {
      // final String res = utf8.decode(response.body.codeUnits);
      // final String res = response.body;
      final String res = const Utf8Decoder().convert(response.bodyBytes);
      final int statusCode = response.statusCode;
      print("PARAMETERS_POST STATUSCODE  >>> " + statusCode.toString());
      // print("PARAMETERS_POST RESPONSEBODY  :::  ${Utf8Decoder().convert(response.bodyBytes)}}" );
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("ERROR> $res code $statusCode");
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> put(String url, {Map<String, String>? headers, body, encoding}) {
    return http.put(Uri.parse(url), body: body, headers: headers, encoding: encoding).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("ERROR> $res code $statusCode");
      }
      return _decoder.convert(res);
    });
  }

  // Future<dynamic> postInfoDevice(String url, {Map headers, body, encoding}) async{
  //   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //   DeviceInfo device = DeviceInfo();
  //   if (Platform.isIOS){
  //     IosDeviceInfo iosDevice = await deviceInfo.iosInfo;
  //     device.idPlataforma = 1;
  //     device.marca = "Apple";
  //     device.modelo = iosDevice.model;
  //     device.sistemaOperativo = iosDevice.systemVersion;
  //   }else{
  //     AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
  //     device.idPlataforma = 2;
  //     device.marca = androidDeviceInfo.manufacturer;
  //     device.modelo = androidDeviceInfo.model;
  //     device.sistemaOperativo = androidDeviceInfo.version.release;
  //   }
  //   var parameters = body;
  //   parameters["idPlataforma"] = device.idPlataforma;
  //   parameters["marca"] = device.marca;
  //   parameters["modelo"] = device.modelo;
  //   parameters["so"] = device.sistemaOperativo;
  //   body = json.encode(parameters);
  //   print("PARAMETERS>>> " + body.toString());
  //
  //   return http
  //       .post(url, headers: headers, body: body,  encoding: encoding)
  //       .then((http.Response response) {
  //     final String res = response.body;
  //     final int statusCode = response.statusCode;
  //     if (statusCode < 200 || statusCode > 400 || json == null) {
  //       throw new Exception("ERROR> $res code $statusCode");
  //     }
  //     return _decoder.convert(res);
  //   }).timeout(Duration(seconds: 30), onTimeout: (){
  //     throw new Exception("ERROR> TimeOut");
  //   }).catchError((onError){
  //     print('ERROR de tipo ${onError.runtimeType} $onError');
  //     if(onError is SocketException){
  //       return {"en": -1, "m": "Sin conexión a Internet"};
  //     }
  //     throw new Exception("Excepción no controladora");
  //   });
  // }

  // Future<dynamic> putInfoDevice(String url, {Map headers, Map<String, dynamic> body, encoding}) async{
  //   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //   DeviceInfo device = DeviceInfo();
  //   if (Platform.isIOS){
  //     IosDeviceInfo iosDevice = await deviceInfo.iosInfo;
  //     device.idPlataforma = 1;
  //     device.marca = "Apple";
  //     device.modelo = iosDevice.model;
  //     device.sistemaOperativo = iosDevice.systemVersion;
  //   }else{
  //     AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
  //     device.idPlataforma = 2;
  //     device.marca = androidDeviceInfo.manufacturer;
  //     device.modelo = androidDeviceInfo.model;
  //     device.sistemaOperativo = androidDeviceInfo.version.release;
  //   }
  //   Map<String, dynamic> parameters = body;
  //   parameters["idPlataforma"] = device.idPlataforma;
  //   parameters["marca"] = device.marca;
  //   parameters["modelo"] = device.modelo;
  //   parameters["so"] = device.sistemaOperativo;
  //   print("PARAMETERS>>> " + body.toString());
  //   return http
  //       .put(url, body: json.encode(body), headers: headers, encoding: encoding)
  //       .then((http.Response response) {
  //     final String res = response.body;
  //     final int statusCode = response.statusCode;
  //
  //     if (statusCode < 200 || statusCode > 400 || json == null) {
  //       throw new Exception("ERROR> $res code $statusCode");
  //     }
  //     return _decoder.convert(res);
  //   });
  // }

  // Future<dynamic> postStatusCode(String url, {Map headers, body, encoding}) async{
  //   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //   DeviceInfo device = DeviceInfo();
  //   if (Platform.isIOS){
  //     IosDeviceInfo iosDevice = await deviceInfo.iosInfo;
  //     device.idPlataforma = 1;
  //     device.marca = iosDevice.identifierForVendor;
  //     device.modelo = iosDevice.model;
  //     device.sistemaOperativo = iosDevice.systemVersion;
  //   }else{
  //     AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
  //     device.idPlataforma = 2;
  //     device.marca = androidDeviceInfo.manufacturer;
  //     device.modelo = androidDeviceInfo.model;
  //     device.sistemaOperativo = androidDeviceInfo.version.release;
  //   }
  //   var parameters = body;
  //   parameters["idPlataforma"] = device.idPlataforma;
  //   parameters["marca"] = device.marca;
  //   parameters["modelo"] = device.modelo;
  //   parameters["so"] = device.sistemaOperativo;
  //   body = json.encode(parameters);
  //   print("PARAMETERS>>> " + body.toString());
  //   return http
  //       .post(url, body: body, headers: headers, encoding: encoding)
  //       .then((http.Response response) {
  //     final res = response.body;
  //     final int statusCode = response.statusCode;
  //     print('status code  >>>>>>>>>>>>> $statusCode');
  //     if (statusCode < 200 || statusCode > 403 || json == null || statusCode == 401 || statusCode == 402) {
  //       throw new Exception("ERROR> $res code $statusCode");
  //     }
  //     Map<String, dynamic> respuesta = _decoder.convert(res);
  //     respuesta["statusCode"] = statusCode;
  //     if(statusCode == 403){
  //       respuesta["en"] = -4;
  //     }
  //     if(statusCode == 320){
  //       respuesta["en"] = -5;
  //     }
  //     return respuesta;
  //   }).timeout(Duration(seconds: 30), onTimeout: (){
  //     throw new Exception("ERROR> TimeOut");
  //   });
  // }

  // Future<dynamic> delete(String url, {Map<String, String>? headers, body}) async {
  //   final client = http.Client();
  //   final request = http.Request("DELETE", Uri.parse(url))..headers.addAll(headers);
  //   request.bodyFields = body;
  //   try {
  //     var response = await client.send(request);
  //     final respStr = await response.stream.bytesToString();
  //     client.close();
  //     return _decoder.convert(respStr);
  //   } catch (e) {
  //     print(e);
  //   } finally {
  //     client.close();
  //   }
  // }
}
