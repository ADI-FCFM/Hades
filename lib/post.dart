import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Post> fetchPost() async {
  Map<String, String> headers = {
    "Content-Type": "application/json",
  };

  String body =json.encode(
      {"ticket":"holaholaholaadi2019"}
  );
  /*
  * var client = new http.Client();
    client.post(
        "http://172.17.85.189:8000/",
        body:  {"ticket":"holaholaholaadi2019"})
        .then((response) => print(response.body))
        .whenComplete(client.close);
  * */
  final response =
  await http.post('http://172.17.85.189:8000/', body:body, headers: headers);
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
class Post{
  UserData userData;
  TokenData tokenData;
  Post({
    this.userData,
    this.tokenData
  });
  factory Post.fromJson(Map<String, dynamic> parsedJson){
    return Post(
      userData: UserData.fromJson(parsedJson['user_data']),
      tokenData: TokenData.fromJSON(parsedJson['token_data'])
    );
  }
}
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
}

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
}

void main() => runApp(MyApp(post: fetchPost()));

class MyApp extends StatelessWidget {
  final Future<Post> post;

  MyApp({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Post>(
            future: post,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.tokenData.token);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
