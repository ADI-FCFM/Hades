import 'package:hades/TokenData.dart';
import 'package:hades/UserData.dart';

class PostInicioSesion{
  UserData userData;
  TokenData tokenData;
  PostInicioSesion({
    this.userData,
    this.tokenData
  });
  factory PostInicioSesion.fromJson(Map<String, dynamic> parsedJson){
    return PostInicioSesion(
        userData: UserData.fromJson(parsedJson['user_data']),
        tokenData: TokenData.fromJSON(parsedJson['token_data'])
    );
  }
}