import 'package:hades/Persona.dart';
import 'package:hades/TokenData.dart';

class PostInicioSesion {
  TokenData tokenData;
  Persona persona;

  PostInicioSesion({this.persona, this.tokenData});

  factory PostInicioSesion.fromJson(Map<String, dynamic> parsedJson) {
    return PostInicioSesion(
        persona: Persona.fromJson(parsedJson['user_data']),
        tokenData: TokenData.fromJson(parsedJson['token_data']));
  }
}
