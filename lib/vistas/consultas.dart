// ignore_for_file: prefer_const_constructors, avoid_print, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:event_search/controlador/conexion.dart';
import 'package:event_search/modelos/event.dart';
import 'package:event_search/modelos/usuarios.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ConsultScreen extends StatefulWidget {
  ConsultScreen(this.dni, {Key? key}) : super(key: key);
  String dni;
  @override
  State<ConsultScreen> createState() => _ConsultScreenState();
}

class _ConsultScreenState extends State<ConsultScreen> {
  //-------Declaracion de variables:
  List<String> nombreEvento = [];
  List<String> nombreLocalidad = [];
  Map<DateTime, List<Event>> eventosSeleccionados = {};
  String? dropdownName;
  String? dropdownLocalidad;
  String? nomEvento;
  String? tipo;
  late String dni;
  var nombres = [];
  var fecha = [];
  CalendarFormat format = CalendarFormat.month;
  DateTime diaSeleccionado = DateTime.now();
  DateTime diaEnfocado = DateTime.now();
  Usuario user = Usuario();

  @override
  void initState() {
    dni = widget.dni;
    eventosSeleccionados = {};
    super.initState();
    Conexion conexion = Conexion();
    conexion.getEventos().then((value) {
      nombreEvento.addAll(value);
    });
    conexion.getLocalidades().then((value) {
      nombreLocalidad.addAll(value);
    });
    conexion.getUsuario(dni).then((value) {
      setState(() {
        user.nombre = value.nombre;
        user.apellidos = value.apellidos;
        user.dni = value.dni;
        user.contrasenia = value.contrasenia;
        user.telefono = value.telefono;
      });
    });
  }

  List<Event> obtenerEventos(DateTime fecha) {
    return eventosSeleccionados[fecha] ?? [];
  }

