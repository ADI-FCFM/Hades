import 'package:flutter/material.dart';
import 'package:hades/Puerta.dart';

Puerta puerta1 = Puerta.fromJson({
  "id": 29,
  "ubicacion": "ADI",
  "descripcion": "Puerta ADI",
  "modo": "T",
  "modo_texto": "Modo tarjeta",
  "puede_abrir": true
});
Puerta puerta2 = Puerta.fromJson({
  "id": 21,
  "ubicacion": "Torre central, 5º piso",
  "descripcion": "Ascensor",
  "modo": "A",
  "modo_texto": "Abierto",
  "puede_abrir": true
});
List<Puerta> puertas = [puerta1, puerta2, puerta1];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Control de accesos';
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primaryColor: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
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
