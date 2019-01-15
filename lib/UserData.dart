import 'package:hades/Persona.dart';

class UserData {
  String ticket;
  bool valid;
  Persona info;

  UserData({this.ticket, this.valid, this.info});

  factory UserData.fromJson(Map<String, dynamic> parsedJson) {
    return UserData(
        ticket: parsedJson['ticket'],
        valid: parsedJson['valid'],
        info: Persona.fromJSON(parsedJson['info'])
    );
  }
}
