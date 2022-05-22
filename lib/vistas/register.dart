// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:event_search/vistas/login.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplicación',
      home: const RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController surNameController = TextEditingController();
  TextEditingController secondSurNameController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController passConfirmController = TextEditingController();

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
              padding: const EdgeInsets.only(top: 100.0, bottom: 100.0),
              child: Wrap(
                runSpacing: 10,
                children: [
                  textoCabecera("Introduzca su nombre:", MediaQuery.of(context).size.width),
                  textName(),
                  textoCabecera("Introduzca su primer apellido:", MediaQuery.of(context).size.width),
                  textSurName(),
                  textoCabecera("Introduzca su segundo apellido:", MediaQuery.of(context).size.width),
                  textSecondSurName(),
                  textoCabecera("Escriba un nombre de usuario:", MediaQuery.of(context).size.width),
                  textUser(),
                  textoCabecera("Escriba su contraseña:", MediaQuery.of(context).size.width),
                  textPass(),
                  textoCabecera("Repita de nuevo la contraseña:", MediaQuery.of(context).size.width),
                  textPassConfirm(),
                  botonCreate()
                ],
              ),
            ),
          ] 
        ),
      ),
    );
  }

  Widget textName() {
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
            controller: nameController,
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
              hintText: "Nombre",
              hintStyle:TextStyle(color: Colors.grey),
            ),
          )
        ),
      );
  }

  Widget textSurName() {
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
            controller: surNameController,
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
              hintText: "Apellido",
              hintStyle:TextStyle(color: Colors.grey),
            ),
          )
        ),
      );
  }

  Widget textSecondSurName() {
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
            controller: secondSurNameController,
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
              hintText: "Segundo apellido",
              hintStyle:TextStyle(color: Colors.grey),
            ),
          )
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
              hintText: "Usuario",
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

  Widget textPassConfirm() {
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
            controller: passConfirmController,
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
              hintText: "Confirmar contraseña",
              hintStyle:TextStyle(color: Colors.grey),
            ),
          )
        ),
      );
  }

  Widget botonCreate(){
    return Center(
      child: ElevatedButton(
        onPressed:()
        { 
          if((passConfirmController.text.compareTo(passController.text)==0)&&userController.text.trim().isNotEmpty){
            Navigator.pop(context);
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
                    Icons.person_add,
                    size: 20,
                  ),
                  Text("Crear cuenta")
                ]
            )
        )
      ),
    );
  }

  Widget textoCabecera(String texto, double ancho){
    return Container(
      width: ancho,
      child: Center(child: Text(texto, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
    );
  }
}  