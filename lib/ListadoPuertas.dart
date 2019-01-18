import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hades/Puerta.dart';
import 'package:hades/DetallePuerta.dart';
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
              onTap: () {
                Navigator.push(context, MaterialPageRoute<void>(
                  builder: ( BuildContext context) => DetallePuerta(puerta: puertas[position]),
                )
                );
              },
            );
          },

          itemCount: puertas.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        ),
      ),
    );
  }
}
