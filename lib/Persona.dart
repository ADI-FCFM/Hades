import 'package:shared_preferences/shared_preferences.dart';

class Persona{
  int rut;
  String nombres;
  String apellidos;
  Persona({
    this.rut,
    this.nombres,
    this.apellidos
  });
  factory Persona.fromJSON(Map<String, dynamic> json){
    return Persona(
        rut: json['rut'],
        nombres: json['nombres'],
        apellidos: json['apellidos']
    );
  }
  String conseguirNombreCompleto() => this.nombres +" "+ this.apellidos;
  void save() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String nombre= this.conseguirNombreCompleto();
    prefs.setString('nombre', nombre);
  }
}
