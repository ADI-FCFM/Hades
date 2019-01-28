import 'package:hades/InformacionToken.dart';
import 'package:hades/Usuario.dart';

class PostInicioSesion {
  InformacionToken tokenData;
  Usuario persona;

  PostInicioSesion({this.persona, this.tokenData});

  factory PostInicioSesion.convertirJson(Map<String, dynamic> json) {
    return PostInicioSesion(
        //info_usuario
        //info_token
        persona: Usuario.convertirJson(json['user_data']),
        tokenData: InformacionToken.convertirJson(json['token_data']));
  }
}
