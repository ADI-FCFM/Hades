import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hades/Puerta.dart';
import 'package:hades/PaginaInicial.dart';
import 'package:http/http.dart' as http;

class DetallePuerta extends StatelessWidget {
  Puerta puerta;
  DetallePuerta({Key key, @required this.puerta}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.red,
      ),
      home:Scaffold(
        appBar: AppBar(
        title: Text("${puerta.ubicacion}"),
      ),

      body:Column(children: <Widget>
      [
        Text("${puerta.descripcion}", textAlign: TextAlign.center,) ,
        Text("${puerta.ubicacion}", textAlign: TextAlign.center,),
        RaisedButton(
          child: new Text("abrir"),
          onPressed: dummy(puerta.id),
        )
    ]
    )
    ));
  }
}
dummy(int i){
}
 Future <bool>abrir(int id) async {
  Map<String, String> headers = {
    "Content-Type": "application/json ; charset=utf-8",
  };
  String url ='http://172.17.85.218:8000/abrir';
  String token = await conseguirToken();
  String body = json.encode({"id": id, "token": token});
  var respuesta = await http.post(url, body: body, headers: headers);
  print('Estatus: ${respuesta.statusCode}');
  print('Respuesta: ${respuesta.body}');
  if (respuesta.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
