import 'package:hades/InformacionToken.dart';
import 'package:hades/Usuario.dart';

class PostInicioSesion {
  InformacionToken informacionToken;
  Usuario usuario;
  /// constructor de la clase PostInicioSesion
  PostInicioSesion({this.usuario, this.informacionToken});

  factory PostInicioSesion.convertirJson(Map<String, dynamic> json) {
    return PostInicioSesion(
        //info_usuario
        //info_token
        usuario: Usuario.convertirJson(json['user_data']),
        informacionToken: InformacionToken.convertirJson(json['token_data']));
  }
}
