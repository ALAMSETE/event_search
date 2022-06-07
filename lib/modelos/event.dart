
class Event{
  final String idCalendario;
  final DateTime fecha;
  final String localidad;
  Event({required this.idCalendario, required this.fecha, required this.localidad});

  String toString() => this.idCalendario;

  Map<String, dynamic> toMap(){
    return {'idCalendario':idCalendario, 'Fecha': fecha};
  }
}