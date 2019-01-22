import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hades/PaginaEspera.dart';
import 'package:hades/PaginaInicial.dart';
import 'package:hades/TokenData.dart';
import 'package:hades/variables.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

import 'post.dart';

void main() {
  runApp(new MaterialApp(
    theme: ThemeData(primarySwatch: Colors.red),
    title: 'Administrador de Accesos',
    routes: <String, WidgetBuilder>{
      '/': (BuildContext context) => new PaginaInicioSesion(),
      '/home': (BuildContext context) => new PaginaInicial(),
      '/loading': (BuildContext context) => new PaginaEspera(),
    },
  ));
}

class PaginaInicioSesion extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _PaginaInicioSesionState();
}

class _PaginaInicioSesionState extends State<PaginaInicioSesion> {
  @override
  void initState() {
    super.initState();
    iniciarSesion();
  }

  iniciarSesion() async {
    String token = await conseguirToken();
    bool noHaExpirado = await verificarFechaExpiracion();
    if (token != null) {
      print("token no es null");
      if (noHaExpirado) {
        print("no ha expirado");
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        print("expiro");
        bool refrescar = await refrescarToken(urlRefrescar);
        print(refrescar);
        if (refrescar) {
          Navigator.of(context).pushReplacementNamed('/home');
        }
      }
    }
  }

  String ticket;
  StreamSubscription _sub;

  /// Agregar un listener al link para obtener el ticket
  conseguirUniLink() async {
    _sub = getLinksStream().listen((String link) async {
      print('link: $link');
      if (link.contains("ticket")) {
        RegExp regexp = new RegExp(r"ticket=(\w+)");
        Iterable<Match> matches = regexp.allMatches(link);
        if (matches.isNotEmpty) {
          ticket = matches.elementAt(0).group(1);
          bool valid = await conseguirTokenConTicket(ticket, urlInicio);
          if (valid) {
            Navigator.of(context).pushNamedAndRemoveUntil('/home', (_) => false);
          } else {
            Navigator.of(context).pushNamedAndRemoveUntil('/', (_) => false);
            _errorInicioSesion(context);
            print('ticket no es válido');
          }
        }
      } else {
        print("falta ticket");
      }
      print("listo el ticket esta abajo");
      print(ticket);
    }, onError: (err) {
      print("me cai");
      print('error: $err');
    });
  }
  @override
  void dispose() {
    if (_sub != null) _sub.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    String mensaje = 'Iniciar sesión en la aplicación';
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Administrador de Accesos'),
        ),
        body: new Container(
            child: new Center(
                child: new RaisedButton(
                    child: new Text(mensaje),
                    onPressed: () async{
                      Navigator.of(context).pushNamed('/loading');
                      await _lanzarURL(urlUri);
                      conseguirUniLink();
                    }))));
  }

  _lanzarURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo lanzar $url';
    }
  }
}
void _errorInicioSesion(context) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text("Error al iniciar sesión"),
        content: new Text("Ocurrió un error al inciar sesión, intente nuevamente"),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("Cerrar"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
