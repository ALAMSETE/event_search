
class Event{
  final String idCalendario;
  final DateTime fecha;
  Event({required this.idCalendario, required this.fecha});

  String toString() => this.idCalendario;

  Map<String, dynamic> toMap(){
    return {'idCalendario':idCalendario, 'Fecha': fecha};
  }
}