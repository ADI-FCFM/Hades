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

  factory Acceso.convertirJson(Map<String, dynamic> json) {
    return Acceso(
        id: json['id'],
        ubicacion: json['ubicacion'],
        descripcion: json['descripcion'],
        modo: json['modo'],
        modoTexto: json['modo_texto'],
        puedeAbrir: json['puerta_abrir']);
  }
}
