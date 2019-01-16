import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaginaEspera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Aministrador de accesos")),
        body: Center(child: CircularProgressIndicator()));
  }
}