  //-------Codigo fuente:
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(children: [
          Wrap(runSpacing: 15, children: [
            textoCabecera(
                "Elige la localidad:", MediaQuery.of(context).size.width),
            //------- Menu desplegable para nombres de las empresas
            Center(
                child: Container(
              width: MediaQuery.of(context).size.width - 10,
              decoration: BoxDecoration(
                color: Color(0x44000000),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton<String>(
                //Este widget seria el desplegable
                dropdownColor: Colors.grey.shade900,
                hint: Text(
                  "Selecciona localidad",
                  style: TextStyle(color: Colors.white),
                ),
                isExpanded: true,
                value: dropdownLocalidad,
                icon: const Icon(Icons.arrow_drop_down),
                elevation: 16,
                style: const TextStyle(color: Colors.white),
                underline: Container(
                  height: 2,
                  color: Colors.yellowAccent.shade700,
                ),
                onChanged: (String? nuevoValor) {
                  setState(() {
                    dropdownLocalidad = nuevoValor!;
                  });
                },
                items:
                    nombreLocalidad //Aqui se guardan los items del desplegable
                        .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            )),
            textoCabecera(
                "Elige el nombre sobre el que quiere realizar la consulta:",
                MediaQuery.of(context).size.width),
            //------- Menu desplegable para nombres de las empresas
            Center(
                child: Container(
              width: MediaQuery.of(context).size.width - 10,
              decoration: BoxDecoration(
                color: Color(0x44000000),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton<String>(
                //Este widget seria el desplegable
                dropdownColor: Colors.grey.shade900,
                hint: Text(
                  "Selecciona el nombre",
                  style: TextStyle(color: Colors.white),
                ),
                isExpanded: true,
                value: dropdownName,
                icon: const Icon(Icons.arrow_drop_down),
                elevation: 16,
                style: const TextStyle(color: Colors.white),
                underline: Container(
                  height: 2,
                  color: Colors.yellowAccent.shade700,
                ),
                onChanged: (String? nuevoValor) {
                  setState(() {
                    nombres = nuevoValor!.split(",");
                    tipo = nombres[1].toString().trim();
                    nomEvento = nombres[0].toString().trim();
                    dropdownName = nuevoValor;
                  });
                },
                items: nombreEvento //Aqui se guardan los items del desplegable
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            )),
            nombreTitular(nomEvento),
            //-----Container que contendra el calendario
            Container(
              color: Colors.black12,
              child: TableCalendar(
                //locale:'es_ES',
                focusedDay: diaEnfocado,
                firstDay: DateTime(1000),
                lastDay: DateTime(9999),
                calendarFormat:
                    format, // el formato lo igualamos al que se haya seleccionado
                onFormatChanged: (CalendarFormat formato) {
                  //con este metodo podemos modificar el formato del calendario
                  setState(() {
                    format =
                        formato; //el formato lo igualamos al que nos hemos declarado anteriormente
                  });
                },
                startingDayOfWeek: StartingDayOfWeek
                    .monday, //Definimos el dia en el que queremos que comience la semana
                onDaySelected: (DateTime diaSelected, DateTime diaFocus) {
                  //Este metodo se usa para diferenciar el dia actual con el seleccionado
                  setState(() {
                    diaSeleccionado = diaSelected;
                    diaEnfocado = diaFocus;
                  });
                },

                eventLoader:
                    obtenerEventos, //Con este eventLoader, almacenamos temporalmente los eventos que añadimos

                calendarStyle: CalendarStyle(
                    //Con calendarStyle podemos modificar como queremos que se vea el calendario
                    outsideTextStyle: TextStyle(color: Colors.grey),
                    defaultTextStyle: TextStyle(color: Colors.white),
                    weekendTextStyle:
                        TextStyle(color: Colors.yellowAccent.shade700),
                    withinRangeTextStyle:
                        TextStyle(color: Colors.yellowAccent.shade700),
                    isTodayHighlighted: true,
                    selectedDecoration: BoxDecoration(
                      //Definimos como queremos que se vea el dia que se seleccione
                      color: Colors.yellowAccent.shade700,
                      shape: BoxShape.circle,
                    ),
                    selectedTextStyle: TextStyle(
                        //Como queremos que se vean los numeros que se seleccionen
                        color: Colors.black),
                    todayDecoration: BoxDecoration(
                        //Definimos como queremos que se vea el dia actual
                        color: Colors.black54,
                        shape: BoxShape.circle)),
                selectedDayPredicate: (DateTime fecha) {
                  return isSameDay(diaSeleccionado,
                      fecha); //Con selectedDay, permitimos pinchar al usuario en cualquier fecha
                },
                headerStyle: HeaderStyle(
                  //Con headerStyle modificamos la cabecera del calendario
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle:
                      TextStyle(color: Colors.yellowAccent.shade700),
                ),
              ),
            ),
            ...obtenerEventos(diaSeleccionado).map(
                (Event evento) => ListTile(title: Text(evento.idCalendario!))),
            Center(
              child: ElevatedButton(
                onPressed: () async => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Colors.grey[850],
                    title: Text("Añadir evento",
                        style:
                            TextStyle(color: Colors.yellow.shade700)),
                    content: Text("¿Quieres realizar una reserva?",
                        style: TextStyle(color: Colors.white)),
                    actions: [
                      TextButton(
                          child: Text("No",
                              style: TextStyle(color: Colors.white)),
                          onPressed: () => Navigator.pop(context)),
                      TextButton(
                          child: Text("Si",
                              style: TextStyle(color: Colors.white)),
                          onPressed: () async {
                            if(dropdownName!=null&&dropdownLocalidad!=null){
                              var conex = await Connectivity().checkConnectivity();
                              if(conex == ConnectivityResult.none){
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar( //Definimos el snackbar
                                  backgroundColor: Colors.redAccent[700],
                                  content: Row(
                                    children: const [
                                      Icon(
                                        Icons.wifi_off,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                        Expanded(
                                          child: Text(
                                            'No puedes realizar una reserva sin conexión a Internet.',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    behavior: SnackBarBehavior.floating, //Definimos como queremos que se comporte y localice
                                    margin: EdgeInsets.only(
                                      bottom: MediaQuery.of(context).size.height - 200,
                                      right: 20,
                                      left: 20),
                                  ),
                                );
                              }
                              else{
                                Event evento = Event(
                                    idCalendario: nomEvento,
                                    fecha: diaEnfocado.toString().split(" ")[0].toString().trim(),
                                    localidad: dropdownLocalidad,
                                    dniRes: user.dni!);
                                bool libre; // Creamos una variable con la que sabremos si el día esta ocupado o no
                                Conexion conexion = Conexion();
                                libre = await conexion.canInsert(evento.fecha.toString(), evento.idCalendario!);
                                if(libre){ // Si esta libre... (No tiene ninguna reserva ese dia)
                                  conexion.insertCalendario(evento);
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar( //Definimos el snackbar
                                    backgroundColor: Colors.greenAccent[700],
                                    content: Row(
                                      children: const [
                                        Icon(
                                          Icons.check,
                                          size: 40,
                                          color: Colors.white,
                                        ),
                                          Expanded(
                                            child: Text(
                                              'Reserva realizada con éxito.',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      behavior: SnackBarBehavior.floating, //Definimos como queremos que se comporte y localice
                                      margin: EdgeInsets.only(
                                        bottom: MediaQuery.of(context).size.height - 200,
                                        right: 20,
                                        left: 20),
                                    ),
                                  );
                                }
                                else{ //Si no esta libre...
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar( //Definimos el snackbar
                                    backgroundColor: Colors.redAccent[700],
                                    content: Row(
                                      children: const [
                                        Icon(
                                          Icons.error,
                                          size: 40,
                                          color: Colors.white,
                                        ),
                                          Expanded(
                                            child: Text(
                                              'Este día esta ya reservado.',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      behavior: SnackBarBehavior.floating, //Definimos como queremos que se comporte y localice
                                      margin: EdgeInsets.only(
                                        bottom: MediaQuery.of(context).size.height - 200,
                                        right: 20,
                                        left: 20),
                                    ),
                                  );
                                } 
                              }
                            }
                            else{
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar( //Definimos el snackbar
                                    backgroundColor: Colors.redAccent[700],
                                    content: Row(
                                      children: const [
                                        Icon(
                                          Icons.error,
                                          size: 40,
                                          color: Colors.white,
                                        ),
                                          Expanded(
                                            child: Text(
                                              'Debes seleccionar un nombre y localidad.',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      behavior: SnackBarBehavior.floating, //Definimos como queremos que se comporte y localice
                                      margin: EdgeInsets.only(
                                        bottom: MediaQuery.of(context).size.height - 200,
                                        right: 20,
                                        left: 20),
                                    ),
                                  );
                            }
                          })
                    ],
                  )),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.yellow.shade700),
                    maximumSize:
                        MaterialStateProperty.all(const Size(250.0, 100.0))),
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          Icons.add,
                          size: 20,
                        ),
                        Text("Realizar una reserva")
                      ])
                )
              ),
            )
          ])
        ]),
      ),
    );
  }
}

//Nos creamos un texto para la cabecera
Widget textoCabecera(String text, double ancho) {
  return Container(
    width: ancho,
    child: Center(
        child: Text(text,
            style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
  );
}

//Nos creamos un texto para el titulo
Widget nombreTitular(String? texto) {
  if (texto == null) {
    return Text("");
  } else {
    return Text(
      texto,
      style: TextStyle(
          height: 2,
          fontWeight: FontWeight.bold,
          fontSize: 35,
          color: Colors.white),
    );
  }
}
