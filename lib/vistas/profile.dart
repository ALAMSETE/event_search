// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:event_search/controlador/conexion.dart';
import 'package:event_search/modelos/event.dart';
import 'package:event_search/modelos/usuarios.dart';
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

  Usuario user = Usuario();
  var misEventos = [];

  TextEditingController controllerNombre = TextEditingController();
  TextEditingController controllerApellido = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();

  @override
  initState() {
    super.initState();
    dni = widget.dni;
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Container(
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
                        textUser(),
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
                        textApellido(),
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
                        textPhone(),
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

  Widget textUser() {
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
              hintText: "Nuevo nombre. Ej: "+user.nombre!,
              hintStyle: TextStyle(color: Colors.grey),
            ),
          )),
    );
  }

  Widget textApellido() {
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
              hintText: "Nuevos apellidos. Ej: "+user.apellidos!,
              hintStyle: TextStyle(color: Colors.grey),
            ),
          )),
    );
  }

  Widget textPhone() {
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
              hintText: "Nuevo telefono. Ej: "+user.telefono!,
              hintStyle: TextStyle(color: Colors.grey),
            ),
          )),
    );
  }

  Widget botonNombre() { //Boton para modificar el nombre
    return Center(
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.yellow.shade700),
          ),
          onPressed: () async => showDialog( //Si le damos al boton nos muestra un alertdialog para confirmar la consulta
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
                              Text("No", style: TextStyle(color: Colors.white)), //Si le damos a no se cierra el alerdialog y cancela la consulta
                          onPressed: () => Navigator.pop(context)),
                      TextButton(
                          child:
                              Text("Si", style: TextStyle(color: Colors.white)), //Si le damos a que si se lleva a cabo la consulta
                          onPressed: () {
                            conexion.updateUserNom(
                                controllerNombre.text.toString().trim(),
                                user.dni.toString());
                            Navigator.pop(context);
                          })
                    ],
                  )),
          child: Padding( //Le añadimos un padding al icono
              padding: const EdgeInsets.all(10.0),
              child: const Icon(
                Icons.edit,
                size: 20,
              ))),
    );
  }

  Widget botonApellido() { //Boton para modificar los apellidos
    return Center(
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.yellow.shade700),
          ),
          onPressed: () async => showDialog( //Si le damos al boton nos muestra un alertdialog para confirmar la consulta
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
                              Text("No", style: TextStyle(color: Colors.white)), //Si le damos a no se cierra el alerdialog y cancela la consulta
                          onPressed: () => Navigator.pop(context)),
                      TextButton(
                          child:
                              Text("Si", style: TextStyle(color: Colors.white)), //Si le damos a que si se lleva a cabo la consulta
                          onPressed: () {
                            conexion.updateUserApell(
                                controllerApellido.text.toString().trim(),
                                user.dni.toString());
                            Navigator.pop(context);
                          })
                    ],
                  )),
          child: Padding( //Le añadimos un padding al icono
              padding: const EdgeInsets.all(10.0),
              child: const Icon( 
                Icons.edit,
                size: 20,
              ))),
    );
  }

  Widget botonNumTelefono() { //Boton para modificar el telefono
    return Center(
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.yellow.shade700),
          ),
          onPressed: () async => showDialog( //Si le damos al boton nos muestra un alertdialog para confirmar la consulta
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
                              Text("No", style: TextStyle(color: Colors.white)), //Si le damos a no se cierra el alerdialog y cancela la consulta
                          onPressed: () => Navigator.pop(context)),
                      TextButton(
                          child:
                              Text("Si", style: TextStyle(color: Colors.white)), //Si le damos a que si se lleva a cabo la consulta
                          onPressed: () {
                            conexion.updateUserTel(
                                controllerPhone.text.toString().trim(),
                                user.dni.toString());
                            Navigator.pop(context);
                          })
                    ],
                  )),
          child: Padding( //Le añadimos un padding al icono
              padding: const EdgeInsets.all(10.0),
              child: const Icon(
                Icons.edit,
                size: 20,
              ))),
    );
  }

  getUser() async {
    await conexion.getUsuario(dni).then((value) {
      setState(() {
        user.nombre = value.nombre;
        user.apellidos = value.apellidos;
        user.dni = value.dni;
        user.contrasenia = value.contrasenia;
        user.telefono = value.telefono;
      });
    });
  }
  
}
