
class Event{
  final String idCalendario;
  final DateTime fecha;
  final String localidad;
  final String dniRes;
  Event({required this.idCalendario, required this.fecha, required this.localidad, required this.dniRes});

  String toString() => this.idCalendario;

  Map<String, dynamic> toMap(){
    return {'idCalendario':idCalendario, 'Fecha': fecha};
  }
}