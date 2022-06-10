// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:event_search/controlador/conexion.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen(this.dni, {Key? key}) : super(key: key);
  String dni;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String dni;
  Conexion conexion = Conexion();

  @override
  initState() {
    super.initState();
    dni = widget.dni;
  }

  TextEditingController controllerNombre = TextEditingController();
  TextEditingController controllerApellido = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black87,
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Wrap(
              runSpacing: 10,
              children: [
                Center(
                    child: Image.asset(
                  'assets/vintash.png',
                  width: 125,
                )),
                textoCabecera("Nombre:", MediaQuery.of(context).size.width),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        //color: Colors.black12,
                        ),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        textUser("Escriba aqui su nuevo nombre"),
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
                        //color: Colors.black12,
                        ),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        textApellido("Esribe tus nuevos apellidos"),
                        botonApellido()
                      ],
                    ),
                  ),
                ),
                textoCabecera(
                    "Número de telefono:", MediaQuery.of(context).size.width),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        //color: Colors.black12,
                        ),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        textPhone("Escriba su nuevo número"),
                        botonNumTelefono()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget imagenPerf() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: AssetImage("assets/vintash.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget textoCabecera(String texto, double ancho) {
    return Container(
      width: ancho,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(texto,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget textUser(String nombre) {
    return Center(
      child: Container(
          decoration: BoxDecoration(
              color: Color(0x44000000), //color transparente
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          width: 250.0,
          child: TextField(
            controller: controllerNombre,
            //autofocus: true, //Lo comentamos porque no queremos que se haga el focus al arrancar ejecutar la app
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.send, // icono del botón
            autocorrect: true,
            textAlign: TextAlign.center,
            obscureText: false, // password
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              //icon: Icon(Icons.three_g_mobiledata_outlined),
              //prefixIcon: Icon(Icons.person_outline, color: Colors.grey,),
              hintText: nombre,
              hintStyle: TextStyle(color: Colors.grey),
            ),
          )),
    );
  }

  Widget textApellido(String apellido) {
    return Center(
      child: Container(
          decoration: BoxDecoration(
              color: Color(0x44000000), //color transparente
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          width: 250.0,
          child: TextField(
            controller: controllerApellido,
            //autofocus: true, //Lo comentamos porque no queremos que se haga el focus al arrancar ejecutar la app
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.send, // icono del botón
            autocorrect: true,
            textAlign: TextAlign.center,
            obscureText: false, // password
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              //icon: Icon(Icons.three_g_mobiledata_outlined),
              //prefixIcon: Icon(Icons.person_outline, color: Colors.grey,),
              hintText: apellido,
              hintStyle: TextStyle(color: Colors.grey),
            ),
          )),
    );
  }

  Widget textPhone(String hint) {
    return Center(
      child: Container(
          decoration: BoxDecoration(
              color: Color(0x44000000), //color transparente
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          width: 250.0,
          child: TextField(
            controller: controllerPhone,
            //autofocus: true, //Lo comentamos porque no queremos que se haga el focus al arrancar ejecutar la app
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.send, // icono del botón
            autocorrect: true,
            textAlign: TextAlign.center,
            obscureText: false, // password
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              //icon: Icon(Icons.three_g_mobiledata_outlined),
              //prefixIcon: Icon(Icons.person_outline, color: Colors.grey,),
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey),
            ),
          )),
    );
  }

  Widget botonNombre() {
    return Center(
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.yellow.shade700),
          ),
          onPressed: () async => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    backgroundColor: Colors.black54,
                    title: Text("Confirmación",
                        style: TextStyle(color: Colors.yellow.shade700)),
                    content: Text("¿Desea actualizar su nombre?",
                        style: TextStyle(color: Colors.white)),
                    actions: [
                      TextButton(
                          child:
                              Text("No", style: TextStyle(color: Colors.white)),
                          onPressed: () => Navigator.pop(context)),
                      TextButton(
                          child:
                              Text("Si", style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            //conexion.updateUserNom(controllerNombre.text.toString().trim(), dni);
                            Navigator.pop(context);
                          })
                    ],
                  )),
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(
                      Icons.edit,
                      size: 20,
                    ),
                  ]))),
    );
  }

  Widget botonApellido() {
    return Center(
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.yellow.shade700),
          ),
          onPressed: () async => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    backgroundColor: Colors.black54,
                    title: Text("Confirmación",
                        style: TextStyle(color: Colors.yellow.shade700)),
                    content: Text("¿Desea actualizar sus apellidos?",
                        style: TextStyle(color: Colors.white)),
                    actions: [
                      TextButton(
                          child:
                              Text("No", style: TextStyle(color: Colors.white)),
                          onPressed: () => Navigator.pop(context)),
                      TextButton(
                          child:
                              Text("Si", style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            //conexion.insertCalendario(evento);
                            Navigator.pop(context);
                          })
                    ],
                  )),
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(
                      Icons.edit,
                      size: 20,
                    ),
                  ]))),
    );
  }

  Widget botonNumTelefono() {
    return Center(
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.yellow.shade700),
          ),
          onPressed: () async => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    backgroundColor: Colors.black54,
                    title: Text("Confirmación",
                        style: TextStyle(color: Colors.yellow.shade700)),
                    content: Text("¿Desea actualizar su número telefónico?",
                        style: TextStyle(color: Colors.white)),
                    actions: [
                      TextButton(
                          child:
                              Text("No", style: TextStyle(color: Colors.white)),
                          onPressed: () => Navigator.pop(context)),
                      TextButton(
                          child:
                              Text("Si", style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            //conexion.insertCalendario(evento);
                            Navigator.pop(context);
                          })
                    ],
                  )),
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(
                      Icons.edit,
                      size: 20,
                    ),
                  ]))),
    );
  }
}
