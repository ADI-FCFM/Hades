import 'package:shared_preferences/shared_preferences.dart';

class InformacionToken {
  String token;
  String refreshToken;
  String fechaExpiracion;
  /// constructor de la clase InformacionToken
  InformacionToken({this.token, this.refreshToken, this.fechaExpiracion});

  factory InformacionToken.convertirJson(Map<String, dynamic> json) {
    return InformacionToken(
        token: json['token'],
        refreshToken: json['refresh_token'],
        fechaExpiracion: json['fecha_exp']);
  }

  void guardarInformacionToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', this.token);
    prefs.setString('refresh_token', this.refreshToken);
    prefs.setString('fecha_expiracion', this.fechaExpiracion);
  }
}
