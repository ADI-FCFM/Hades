import 'package:flutter/material.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:uni_links/uni_links.dart';

void main() {
  runApp(new MaterialApp(
    title: 'Administrador de Accesos',
    home: new PaginaInicioSesion(),
    routes: <String, WidgetBuilder>{
      '/login': (BuildContext context) => new PaginaInicioSesion(),
      '/home': (BuildContext context) => new PaginaInicial(),
    },
  ));
}

class PaginaInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new Scaffold(
        appBar: new AppBar(
          title: new Text('Administrador de accesos'),
        ),
        body: new Container(
          margin: new EdgeInsets.only(top: 50.0),
          alignment: Alignment.center,
          child: new Column(
            children: <Widget>[
              new Text('Bienvenido al Administrador de Accesos'),
              new FlatButton(
                  child: new Text('Cerrar sesion'),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/login');
                  })
            ],
          ),
        ),
      );
}

class PaginaInicioSesion extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _PaginaInicioSesionState();
}

class _PaginaInicioSesionState extends State<PaginaInicioSesion> {
  String ticket;

  /// Agregar un listener al link para obtener el ticket
  Future<String> conseguirUniLink() async {
    getLinksStream().listen((String link) {
      print('link: $link');
      if (link.contains("ticket")) {
        RegExp regexp = new RegExp(r"ticket=(\w+)");
        Iterable<Match> matches = regexp.allMatches(link);
        if (matches.isNotEmpty) {
          ticket = matches.elementAt(0).group(1);
          Navigator.of(context).pushReplacementNamed('/home');
        }
      } else {
        print("falta ticket");
      }
      print("listo el ticket esta abajo");
      print(ticket);
      return ticket;
    }, onError: (err) {
      print('error: $err');
    });
  }

  @override
  Widget build(BuildContext context) => new Scaffold(
      appBar: new AppBar(
        title: new Text('Administrador de Accesos'),
      ),
      body: new Container(
          child: new Center(
              child: new RaisedButton(
                  child: new Text('Iniciar sesión en la aplicación'),
                  onPressed: () {
                    _lanzarURL();
                    conseguirUniLink();
                  }))));

  _lanzarURL() async {
    const url =
        'https://sys21.adi.ing.uchile.cl/~jarriagada/davinci/web/batch/heimdall/login?uri=unilinks://accesos.app.adi/path/subpath';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo lanzar $url';
    }
  }
}
