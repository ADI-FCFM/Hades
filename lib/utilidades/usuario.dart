import 'package:shared_preferences/shared_preferences.dart';
/// Consigue el nombre que se almacenó al llamar a la función _conseguirTokenConTicket en la PaginaInicioSesion
Future<String> conseguirNombreAlmacenadoUsuario() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String nombre = prefs.getString("nombre");
  return nombre;
}
