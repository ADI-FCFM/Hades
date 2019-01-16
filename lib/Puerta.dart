class Puerta {
  int id;
  String ubicacion;
  String descripcion;
  String modo;
  String modo_texto;
  bool puede_abrir;

  Puerta(
      {this.id,
      this.ubicacion,
      this.descripcion,
      this.modo,
      this.modo_texto,
      this.puede_abrir});

  factory Puerta.fromJson(Map<String, dynamic> parsedJson) {
    return Puerta(
        id: parsedJson['id'],
        ubicacion: parsedJson['ubicacion'],
        descripcion: parsedJson['descripcion'],
        modo: parsedJson['modo'],
        modo_texto: parsedJson['modo_texto'],
        puede_abrir: parsedJson['puerta_abrir']);
  }
}
