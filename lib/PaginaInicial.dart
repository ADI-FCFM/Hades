import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hades/ListadoPuertas.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'Puerta.dart';

Future<String> conseguirToken() async {
  SharedPreferences res = await SharedPreferences.getInstance();
  String token = await res.getString("token");
  return token;
}

Future<List<Puerta>> conseguirPuertas(http.Client client) async {
  String token = await conseguirToken();
  var response =
      await client.get('http://172.17.85.189:8000/puertas?token=$token');
  return compute(parsearPuertas, utf8.decode(response.bodyBytes));
}

List<Puerta> parsearPuertas(String responseBody) {
  var parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Puerta>((json) => Puerta.fromJson(json)).toList();
}

class PaginaInicial extends StatelessWidget {
  @override
  Future<String> conseguirNombre() async {
    SharedPreferences res = await SharedPreferences.getInstance();
    String nombre = await res.getString("nombre");
    return nombre;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: FutureBuilder<String>(
              future: conseguirNombre(),
              builder: (context, respuesta) {
                if (respuesta.hasData) {
                  return Text(respuesta.data);
                }
                return Text("");
              })),
      body: FutureBuilder<List<Puerta>>(
        future: conseguirPuertas(http.Client()),
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
