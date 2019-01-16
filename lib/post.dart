import 'dart:async';
import 'dart:convert';

import 'package:hades/TokenData.dart';
import 'package:http/http.dart' as http;

import 'PostInicioSesion.dart';

Future<bool> getToken(String ticket, String url) async {
  Map<String, String> headers = {
    "Content-Type": "application/json ; charset=utf-8",
  };
  String body = json.encode({"ticket": ticket});
  final respuesta = await http.post(url, body: body, headers: headers);
  print('Estatus: ${respuesta.statusCode}');
  print('Respuesta: ${respuesta.body}');
  if (respuesta.statusCode == 200) {
    Map<String, dynamic> responseJson =
        json.decode(utf8.decode(respuesta.bodyBytes));
    print(responseJson);
    PostInicioSesion post = PostInicioSesion.fromJson(responseJson);
    TokenData tokenData = post.tokenData;
    tokenData.save();
    print('token guardado');
    post.persona.save();
    print("nombre guardado");
    return true;
  } else {
    throw Exception('Falló post');
  }
}
