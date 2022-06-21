
class Event{
  String? idCalendario;
  String? fecha;
  String? localidad;
  String? dniRes;
  Event({required this.idCalendario, required this.fecha, required this.localidad, required this.dniRes});

  Map<String, dynamic> toMap(){
    return {'idCalendario':idCalendario, 'fechaEvento': fecha, 'nomLocalidad':localidad, 'dniRes':dniRes};
  }

  Event.fromJson(Map<String, dynamic> json) {
    dniRes = json['dniRes'];
    idCalendario = json['idCalendario'];
    fecha = json['fechaEvento'];
    localidad = json['nomLocalidad'];
  }
}