import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hades/Acceso.dart';
import 'package:hades/ejemplos/ListadoAccesos.dart';

class DetalleAcceso extends StatelessWidget {
  Acceso acceso;

  DetalleAcceso({Key key, @required this.acceso}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.red,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text("${acceso.ubicacion}"),
            ),
            body: Column(children: <Widget>[
              Text(
                "${acceso.descripcion}",
                textAlign: TextAlign.center,
              ),
              Text(
                "${acceso.ubicacion}",
                textAlign: TextAlign.center,
              ),
              RaisedButton(
                  child: new Text("abrir"),
                  onPressed: () async {
                    abrir(acceso.id);
                  })
            ])));
  }
}
