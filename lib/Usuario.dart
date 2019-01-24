import 'package:shared_preferences/shared_preferences.dart';

class Usuario {
  String nombres;
  String apellidos;

  Usuario({this.nombres, this.apellidos});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(nombres: json['nombres'], apellidos: json['apellidos']);
  }

  String conseguirNombreCompletoUsuario() => this.nombres + " " + this.apellidos;

  void guardarNombreUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String nombre = this.conseguirNombreCompletoUsuario();
    prefs.setString('nombre', nombre);
  }
}
