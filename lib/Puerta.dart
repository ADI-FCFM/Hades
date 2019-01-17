class Puerta {
  int id;
  String ubicacion;
  String descripcion;
  String modo;
  String modoTexto;
  bool puedeAbrir;

  Puerta(
      {this.id,
      this.ubicacion,
      this.descripcion,
      this.modo,
      this.modoTexto,
      this.puedeAbrir});

  factory Puerta.fromJson(Map<String, dynamic> parsedJson) {
    return Puerta(
        id: parsedJson['id'],
        ubicacion: parsedJson['ubicacion'],
        descripcion: parsedJson['descripcion'],
        modo: parsedJson['modo'],
        modoTexto: parsedJson['modo_texto'],
        puedeAbrir: parsedJson['puerta_abrir']);
  }
}
