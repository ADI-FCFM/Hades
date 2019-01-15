import 'package:shared_preferences/shared_preferences.dart';

class TokenData{
  String token;
  String refresh_token;
  String fecha_exp;
  TokenData({this.token, this.refresh_token, this.fecha_exp});
  factory TokenData.fromJSON(Map<String, dynamic> json){
    return TokenData(
        token: json['token'],
        refresh_token: json['refresh_token'],
        fecha_exp: json['fecha_exp']
    );
  }
  void save() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(token, this.token);
    prefs.setString(refresh_token, this.refresh_token);
    prefs.setString(fecha_exp, this.fecha_exp);
  }
}