// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black87,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100.0, bottom: 100.0),
              child: Wrap(
                runSpacing: 10,
                children: [
                  textoCabecera("Nombre:", MediaQuery.of(context).size.width),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black12,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          text("Nombre:"),
                          botonNombre()
                        ],
                      ),
                    ),
                  ),
                  textoCabecera("Apellidos:", MediaQuery.of(context).size.width),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black12,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          text("Apellidos:"),
                          botonApellido()
                        ],
                      ),
                    ),
                  ),
                  textoCabecera("Número de telefono:", MediaQuery.of(context).size.width),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black12,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          text("Telefono:"),
                          botonNumTelefono()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ] 
        ),
      ),
    );
  }

  Widget imagenPerf(){
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: AssetImage("assets/rs6.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget textoCabecera(String texto, double ancho){
    return Container(
      width: ancho,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(texto, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget text(String text){
    return Text(
      text,
      style: TextStyle(
        color: Colors.white
      ),
    );
  }

  Widget botonNombre(){
    return Center(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.yellow.shade700),
        ),
        onPressed:(){

        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(
                Icons.edit,
                size: 20,
              ),
            ]
          )
        )
      ),
    );
  }

  Widget botonApellido(){
    return Center(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.yellow.shade700),
        ),
        onPressed:(){

        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(
                Icons.edit,
                size: 20,
              ),
            ]
          )
        )
      ),
    );
  }
  
  Widget botonNumTelefono(){
    return Center(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.yellow.shade700),
        ),
        onPressed:(){

        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(
                Icons.edit,
                size: 20,
              ),
            ]
          )
        )
      ),
    );
  }
  
}

  