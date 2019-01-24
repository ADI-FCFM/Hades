import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'informacionToken.dart';
/// recibe la url y un json con los parametros a consultar por get {"parametro1": "value", "parametro2": "value"}
Future<http.Response> metodoGet(url, parametrosConsulta) async {
  var uri = Uri.parse(url);
  uri = uri.replace(queryParameters: parametrosConsulta);
  http.Response respuesta = await http.get(uri);
  return respuesta;
}

/// recibe la url y un json con los parametros a consultar por post {"parametro1": "value", "parametro2": "value"
Future<http.Response> metodoPost(url, parametrosConsulta) async {
  Map<String, String> headers = {
    "Content-Type": "application/json ; charset=utf-8",
  };
  var body = json.encode(parametrosConsulta);
  http.Response respuesta = await http.post(url, headers: headers, body: body);
  return respuesta;
}

/// muestra una alerta
void alertaError(context, mensajeError, tituloError) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text(tituloError),
        content: new Text(mensajeError),
        actions: <Widget>[
          new FlatButton(
            child: new Text("Cerrar"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

lanzarURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'No se pudo lanzar $url';
  }
}

///cierra sesión en la aplicación
void salirAplicacion(context) async {
  String token = await conseguirTokenAlmacenado();
  if (token != null) {
    invalidarToken(token);
  }
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('token');
  prefs.remove('refresh_token');
  prefs.remove('fecha_expiracion');
  Navigator.of(context).pushNamedAndRemoveUntil('/', (_) => false);
}
