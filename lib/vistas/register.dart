// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:event_search/vistas/login.dart';
import 'package:event_search/modelos/usuarios.dart';
import 'package:event_search/controlador/conexion.dart';

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

  final Conexion conexion = Conexion();

  TextEditingController nameController = TextEditingController();
  TextEditingController surNameController = TextEditingController();
  TextEditingController dniController = TextEditingController();
  TextEditingController telController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController passConfirmController = TextEditingController();
  Usuario user = Usuario();

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
                  textoCabecera("Introduzca sus apellidos:", MediaQuery.of(context).size.width),
                  textSurName(),
                  textoCabecera("Escriba su DNI:", MediaQuery.of(context).size.width),
                  textUser(),
                  textoCabecera("Escriba su número de telefono:", MediaQuery.of(context).size.width),
                  textTelefono(),
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
      floatingActionButton: buildNavigateButton(),
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
            controller: dniController,
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

  Widget textTelefono() {
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
            controller: telController,
            //autofocus: true, //Lo comentamos porque no queremos que se haga el focus al arrancar ejecutar la app
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.send,  // icono del botón
            autocorrect: true,
            textAlign: TextAlign.center,
            obscureText: false, // password
            style: TextStyle(
                color: Colors.white
            ),
            decoration: InputDecoration(
              //icon: Icon(Icons.three_g_mobiledata_outlined),
              prefixIcon: Icon(Icons.phone, color: Colors.grey,),
              hintText: "Telefono",
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
        onPressed:() async
        { 
          if((passConfirmController.text.compareTo(passController.text)==0)&&dniController.text.trim().isNotEmpty){
            user.dni = dniController.text.toString().trim();
            user.nombre = nameController.text.toString().trim();
            user.apellidos = surNameController.text.toString().trim();
            user.contrasenia = passController.text.toString().trim();
            user.telefono = telController.text.toString().trim();

            bool insert = await conexion.insertUsuario(user).catchError(
                (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar( //Definimos el snackbar
                    backgroundColor: Colors.yellow[700],
                    content: Row(
                      children: const [
                        Icon(
                          Icons.error_outline,
                          size: 40,
                          color: Colors.white,
                         ),
                          Expanded(
                            child: Text(
                              'Ha ocurrido un error.',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      behavior: SnackBarBehavior.floating, //Definimos como queremos que se comporte y localice
                      margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height - 100,
                        right: 20,
                        left: 20),
                    ),
                  );
                },
              );

            Navigator.pop(context);
          }
          
          setState(() {
            
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

  Widget buildNavigateButton()=> FloatingActionButton(
    child: Icon(Icons.arrow_back),
    backgroundColor: Colors.yellow.shade700,
    onPressed: (){
      Navigator.pop(context);
    },
  );
}  