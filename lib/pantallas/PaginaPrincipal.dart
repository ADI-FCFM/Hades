import 'package:flutter/material.dart';
import 'package:hades/Acceso.dart';
import 'package:hades/utilidades/usuario.dart';
import 'package:hades/utilidades/accesos.dart';
import 'package:hades/utilidades/utilidadesGenerales.dart';
import 'package:hades/variables.dart';
import 'package:hades/pantallas/ListadoAccesos.dart';

class PaginaInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.power_settings_new),
                tooltip: 'Cerrar sesión',
                onPressed: () {
                  salirAplicacion(context);
                }),
          ],
          title: FutureBuilder<String>(
              future: conseguirNombreAlmacenadoUsuario(),
              builder: (context, respuesta) {
                if (respuesta.hasData) {
                  return Text(respuesta.data);
                }
                return Text(tituloAplicacion);
              })
      ),
      body: FutureBuilder<List<Acceso>>(
        future: conseguirAccesos(context),
        builder: (context, respuesta) {
          if (respuesta.hasData) {
            return ListadoAccesos(accesos: respuesta.data);
          }
          if (respuesta.hasError) {
            return Text('');
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
