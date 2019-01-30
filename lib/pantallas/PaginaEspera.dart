import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hades/variables.dart';

class PaginaEspera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            appBar: AppBar(
              title: Text(tituloAplicacion),
              automaticallyImplyLeading: false,
              actions: <Widget>[
                new IconButton(
                    icon: new Icon(Icons.close),
                    onPressed: () =>
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil('/', (_) => false)),
              ],
            ),
            body: Center(child: CircularProgressIndicator())));
  }
}
