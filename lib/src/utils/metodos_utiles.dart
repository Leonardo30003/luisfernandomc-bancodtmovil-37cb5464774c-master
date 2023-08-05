import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:crypto/crypto.dart' as crypto;

class MetodosUtiles {
  static String? validatePruebas(String value) {
    if (value.isEmpty) {
      return "Se requiere ingresar informacion";
    } else if (value.length < 4) {
      return "Debe ingresar un mínimo de 4 caracteres";
    }
    return null;
  }

  static String validatePassword(String value) {
    String patttern = r'(^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$)';
    RegExp regExp = RegExp(patttern);
    if (value.isEmpty) {
      return "Se requiere ingresar una contraseña";
    } else if (value.length < 8) {
      return "La contraseña debe tener un mínimo de 8 caracteres";
    } else if (!regExp.hasMatch(value)) {
      return "La contraseña debe contener al menos una letra mayúscula, una letra minúscula y un número";
    }
    return "";
  }

  static String validateEmail(String value) {
    String pattern =
        r'^(([^&lt;&gt;()[\]\\.,;:\s@\"]+(\.[^&lt;&gt;()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.isEmpty) {
      // return false;
      return "El email es requerido";
    } else if (!regExp.hasMatch(value)) {
      // return false;
      return "Email inválido";
    } else {
      return "";
    }
  }

  static String formatearFecha(String texto) {
    DateTime fecha = DateTime.parse(texto).toLocal();
    String fechaFormato = DateFormat('yyyy-MM-dd HH:mm:ss').format(fecha);
    return fechaFormato;
  }

  // static String encriptarMD5({required cadena}) {
  //   var content = new Utf8Encoder().convert(cadena);
  //   var md5 = crypto.md5;
  //   var digest = md5.convert(content);
  //   return hex.encode(digest.bytes);
  //   // return md5.convert(utf8.encode(cadena)).toString();
  // }

  static String encriptarMD5({required cadena}) {
    return md5.convert(utf8.encode(cadena)).toString();
  }

// static Future<ApkInfo> getInfoApk() async{
//   ApkInfo info = new ApkInfo();
//   PackageInfo packageInfo = await PackageInfo.fromPlatform();
//   info.appName = packageInfo.appName;
//   info.packageName = packageInfo.packageName;
//   info.version = packageInfo.version;
//   info.buildNumber = packageInfo.buildNumber;
// }
}
