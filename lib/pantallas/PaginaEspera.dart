import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hades/variables.dart';

class PaginaEspera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.red),
        home: Builder(
            builder: (context) => Scaffold(
                appBar: AppBar(title: Text(tituloAplicacion)),
                body: Center(child: CircularProgressIndicator()))));
  }
}
