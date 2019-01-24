import 'package:flutter/material.dart';
import 'package:hades/variables.dart';
import 'package:hades/pantallas//PaginaEspera.dart';
import 'package:hades/pantallas//PaginaInicioSesion.dart';
import 'package:hades/pantallas//PaginaPrincipal.dart';

void main() {
  runApp(new MaterialApp(
    theme: ThemeData(primarySwatch: Colors.red),
    title: tituloAplicacion,
    routes: <String, WidgetBuilder>{
      '/': (BuildContext context) => new PaginaInicioSesion(),
      '/paginaPrincipal': (BuildContext context) => new PaginaInicial(),
      '/paginaEspera': (BuildContext context) => new PaginaEspera(),
    },
  ));
}
