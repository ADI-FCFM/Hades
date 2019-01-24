import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hades/Acceso.dart';
import 'package:hades/variables.dart';
import 'package:http/http.dart' as http;

import 'informacionToken.dart';
import 'utilidadesGenerales.dart';

Future<List<Acceso>> conseguirAccesos(BuildContext context) async {
  String token;
  http.Response respuesta;
  token = await conseguirTokenAlmacenado();
  respuesta = await metodoGet(urlAccesos, {"token": token});
  if (respuesta.statusCode == 403) {
    await refrescarToken(urlRefrescar);
    token = await conseguirTokenAlmacenado();
    respuesta = await metodoGet(urlAccesos, {"token": token});
  }
  if (respuesta.statusCode == 200) {
    return compute(parsearAccesos, utf8.decode(respuesta.bodyBytes));
  } else {
    String tituloError = "Error obtener accesos";
    String mensajeError = "Ocurrió un error al intentar obtener accesos";
    alertaError(context, tituloError, mensajeError);
    throw ('error');
  }
}

List<Acceso> parsearAccesos(String responseBody) {
  var parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Acceso>((json) => Acceso.fromJson(json)).toList();
}

Future<bool> abrirAcceso(int id) async {
  String token;
  http.Response respuesta;
  token = await conseguirTokenAlmacenado();
  respuesta = await metodoPost(urlAccesos, {"id": id, "token": token});
  if (respuesta.statusCode == 403) {
    await refrescarToken(urlRefrescar);
    token = await conseguirTokenAlmacenado();
    respuesta = await metodoPost(urlAccesos, {"id": id, "token": token});
  }
  if (respuesta.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
