class Acceso {
  int id;
  String ubicacion;
  String descripcion;
  String modo;
  String modoTexto;
  bool puedeAbrir;

  Acceso(
      {this.id,
      this.ubicacion,
      this.descripcion,
      this.modo,
      this.modoTexto,
      this.puedeAbrir});

  factory Acceso.fromJson(Map<String, dynamic> parsedJson) {
    return Acceso(
        id: parsedJson['id'],
        ubicacion: parsedJson['ubicacion'],
        descripcion: parsedJson['descripcion'],
        modo: parsedJson['modo'],
        modoTexto: parsedJson['modo_texto'],
        puedeAbrir: parsedJson['puerta_abrir']);
  }
}
