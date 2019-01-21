import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hades/DetallePuerta.dart';
import 'package:hades/Puerta.dart';

class ListadoPuertas extends StatelessWidget {
  final List<Puerta> puertas;

  ListadoPuertas({Key key, this.puertas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GridView.builder(
          itemBuilder: (context, position) {
            return ListTile(
                title: Text('${puertas[position].descripcion}'),
                subtitle: Text('${puertas[position].ubicacion}'),
                /*onTap: () {

                Navigator.push(context, MaterialPageRoute<void>(
                  builder: ( BuildContext context) => DetallePuerta(puerta: puertas[position]),
                )
                );
                */
                onTap: () async {
                  bool sePuedeAbrir = await abrir(puertas[position].id);
                  print(sePuedeAbrir);
                  print(puertas[position].id);
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
          itemCount: puertas.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        ),
      ),
    );
  }
}
