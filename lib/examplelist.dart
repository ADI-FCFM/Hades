import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hades/Puerta.dart';

void main() {
  runApp(ListadoPuertas());
}

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

class ListadoPuertas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GridView.builder(
          itemBuilder: (context, position) {
            return ListTile(
              title: Text('${puertas[position].descripcion}'),
              subtitle: Text('${puertas[position].ubicacion}'),
              onTap: () async {
                bool sePuedeAbrir = await abrir(puertas[position].id);
                var snackbar;
                Color color;
                if (sePuedeAbrir) {
                  color = Colors.green.shade400;
                  snackbar = SnackBar(
                      content: Text('Yay! A SnackBar!'),
                      backgroundColor: color,
                      duration: Duration(seconds: 1));
                } else {
                  Color color = Colors.red.shade400;
                  snackbar = SnackBar(
                      content: Text('buu! A SnackBar!'),
                      backgroundColor: color,
                      duration: Duration(seconds: 1));
                }
                Scaffold.of(context).showSnackBar(snackbar);
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

Future<bool> abrir(int id) async {
  var respuesta = 200;
  if (id == 29) {
    print(true);
    return true;
  } else {
    print(false);
    return false;
  }
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
