import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hades/ListadoPuertas.dart';
import 'package:hades/TokenData.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'Puerta.dart';
import 'TokenData.dart';
import 'variables.dart';

Future<String> conseguirToken() async {
  SharedPreferences res = await SharedPreferences.getInstance();
  String token = res.getString("token");
  print(token);
  return token;
}

Future<List<Puerta>> conseguirPuertas(
    http.Client client, BuildContext context) async {
  String token;
  String url;
  var respuesta;
  token = await conseguirToken();
  url = '$urlPuertas$token';
//todo revisar aca que se deberia hacer
  respuesta = await client.get(url);
  if (respuesta.statusCode == 403) {
    await refrescarToken(urlRefrescar);
    token = await conseguirToken();
    url = '$urlPuertas$token';
    respuesta = await client.get(url);
  }
  if (respuesta.statusCode == 200) {
    return compute(parsearPuertas, utf8.decode(respuesta.bodyBytes));
  } else {
    salirAplicacion(context);
  }
}

List<Puerta> parsearPuertas(String responseBody) {
  var parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Puerta>((json) => Puerta.fromJson(json)).toList();
}

class PaginaInicial extends StatelessWidget {
  Future<String> conseguirNombre() async {
    SharedPreferences res = await SharedPreferences.getInstance();
    String nombre = res.getString("nombre");
    return nombre;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.power_settings_new),
                tooltip: 'Cerrar sesión',
                onPressed: () {
                  salirAplicacion(context);
                }),
          ],
          title: FutureBuilder<String>(
              future: conseguirNombre(),
              builder: (context, respuesta) {
                if (respuesta.hasData) {
                  return Text(respuesta.data);
                }
                return Text("");
              })),
      body: FutureBuilder<List<Puerta>>(
        future: conseguirPuertas(http.Client(), context),
        builder: (context, respuesta) {
          if (respuesta.hasData) {
            print(respuesta.data);
            return ListadoPuertas(puertas: respuesta.data);
          } else if (respuesta.hasError) {
            return Text("${respuesta.error}");
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
