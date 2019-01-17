
import 'package:flutter/material.dart';
import 'package:hades/PaginaEspera.dart';
import 'package:hades/PaginaInicial.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

import 'post.dart';
import 'package:hades/TokenData.dart';
void main() {
  runApp(new MaterialApp(
    theme: ThemeData(primarySwatch: Colors.red),
    title: 'Administrador de Accesos',
    home: new PaginaInicioSesion(),
    routes: <String, WidgetBuilder>{
      '/login': (BuildContext context) => new PaginaInicioSesion(),
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
  iniciarSesion() async{
    String token = await conseguirToken();
    bool noHaExpirado = await verificarFechaExpiracion();
    if(token != null) {
      print("token no es null");
      if (noHaExpirado) {
        print("no ha expirado");
        Navigator.of(context).pushReplacementNamed('/home');
      }else{
        print("expiro");
        String url ='http://172.17.85.189:8000/refrescar_token';
        bool refrescar = await refrescarToken(url);
        if(refrescar){
          Navigator.of(context).pushReplacementNamed('/home');
        }
        else{
          Navigator.of(context).pushReplacementNamed('/login');
        }
      }
    }
  }
  String ticket;
  /// Agregar un listener al link para obtener el ticket
  conseguirUniLink() async {
    getLinksStream().listen((String link) async {
      print('link: $link');
      if (link.contains("ticket")) {
        RegExp regexp = new RegExp(r"ticket=(\w+)");
        Iterable<Match> matches = regexp.allMatches(link);
        if (matches.isNotEmpty) {
          ticket = matches.elementAt(0).group(1);
          String url = 'http://172.17.85.189:8000/';
          bool valid = await conseguirTokenConTicket(ticket, url);
          if (valid) {
            Navigator.of(context).pushReplacementNamed('/home');
          } else {
            print('ticket no es válido');
          }
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
                    onPressed: () {
                      Navigator.of(context).pushNamed('/loading');
                      _lanzarURL();
                      conseguirUniLink();
                    }))));
  }

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
