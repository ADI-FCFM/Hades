import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hades/PaginaInicial.dart';
import 'package:hades/Puerta.dart';
import 'package:hades/TokenData.dart';
import 'package:http/http.dart' as http;

import 'variables.dart';

class DetallePuerta extends StatelessWidget {
  Puerta puerta;

  DetallePuerta({Key key, @required this.puerta}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.red,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text("${puerta.ubicacion}"),
            ),
            body: Column(children: <Widget>[
              Text(
                "${puerta.descripcion}",
                textAlign: TextAlign.center,
              ),
              Text(
                "${puerta.ubicacion}",
                textAlign: TextAlign.center,
              ),
              RaisedButton(
                  child: new Text("abrir"),
                  onPressed: () async {
                    abrir(puerta.id);
                  })
            ])));
  }
}

Future<bool> abrir(int id) async {
  Map<String, String> headers = {
    "Content-Type": "application/json ; charset=utf-8",
  };
  String token;
  String body;
  var respuesta;
  token = await conseguirToken();
  body = json.encode({"id": id, "token": token});
  respuesta = await http.post(urlPuertas, body: body, headers: headers);
  print('Estatus: ${respuesta.statusCode}');
  print('Respuesta: ${respuesta.body}');
  if (respuesta.statusCode == 403) {
    await refrescarToken(urlRefrescar);
    token = await conseguirToken();
    body = json.encode({"id": id, "token": token});
    respuesta = await http.post(urlPuertas, body: body, headers: headers);
    print('Respuesta1: ${respuesta.body}');
  }
  if (respuesta.statusCode == 200) {
    return true;
  } else {
    print(respuesta.statusCode);
    return false;
  }
}
