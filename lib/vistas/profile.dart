// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, unrelated_type_equality_checks

import 'package:connectivity_plus/connectivity_plus.dart';
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
  String dni = "";
  Conexion conexion = Conexion();

  Usuario user = Usuario();
  var misEventos = [];
  late Future<ConnectivityResult> conex;

  List<Event> listaMisEventos = [];

  TextEditingController controllerNombre = TextEditingController();
  TextEditingController controllerApellido = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();

  @override
  initState() {
    super.initState();
    dni = widget.dni;
    conex = Connectivity().checkConnectivity();
    if(conex == ConnectivityResult.none){
      CircularProgressIndicator;
    }
    else{
      setUserValues();
      getUser();
      conexion.getMisEventos(dni).then(
        (value){
          listaMisEventos.addAll(value);
        }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async{
          setState(() {
            listaMisEventos.clear();
          });
          await conexion.getMisEventos(dni).then(
            (value){
              setState(() {
                listaMisEventos.addAll(value);
              });
            }
          );
        },
        color: Colors.black87,
        child: Container(
          color: Colors.black87,
          child: ListView(
            children: [
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
                  textoCabecera("Mis reservas", MediaQuery.of(context).size.width),
                  FutureBuilder(
                    future: conexion.getMisEventos(dni),
                    builder: (BuildContext context, AsyncSnapshot snapshot){
                      if(snapshot.hasData){
                        return Center(
                          child: SizedBox(
                            width: 1000,
                            height: MediaQuery.of(context).size.height /2,
                            child: ListView.builder(
                              primary: false, 
                              itemCount: listaMisEventos.length,
                              itemBuilder: (context, index){
                                return cargarMisEventos(listaMisEventos[index]);
                              },
                            ),
                          ),
                        );
                      }
                      else{
                        return CircularProgressIndicator();
                      }
                    },
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  //Nos creamos un widget para pintar la imagen
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
  //Nos creamos un widget para el texto de cabecera
  Widget textoCabecera(String texto, double ancho) {
    return SizedBox(
      width: ancho,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(texto,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
  
  //Nos creamos un widget para el texto de del usuario
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
              hintText: "Nuevo nombre. Ej: "+user.nombre!,
              hintStyle: TextStyle(color: Colors.grey),
            ),
          )),
    );
  }

  //Nos creamos un widget para el texto del apellido
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
              hintText: "Nuevos apellidos. Ej: "+user.apellidos!,
              hintStyle: TextStyle(color: Colors.grey),
            ),
          )),
    );
  }

  //Nos creamos un widget para el texto del telefono
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
                    backgroundColor: Colors.grey[850],
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
                            if(controllerNombre.text.toString().trim().isNotEmpty){
                              conexion.updateUserNom(
                                controllerNombre.text.toString().trim(),
                                user.dni.toString());
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
                                          'Nombre modificado.',
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
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar( //Definimos el snackbar
                                backgroundColor: Colors.redAccent[700],
                                content: Row(
                                  children: const [
                                    Icon(
                                      Icons.error_outline,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                      Expanded(
                                        child: Text(
                                          'El campo no puede estar vacío.',
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
                    backgroundColor: Colors.grey[850],
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
                            if(controllerApellido.text.toString().trim().isNotEmpty){
                              conexion.updateUserApell(
                                controllerApellido.text.toString().trim(),
                                user.dni.toString());
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
                                          'Apellidos modificados.',
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
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar( //Definimos el snackbar
                                backgroundColor: Colors.redAccent[700],
                                content: Row(
                                  children: const [
                                    Icon(
                                      Icons.error_outline,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                      Expanded(
                                        child: Text(
                                          'El campo no puede estar vacío.',
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
                    backgroundColor: Colors.grey[850],
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
                            if(controllerPhone.text.toString().trim().isNotEmpty){
                              conexion.updateUserTel(
                                controllerPhone.text.toString().trim(),
                                user.dni.toString());
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
                                          'Número de teléfono modificado',
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
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar( //Definimos el snackbar
                                backgroundColor: Colors.redAccent[700],
                                content: Row(
                                  children: const [
                                    Icon(
                                      Icons.error_outline,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                      Expanded(
                                        child: Text(
                                          'El campo no puede estar vacío.',
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
          child: Padding( //Le añadimos un padding al icono
              padding: const EdgeInsets.all(10.0),
              child: const Icon(
                Icons.edit,
                size: 20,
              ))),
    );
  }

  //Aqui llamamos al metodo para cargar los eventos que tenemos reservados
  Padding cargarMisEventos(Event evento) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: InkWell(
              child: Card( //Creamos una carta para presentar los eventos
                color: Colors.black12,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.white,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min, //Con el axisSize le decimos que la columna ocupe lo minimo
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded( //Expandimos el row a lo ancho de la pantalla
                            child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            evento.idCalendario!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.yellow),
                            textAlign: TextAlign.center,
                          ),
                        )),
                      ],
                    ),
                    Padding( // Añadimos un padding al contenido
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.event,
                                        color: Colors.white
                                      ),
                                      const Text(
                                        "Fecha de la reserva: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(evento.fecha.toString().trim(), style: TextStyle(color: Colors.white),),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        color: Colors.white,
                                      ),
                                      const Text(
                                        "Nombre de la localidad: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(evento.localidad.toString(), overflow: TextOverflow.ellipsis, maxLines: 3, softWrap: false,
                                          style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  //Obtenemos los datos del usuario que ha iniciado sesión para poder trabajar con ellos
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

  //Inicializamos los datos de manera temporal
  setUserValues(){
    if (user.nombre==null && user.apellidos==null && user.telefono==null){
      user.nombre = 'Nombre';
      user.apellidos = 'Apellidos';
      user.telefono = 'Telefono';
    } 
  }
  
}
