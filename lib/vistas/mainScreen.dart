// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:event_search/vistas/consultas.dart';
import 'package:event_search/vistas/profile.dart';
import 'package:flutter/material.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int paginaEnUso = 0;

  final List<Widget> paginas = [ConsultScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aplicación"),
        backgroundColor: Colors.yellow.shade700,
      ),
      body: paginas[paginaEnUso], //Mostramos en el body la clase que tengamos seleccionada según el item seleccionado en el menu inferior
      bottomNavigationBar: BottomNavigationBar( //Creamos el menu inferior
        backgroundColor: Colors.yellow.shade700,
        onTap: (indice){ //Declaramos lo que queremos que haga según el item pulsado a traves de un indice
          paginaEnUso = indice; //Segun el item se cambiara de ventana
          setState(() {
            paginaEnUso = indice;
          });
        },
        currentIndex: paginaEnUso, //Definimos el indice actual para poder cambiar de pagina
        items: [ //Declaramos los objetos que queremos que aparezcan debajo
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil")
        ],
      ),
    );
  }
}
 