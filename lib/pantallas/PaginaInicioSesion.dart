import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hades/InformacionToken.dart';
import 'package:hades/PostInicioSesion.dart';
import 'package:hades/utilidades/informacionToken.dart';
import 'package:hades/utilidades/utilidadesGenerales.dart';
import 'package:hades/variables.dart';
import 'package:uni_links/uni_links.dart';

class PaginaInicioSesion extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _PaginaInicioSesionState();
}

class _PaginaInicioSesionState extends State<PaginaInicioSesion> {
  String ticket;
  StreamSubscription _sub;

  @override
  void initState() {
    super.initState();
    _iniciarSesion();
  }

  _iniciarSesion() async {
    String token = await conseguirTokenAlmacenado();
    bool noHaExpirado = await verificarFechaExpiracionToken();
    if (token != null) {
      if (noHaExpirado) {
        Navigator.of(context).pushReplacementNamed('/paginaPrincipal');
      } else {
        bool refrescar = await refrescarToken(urlRefrescar);
        if (refrescar) {
          Navigator.of(context).pushReplacementNamed('/paginaPrincipal');
        }
      }
    }
  }
  /// Obtener el token, refresh_token, fecha de expiración del token y nombre de usuario
  /// desde Aqueronte para luego guardar estos datos en SharedPreferences.
  Future<bool> _conseguirTokenConTicket(String ticket, String url) async {
    var respuesta = await metodoPost(url, {"ticket": ticket});
    if (respuesta.statusCode == 200) {
      Map<String, dynamic> responseJson =
          json.decode(utf8.decode(respuesta.bodyBytes));
      PostInicioSesion post = PostInicioSesion.convertirJson(responseJson);
      InformacionToken tokenData = post.informacionToken;
      tokenData.guardarInformacionToken();
      post.usuario.guardarNombreUsuario();
      return true;
    } else {
      return false;
    }
  }

  /// Agregar un listener al link para obtener el ticket
  _conseguirTicket() async {
    _sub = getLinksStream().listen((String link) async {
      try {
        if (link.contains("ticket")) {
          RegExp regexp = new RegExp(r"ticket=(\w+)");
          Iterable<Match> matches = regexp.allMatches(link);
          if (matches.isNotEmpty) {
            ticket = matches.elementAt(0).group(1);
            bool valid = await _conseguirTokenConTicket('$ticket', urlInicio);
            if (valid) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/paginaPrincipal', (_) => false);
            } else {
              throw ('error: ticket no es valido');
            }
          } else {
            throw ('error:formato de ticket no es valido');
          }
        } else {
          throw ('error: url no contiene ticket');
        }
      } catch (e) {
        Navigator.of(context).pushNamedAndRemoveUntil('/', (_) => false);
        String tituloError = 'Error al iniciar de sesión';
        String mensajeError =
            'Ocurrió un error al iniciar sesión, inténtalo nuevamente';
        alertaError(context, tituloError, mensajeError);
      }
    });
  }

  /// Quitar listeners
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
          title: new Text(tituloAplicacion),
        ),
        body: new Container(
            child: new Center(
                child: new RaisedButton(
                    child: new Text(mensaje),
                    onPressed: () async {
                      Navigator.of(context).pushNamed('/paginaEspera');
                      await lanzarURL(urlUri);
                      _conseguirTicket();
                    })
            )
        )
    );
  }
}
