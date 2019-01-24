import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hades/Acceso.dart';
import 'package:hades/Utilidades/informacionToken.dart';
import 'package:hades/ejemplos/DetalleAcceso.dart';
import 'package:hades/variables.dart';
import 'package:http/http.dart' as http;

class ListadoAccesos extends StatelessWidget {
  final List<Acceso> accesos;

  ListadoAccesos({Key key, this.accesos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GridView.builder(
          itemBuilder: (context, position) {
            return ListTile(
                title: Text('${accesos[position].descripcion}'),
                subtitle: Text('${accesos[position].ubicacion}'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            DetalleAcceso(acceso: accesos[position]),
                      ));
                });
          },
          itemCount: accesos.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        ),
      ),
    );
  }
}

Future<bool> abrir(int id) async {
  Map<String, String> headers = {
    "Content-Type": "application/json ; charset=utf-8",
  };
  String token;
  String body;
  var respuesta;
  token = await conseguirTokenAlmacenado();
  body = json.encode({"id": id, "token": token});
  respuesta = await http.post(urlAccesos, body: body, headers: headers);
  if (respuesta.statusCode == 403) {
    await refrescarToken(urlRefrescar);
    token = await conseguirTokenAlmacenado();
    body = json.encode({"id": id, "token": token});
    respuesta = await http.post(urlAccesos, body: body, headers: headers);
  }
  if (respuesta.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
