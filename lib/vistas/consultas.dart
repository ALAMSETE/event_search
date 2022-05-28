// ignore_for_file: prefer_const_constructors, avoid_print, sized_box_for_whitespace

import 'package:event_search/modelos/event.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ConsultScreen extends StatefulWidget {
  const ConsultScreen({Key? key}) : super(key: key);

  @override
  State<ConsultScreen> createState() => _ConsultScreenState();
}

class _ConsultScreenState extends State<ConsultScreen> {

  //-------Declaracion de variables:
  Map<DateTime, List<Event>> eventosSeleccionados ={};
  String? dropdownCategory;
  String? dropdownName;
  CalendarFormat format = CalendarFormat.month;
  DateTime diaSeleccionado = DateTime.now();
  DateTime diaEnfocado = DateTime.now();

  @override
  void initState() {
    eventosSeleccionados = {};
    super.initState();
  }

  List<Event> obtenerEventos(DateTime fecha){
    return eventosSeleccionados[fecha] ?? [];
  }

  //-------Codigo fuente:
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black87,
        child: ListView(
          children: [
            Wrap(
              runSpacing: 15,
              children: [
                textoCabecera("Elige la categoria sobre la que quiere realizar la consulta", MediaQuery.of(context).size.width),
                //--------- Menu desplegable encargado de las categorias de la empresa
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width-10,
                    decoration: BoxDecoration(
                      color: Color(0x44000000),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton<String>(
                      dropdownColor: Colors.grey.shade900,
                      hint: Text("Selecciona la categoría", style: TextStyle(color: Colors.white),),
                      isExpanded: true,
                      value: dropdownCategory,
                      icon: const Icon(Icons.arrow_drop_down),
                      elevation: 16,
                      style: const TextStyle(color: Colors.white),
                      underline: Container(
                        height: 2,
                        color: Colors.yellowAccent.shade700,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownCategory = newValue!;
                        });
                      },
                      items: <String>['Uno', 'Dos', 'Tres', 'Cuatrooooooo']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  )
                ), 
                textoCabecera("Elige el nombre sobre el que quiere realizar la consulta:", MediaQuery.of(context).size.width),
                //------- Menu desplegable para nombres de las empresas
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width-10,
                    decoration: BoxDecoration(
                      color: Color(0x44000000),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton<String>( //Este widget seria el desplegable
                      dropdownColor: Colors.grey.shade900,
                      hint: Text("Selecciona el nombre", style: TextStyle(color: Colors.white),),
                      isExpanded: true,
                      value: dropdownName,
                      icon: const Icon(Icons.arrow_drop_down),
                      elevation: 16,
                      style: const TextStyle(color: Colors.white),
                      underline: Container(
                        height: 2,
                        color: Colors.yellowAccent.shade700,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownName = newValue!;
                        });
                      },
                      items: <String>['Vintash', 'La Tentación', 'La Farandula', 'Cuatrooooooo nombres'] //Aqui se guardan los items del desplegable
                          .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  )
                ),
                nombreTitular(dropdownName),
                //-----Container que contendra el calendario
                Container(
                  color: Colors.black12,
                  child: TableCalendar(
                    //locale:'es_SP',
                    focusedDay: diaEnfocado,
                    firstDay: DateTime(1000),
                    lastDay: DateTime(9999),
                    calendarFormat: format, // el formato lo igualamos al que se haya seleccionado
                    onFormatChanged: (CalendarFormat formato){ //con este metodo podemos modificar el formato del calendario
                      setState(() {
                        format = formato; //el formato lo igualamos al que nos hemos declarado anteriormente
                      });
                    },
                    startingDayOfWeek: StartingDayOfWeek.monday, //Definimos el dia en el que queremos que comience la semana
                    onDaySelected: (DateTime diaSelected, DateTime diaFocus){ //Este metodo se usa para diferenciar el dia actual con el seleccionado
                      setState(() {
                        diaSeleccionado = diaSelected;
                        diaEnfocado = diaFocus;
                      });
                      print(diaEnfocado); //Guia para saber si los datos pulsados son correctos
                    },

                    eventLoader: obtenerEventos,

                    calendarStyle: CalendarStyle( //Con calendarStyle podemos modificar como queremos que se vea el calendario
                      outsideTextStyle: TextStyle(
                        color: Colors.grey
                      ),
                      defaultTextStyle: TextStyle(
                        color: Colors.white
                      ),
                      weekendTextStyle: TextStyle(
                        color: Colors.yellowAccent.shade700
                      ),
                      isTodayHighlighted: true,
                      selectedDecoration: BoxDecoration( //Definimos como queremos que se vea el dia que se seleccione
                        color: Colors.yellowAccent.shade700,
                        shape: BoxShape.circle,
                      ),
                      selectedTextStyle: TextStyle( //Como queremos que se vean los numeros que se seleccionen
                        color: Colors.black
                      ),
                      todayDecoration: BoxDecoration( //Definimos como queremos que se vea el dia actual
                        color: Colors.black54,
                        shape: BoxShape.circle
                      )
                    ),
                    selectedDayPredicate: (DateTime fecha){
                      return isSameDay(diaSeleccionado, fecha); //Con selectedDay, permitimos pinchar al usuario en cualquier fecha
                    },
                    headerStyle: HeaderStyle(formatButtonVisible: false, titleCentered: true), //Con headerStyle modificamos la cabecera del calendario
                  ),
                ),
                ...obtenerEventos(diaSeleccionado).map((Event evento)=>ListTile(title: Text(evento.title))),
                Center(
                  child: ElevatedButton(
                    onPressed:(){
                      if(eventosSeleccionados[diaSeleccionado]!=null){
                        eventosSeleccionados[diaSeleccionado]?.add(Event(title: "Titulo"));
                      }
                      else{
                        eventosSeleccionados[diaSeleccionado] = [Event(title: "Titulo evento")];
                      }
                      
                      setState(() {
                        
                        //if(grupo_radio1.toString() == "1"){
                        //  resultado = (int.parse(controlador1.text)+int.parse(controlador2.text));
                        //}
                      });

                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.yellow.shade700),
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
                              Text("Solicitar disponibilidad")
                            ]
                        )
                    )
                  ),
                )
              ]
            )
          ]
        ),
      ),
    );
  }
}

Widget textoCabecera(String text, double ancho){
  return Container(
    width: ancho,
    child: Center(child: Text(text, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
  );
}

Widget nombreTitular(String? texto){
  if(texto==null){
    return Text("");
  }
  else{
    return Text(texto,
      style: TextStyle(
        height: 2,
        fontWeight: FontWeight.bold,
        fontSize: 35,
        color: Colors.white
    ),);
  }
}  