class Usuario{
  String? dni;
  String? nombre;
  String? apellidos;
  String? contrasenia;
  String? telefono;

  Usuario({this.dni, this.nombre, this.apellidos, this.contrasenia, this.telefono});

  Usuario.fromJson(Map<String, dynamic> json) {
    dni = json['dni'];
    nombre = json['nombre'];
    apellidos = json['apellidos'];
    contrasenia = json['contrasenia'];
    telefono = json['telefono'];
  }
}