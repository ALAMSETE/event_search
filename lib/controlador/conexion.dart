import 'dart:io';
import 'dart:convert';
import 'package:event_search/modelos/event.dart';
import 'package:http/http.dart' as http;
import 'package:event_search/modelos/usuarios.dart';

class Conexion {
  final String domain = 'http://iesayala.ddns.net/alamsete/';

  //Comprueba si las credenciales del usuario son correctas
  Future<bool> canLogin(String dni, String contrasenia) async {
    HttpOverrides.global = MyHttpOverrides();
    String url = domain +
        "selectLogin.php?dni='" +
        dni +
        "'&contrasenia='" +
        contrasenia +
        "'";

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data[0]['existe'] == '1') {
        return true;
      }
    }
    return false;
  }

  //Con este metodo comprobamos si el dia en el que queremos reservar esta ocupado o no
  Future<bool> canInsert(String fecha, String idCalendario) async {
    HttpOverrides.global = MyHttpOverrides();
    String url = domain +
        "selectCalendario.php?fechaEvento='" +
        fecha +
        "'&idCalendario='" +
        idCalendario +
        "'";

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data[0]['ocupado'] == '0') {
        return true;
      }
    }
    return false;
  }

  //Con este metodo obtendremos los eventos que hemos reservado
  Future<List<Event>> getMisEventos(String dni) async {
    HttpOverrides.global = MyHttpOverrides();

    String url = domain + 'selectMisEventos.php?dniRes="'+dni+'"';

    http.Response response = await http.get(Uri.parse(url));
    late List<Event> listaMisEventos;
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      listaMisEventos =
          data.map<Event>((e) => Event.fromJson(e)).toList();
    }
    return listaMisEventos;
  }

  //Ejecuta la consuta necesaria para dar de alta un usuario, pasandole
  //por parametros un objeto 'usuario'
  Future<bool> insertUsuario(Usuario usuario) async {
    HttpOverrides.global = MyHttpOverrides();
    String url = domain +
        'insertUsuario.php?nombre="' +
        usuario.nombre.toString() +
        '"&apellidos="' +
        usuario.apellidos.toString() +
        '"&dni="' +
        usuario.dni.toString() +
        '"&contrasenia="' +
        usuario.contrasenia.toString() +
        '"&telefono="' +
        usuario.telefono.toString() +
        '"';
    //print("url: "+url);
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 &&
        response.body.toString().trim().isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
  // Con este metodo podemos insertar una reserva pasando como parametro un evento
  Future<bool> insertCalendario(Event evento) async {
    HttpOverrides.global = MyHttpOverrides();
    String url = domain +
        'insertCalendario.php?idCalendario="' +
        evento.idCalendario.toString() +
        '"&fechaEvento="' +
        evento.fecha.toString() +
        '"&nomLocalidad="' +
        evento.localidad.toString() +
        '"&dniRes="' +
        evento.dniRes.toString() +
        '"';
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 &&
        response.body.toString().trim().isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
  //Con este metodo podemos obtener todos los eventos.
  Future<List<String>> getEventos() async {
    HttpOverrides.global = MyHttpOverrides();
    var url = domain + 'selectEvento.php';

    http.Response response = await http.get(Uri.parse(url));

    List<String> result = [];

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      for (var nomOrquesta in data) {
        result.add(nomOrquesta['nomEvento']);
      }
    }

    return result;
  }

  // Metodo que se encarga de obtener de las localidades de la base de datos externa
  Future<List<String>> getLocalidades() async {
    HttpOverrides.global = MyHttpOverrides();
    var url = domain + 'selectLocalidad.php';

    http.Response response = await http.get(Uri.parse(url));

    List<String> result = [];

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      for (var nomLocalidad in data) {
        result.add(nomLocalidad['nomLocalidad']);
      }
    }

    return result;
  }

  // Metodo que se encarga de realizar una actualización del nombre del usuario de la base de datos externa
  Future<bool> updateUserNom(String nombre, String dni) async {
    HttpOverrides.global = MyHttpOverrides();
    String url =
        domain + 'updateUserNom.php?nombre="' + nombre + '"&dni="' + dni + '"';
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 &&
        response.body.toString().trim().isNotEmpty) {
      return true;
    }
    return false;
  }

  // Metodo que se encarga de realizar una actualización de los apellidos del usuario de la base de datos externa
  Future<bool> updateUserApell(String apellidos, String dni) async {
    HttpOverrides.global = MyHttpOverrides();
    String url =
        domain + 'updateUserApell.php?apellidos="' + apellidos + '"&dni="' + dni + '"';
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 &&
        response.body.toString().trim().isNotEmpty) {
      return true;
    }
    return false;
  }

  // Metodo que se encarga de realizar una actualización del telfono del usuario de la base de datos externa
  Future<bool> updateUserTel(String telefono, String dni) async {
    HttpOverrides.global = MyHttpOverrides();
    String url =
        domain + 'updateUserTel.php?telefono="' + telefono + '"&dni="' + dni + '"';
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 &&
        response.body.toString().trim().isNotEmpty) {
      return true;
    }
    return false;
  }

  //Obtiene los datos de un hermano mediante su dni
  Future<Usuario> getUsuario(String dni) async {
    HttpOverrides.global = MyHttpOverrides();
    Uri url = Uri.parse(domain + 'selectUsuario.php?dni=' + dni);
    http.Response response = await http.get(url);
    Usuario usuario = Usuario();

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      usuario.dni = data[0]['dni'].toString();
      usuario.nombre = data[0]['nombre'].toString();
      usuario.apellidos = data[0]['apellidos'].toString();
      usuario.contrasenia = data[0]['contrasenia'].toString();
      usuario.telefono = data[0]['telefono'].toString();
    }
    
    return usuario;
  }

  //Este método es el encargado de cargar las procesiones
  Future<List<Event>> getProcesiones() async {
    HttpOverrides.global = MyHttpOverrides();

    String url = domain + 'selectCofradias.php';

    http.Response response = await http.get(Uri.parse(url));
    late List<Event> procesionesList;
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      procesionesList =
          data.map<Event>((e) => Event.fromJson(e)).toList();
    }
    return procesionesList;
  }

}

//Clase necesaria para generar las consutas a la base de datos ya que la conexion no es "segura"
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
