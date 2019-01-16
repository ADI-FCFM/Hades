import 'package:shared_preferences/shared_preferences.dart';

class Persona {
  String nombres;
  String apellidos;

  Persona({this.nombres, this.apellidos});

  factory Persona.fromJson(Map<String, dynamic> json) {
    return Persona(nombres: json['nombres'], apellidos: json['apellidos']);
  }

  String conseguirNombreCompleto() => this.nombres + " " + this.apellidos;

  void save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String nombre = this.conseguirNombreCompleto();
    prefs.setString('nombre', nombre);
  }
}
