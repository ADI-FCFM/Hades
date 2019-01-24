import 'package:hades/InformacionToken.dart';
import 'package:hades/Usuario.dart';

class PostInicioSesion {
  InformacionToken tokenData;
  Usuario persona;

  PostInicioSesion({this.persona, this.tokenData});

  factory PostInicioSesion.fromJson(Map<String, dynamic> parsedJson) {
    return PostInicioSesion(
        //info_usuario
        //info_token
        persona: Usuario.fromJson(parsedJson['user_data']),
        tokenData: InformacionToken.fromJson(parsedJson['token_data']));
  }
}
