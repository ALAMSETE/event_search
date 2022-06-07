import 'dart:io';
import 'dart:convert';
import 'package:event_search/modelos/event.dart';
import 'package:http/http.dart' as http;
import 'package:event_search/modelos/usuarios.dart';

class Conexion {
  final String domain = 'http://iesayala.ddns.net/alamsete/';

  //Este método es el encargado de cargar las procesiones
  /*Future<List<Procesion>> getProcesiones() async {
    HttpOverrides.global = MyHttpOverrides();

    String url = domain + 'selectCofradias.php';

    http.Response response = await http.get(Uri.parse(url));
    late List<Procesion> procesionesList;
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      procesionesList =
          data.map<Procesion>((e) => Procesion.fromJson(e)).toList();
    }
    return procesionesList;
  }*/

  //Comprueba si las credenciales del usuario son correctas
  Future<bool> canLogin(String dni, String contrasenia) async {
    HttpOverrides.global = MyHttpOverrides();
    String url =
        domain + "selectLogin.php?dni='" + dni + "'&contrasenia='" + contrasenia + "'";

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data[0]['existe'] == '1') {
        return true;
      }
    }
    return false;
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
        '"&telefono="'+
        usuario.telefono.toString()+
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

  Future<bool> insertCalendario(Event evento) async {
    HttpOverrides.global = MyHttpOverrides();
    String url = domain +
        'insertCalendario.php?idCalendario="' +
        evento.idCalendario.toString() +
        '"&fechaEvento="' +
        evento.fecha.toString() +
        '"&nomLocalidad="' +
        evento.localidad.toString()+
        '"';
        print("url: "+url);
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 &&
        response.body.toString().trim().isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<String>> getEventos() async {
    HttpOverrides.global = MyHttpOverrides();
    var url = domain+'selectEvento.php';

    http.Response response = await http.get(Uri.parse(url));

    List<String> result = [];

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      for(var nomOrquesta in data){
        result.add(nomOrquesta['nomEvento']);
      }
    }

    return result;
  }

  Future<List<String>> getLocalidades() async {
    HttpOverrides.global = MyHttpOverrides();
    var url = domain+'selectLocalidad.php';

    http.Response response = await http.get(Uri.parse(url));

    List<String> result = [];

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      for(var nomLocalidad in data){
        result.add(nomLocalidad['nomLocalidad']);
      }
    }

    return result;
  }

  //Obtiene los datos de un hermano mediante su dni
  /*Future<Usuario> getHermano(String dni) async {
    HttpOverrides.global = MyHttpOverrides();
    Uri url = Uri.parse(domain + 'selectUsuario.php?dni=' + dni);

    http.Response response = await http.get(url);
    Usuario usuario = Usuario();
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      usuario.dni = data[0]['dni'];
      usuario.nombre = data[0]['nombre'];
      usuario.apellidos = data[0]['apellidos'];
      usuario.contrasenia = data[0]['contrasenia'];
      usuario.telefono = data[0]['telefono'];
    }
    return usuario;
  }

  //Ejecuta la consulta encargada de modificar los datos de un 'hermano'
  Future<bool> updateHermano(Usuario usuario) async {
    HttpOverrides.global = MyHttpOverrides();
    String url = domain +
        'updateUsuario.php?idHermano="' +
        usuario.idHermano.toString() +
        '"&nombre="' +
        usuario.nombre.toString() +
        '"&apellidos="' +
        usuario.apellidos.toString() +
        '"&dni="' +
        usuario.dni.toString() +
        '"&password="' +
        usuario.password.toString() +
        '"&telefono=' +
        usuario.telefono.toString();
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 &&
        response.body.toString().trim().isNotEmpty) {
      return true;
    }
    return false;
  }

  //Ejecuta la consulta encargada de eliminar un 'hermano'
  Future<bool> deleteHermano(Hermano hermano) async {
    HttpOverrides.global = MyHttpOverrides();
    String url =
        domain + 'deleteHermano.php?idHermano=' + hermano.idHermano.toString();
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 &&
        response.body.toString().trim().isNotEmpty) {
      return true;
    }
    return false;
  }

  //Obtiene los datos necesario para generar un QR con los datos
  //del idHermano indicado
  Future<Qr> getQr(String idHermano) async {
    HttpOverrides.global = MyHttpOverrides();
    Uri url = Uri.parse(domain + 'selectQr.php?idHermano=' + idHermano);
    http.Response response = await http.get(url);
    Qr qrCode = Qr();
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      qrCode.usuario = data[0]['usuario'];
      qrCode.cofradia = data[0]['cofradia'];
      qrCode.antiguedad = data[0]['antiguedad'];
      qrCode.posicion = data[0]['posicion'];
      qrCode.fecha = data[0]['fecha'];
    }
    return qrCode;
  }

  //Obtiene la localización actual de la cofradía
  Future<List<String>> getLocationProcesion(String idCofradia) async {
    HttpOverrides.global = MyHttpOverrides();
    Uri url = Uri.parse(
        domain + 'selectLocationCofradia.php?idCofradia=' + idCofradia);
    http.Response response = await http.get(url);
    List<String> localizacion = [];

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      localizacion.add(data[0]['altitud']);
      localizacion.add(data[0]['latitud']);
    }
    return localizacion;
  }*/
}

//Clase necesaria para generar las consutas a la base de datos debido a que la conexion no esta certificada, por lo que debemos
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}