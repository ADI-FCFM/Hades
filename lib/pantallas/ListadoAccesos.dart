import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hades/Acceso.dart';
import 'package:hades/utilidades/accesos.dart';

class ListadoAccesos extends StatelessWidget {
  final List<Acceso> accesos;

  ListadoAccesos({Key key, this.accesos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GridView.builder(
          itemBuilder: (context, position) {
            return ListTile(
                title: Text('${accesos[position].descripcion}'),
                subtitle: Text('${accesos[position].ubicacion}'),
                onTap: () async {
                  bool sePuedeAbrir = await abrirAcceso(accesos[position].id);
                  var snackbar;
                  Color color;
                  if (sePuedeAbrir) {
                    color = Colors.green.shade400;
                    snackbar = SnackBar(
                        content: Text('Acceso concedido!'),
                        backgroundColor: color,
                        duration: Duration(seconds: 1));
                  } else {
                    Color color = Colors.red.shade400;
                    snackbar = SnackBar(
                        content: Text('Acceso denegado'),
                        backgroundColor: color,
                        duration: Duration(seconds: 1));
                  }
                  Scaffold.of(context).showSnackBar(snackbar);
                });
          },
          itemCount: accesos.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        ),
      ),
    );
  }
}
