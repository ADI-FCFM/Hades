import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
            return Center(
                child: Text(
              '${puertas[position].descripcion}',
              style: Theme.of(context).textTheme.headline,
            ));
          },
          itemCount: puertas.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        ),
      ),
    );
  }
}
