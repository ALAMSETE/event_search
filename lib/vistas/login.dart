// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:event_search/controlador/conexion.dart';
import 'package:event_search/vistas/mainScreen.dart';
import 'package:event_search/vistas/register.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Event Search',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final Conexion conexion = Conexion();
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text("EventSeach"),
      ),*/
      body: Container(
        color: Colors.black87,
        child: ListView(
          children:[
            Padding(
              padding: const EdgeInsets.only(top: 375.0),
              child: Wrap(
                runSpacing: 10,
                children: [
                  textUser(),
                  textPass(),
                  botonLogin(),
                  botonRegister()
                ],
              ),
            ),
          ] 
        ),
      ),
    );
  }

  Widget textUser() {
    return
      Center(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0x44000000),//color transparente
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          width: 250.0,
          child:
          TextField(
            controller: userController,
            //autofocus: true, //Lo comentamos porque no queremos que se haga el focus al arrancar ejecutar la app
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.send,  // icono del botón
            autocorrect: true,
            textAlign: TextAlign.center,
            obscureText: false, // password
            style: TextStyle(
                color: Colors.white
            ),
            decoration: InputDecoration(
              //icon: Icon(Icons.three_g_mobiledata_outlined),
              prefixIcon: Icon(Icons.person_outline, color: Colors.grey,),
              hintText: "DNI",
              hintStyle:TextStyle(color: Colors.grey),
            ),
          )
        ),
      );
  }

    Widget textPass() {
    return
      Center(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0x44000000),//color transparente
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          width: 250.0,
          child:
          TextField(
            controller: passController,
            //autofocus: true, //Lo comentamos porque no queremos que se haga el focus al arrancar ejecutar la app
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.send,  // icono del botón
            autocorrect: false,
            textAlign: TextAlign.center,
            obscureText: true, // password
            style: TextStyle(
                color: Colors.white
            ),
            decoration: InputDecoration(
              //icon: Icon(Icons.three_g_mobiledata_outlined),
              prefixIcon: Icon(Icons.password, color: Colors.grey,),
              hintText: "Contraseña",
              hintStyle:TextStyle(color: Colors.grey),
            ),
          )
        ),
      );
  }

  Widget botonLogin(){
    return Center(
      child: ElevatedButton(
        onPressed:()
        async {
          bool inicio = await conexion.canLogin(userController.text.toString().trim(), passController.text.toString().trim());
          if(userController.text.toString().trim().isNotEmpty&&passController.text.toString().trim().isNotEmpty&&inicio){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context)=> MainPage()
              )
            );
          }else{
            print("Error de inicio de sesion");
          }
          
          
          //print("Pulsado"); //Una chuletilla
          //print(controlador1.text);
          //print(controlador2.text);
          //print(grupo_radio1.toString());
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
                    Icons.login,
                    size: 20,
                  ),
                  Text("Iniciar sesión")
                ]
            )
        )
      ),
    );
  }

  Widget botonRegister(){
    return Center(
      child: ElevatedButton(
        onPressed:()
        {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context)=> RegisterPage()
            )
            
          );
          
          //print("Pulsado");
          //print(controlador1.text);
          //print(controlador2.text);
          //print(grupo_radio1.toString());
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
                    Icons.person_add,
                    size: 20,
                  ),
                  Text("Crear una cuenta")
                ]
            )
        )
      ),
    );
  }
} 