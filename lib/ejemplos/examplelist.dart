import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hades/Acceso.dart';

void main() {
  runApp(ListadoPuertas());
}

Acceso puerta1 = Acceso.convertirJson({
  "id": 1,
  "ubicacion": "A",
  "descripcion": "Puerta 1",
  "modo": "A",
  "modo_texto": "si",
  "puede_abrir": true
});
Acceso puerta2 = Acceso.convertirJson({
  "id": 2,
  "ubicacion": "T",
  "descripcion": "A",
  "modo": "A",
  "modo_texto": "A",
  "puede_abrir": true
});
List<Acceso> puertas = [puerta1, puerta2, puerta1];

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
  if (id == 29) {
    return true;
  } else {
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
