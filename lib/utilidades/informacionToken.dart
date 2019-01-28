import 'dart:convert';

import 'package:hades/InformacionToken.dart';
import 'package:hades/utilidades/utilidadesGenerales.dart';
import 'package:hades/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> conseguirTokenAlmacenado() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("token");
  return token;
}

Future<bool> verificarFechaExpiracionToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String fecha = prefs.getString("fecha_expiracion");
  if (fecha != null && fecha.isNotEmpty) {
    return DateTime.parse(fecha).isAfter(DateTime.now());
  }
  return false;
}

Future<bool> refrescarToken(url) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("token");
  String refreshToken = prefs.getString("refresh_token");
  var parametrosConsulta = {
    "token": token,
    "refresh_token": refreshToken,
  };
  var respuesta = await metodoPost(url, parametrosConsulta);
  if (respuesta.statusCode == 200) {
    Map<String, dynamic> jsonRespuesta =
        json.decode(utf8.decode(respuesta.bodyBytes));
    InformacionToken informacionToken =
    InformacionToken.convertirJson(jsonRespuesta);
    informacionToken.guardarInformacionToken();
    return true;
  } else {
    return false;
  }
}

/// invalida el token en Aqueronte
void invalidarToken(String token) async {
  await metodoPost(urlCerrarSesion, {"token": token});
}
