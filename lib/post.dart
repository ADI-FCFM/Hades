import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'PostInicioSesion.dart';

Future<bool> getToken(String ticket, String url) async {
  Map<String, String> headers = {
    "Content-Type": "application/json",
  };
  String body =json.encode(
      {"ticket": ticket}
  );
  final respuesta = await http.post(url, body:body, headers: headers);
  print('Estatus: ${respuesta.statusCode}');
  print('Respuesta: ${respuesta.body}');
  if (respuesta.statusCode == 200) {
    PostInicioSesion post =PostInicioSesion.fromJson(json.decode(respuesta.body));
    post.tokenData.save();
    print('token guardado');
    post.userData.info.save();
    print("nombre guardado");
    bool valid = post.userData.valid;
    return valid;
  } else {
    throw Exception('Falló post');
  }
}