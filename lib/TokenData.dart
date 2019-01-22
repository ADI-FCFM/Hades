import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hades/PaginaInicial.dart';
import 'package:hades/variables.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> verificarFechaExpiracion() async {
  SharedPreferences res = await SharedPreferences.getInstance();
  String fecha = res.getString("fecha_expiracion");
  if (fecha != null && fecha.isNotEmpty) {
    return DateTime.parse(fecha).isAfter(DateTime.now());
  }
  return false;
}

//refrescar_token
Future<bool> refrescarToken(url) async {
  SharedPreferences res = await SharedPreferences.getInstance();
  String token = res.getString("token");
  String refreshToken = res.getString("refresh_token");
  Map<String, String> headers = {
    "Content-Type": "application/json ; charset=utf-8",
  };
  String body = json.encode({
    "token": token,
    "refresh_token": refreshToken,
  });
  var respuesta = await http.post(url, body: body, headers: headers);
  if (respuesta.statusCode == 200) {
    Map<String, dynamic> responseJson =
        json.decode(utf8.decode(respuesta.bodyBytes));
    TokenData tokenData = TokenData.fromJson(responseJson);
    tokenData.save();
    return true;
  } else {
    return false;
  }
}

class TokenData {
  String token;
  String refreshToken;
  String fechaExpiracion;

  TokenData({this.token, this.refreshToken, this.fechaExpiracion});

  factory TokenData.fromJson(Map<String, dynamic> json) {
    return TokenData(
        token: json['token'],
        refreshToken: json['refresh_token'],
        fechaExpiracion: json['fecha_exp']);
  }

  void save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', this.token);
    prefs.setString('refresh_token', this.refreshToken);
    prefs.setString('fecha_expiracion', this.fechaExpiracion);
  }
}

void invalidarToken(String token) async {
  Map<String, String> headers = {
    "Content-Type": "application/json ; charset=utf-8",
  };
  String body = json.encode({"token": token});
  final respuesta =
      await http.post(urlCerrarSesion, body: body, headers: headers);
  print('Estatus: ${respuesta.statusCode}');
  print('Respuesta: ${respuesta.body}');
}

void salirAplicacion(context) async {
  String token = await conseguirToken();
  if (token != null) {
    invalidarToken(token);
  }
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('token');
  prefs.remove('refresh_token');
  prefs.remove('fecha_expiracion');
  Navigator.of(context).pushNamedAndRemoveUntil('/', (_) => false);
}
