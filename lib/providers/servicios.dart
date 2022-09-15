import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './servicio.dart';

class Servicios with ChangeNotifier {
  /* List<Servicio> _items = [
   Servicio(
      id: '1',
      nombre: 'Corte Rusosky',
      descripcion: 'For the MotherLand!',
      hora: '9 min',
      precio: '2',
      imageUrl: 'images/logoCorteCabello2.png',
    ),
    Servicio(
      id: '2',
      nombre: "manicurie",
      descripcion: 'eso que se hace en las uñas',
      hora: '25',
      precio: '25',
      imageUrl: 'images/logoCorteCabello2.png',
    ),
    Servicio(
      id: '3',
      nombre: 'corte Caballero',
      descripcion: 'vieja guardia',
      hora: '10',
      precio: '5',
      imageUrl: 'images/logoCorteCabello2.png',
    ),
    Servicio(
      id: '4',
      nombre: 'corte Nengoso',
      descripcion: 'la moda',
      hora: '45',
      precio: '40',
      imageUrl: 'images/logoCorteCabello2.png',
    ), 
  ]; */

  /* var showFavoritos = false; */

  List<Servicio> _dbitems = [];
  Future<List> listaServicios() async {
    var url = Uri.http('localhost:3700', '/api/consulta-servicio');
    try {
      var response = await http.get(url);
      print(json.decode(response.body));
      var data = json.decode(response.body) as Map<String, dynamic>;
      data.forEach((key, value) {
        if (key == 'listaServicio') {
          print('buenaaaaa');
          List vec = value;
          vec.forEach((et) {
            _dbitems.add(Servicio(
              id: et['id'].toString(),
              nombre: et['nombre'].toString(),
              descripcion: et['descripcion'].toString(),
              hora: et['hora'].toString(),
              precio: et['precio'].toString(),
              imageUrl: 'images/logoCorteCabello2.png',
            ));
          });
        }
      });
      _dbitems.forEach((element) {
        print(element.id);
        print(element.imageUrl);
      });
    } catch (er) {
      print('el mistake');
      print(er);
    } finally {
      return _dbitems;
    }
  }

  List<Servicio> get dbitems {
    /* var url = Uri.http('localhost:3700', '/api/consulta-servicio');
    try {
      var response = await http.get(url);
      print(json.decode(response.body));
      var data = json.decode(response.body) as Map<String, dynamic>;
      data.forEach((key, value) {
        if (key == 'listaServicio') {
          print('buenaaaaa');
          List vec = value;
          vec.forEach((et) {
            _dbitems.add(Servicio(
              id: et['id'].toString(),
              nombre: et['nombre'].toString(),
              descripcion: et['descripcion'].toString(),
              hora: et['hora'].toString(),
              precio: et['precio'].toString(),
              imageUrl: 'images/logoCorteCabello2.png',
            ));
          });
        }
      });
      _dbitems.forEach((element) {
        print(element.id);
        print(element.imageUrl);
      });
    } catch (er) {
      print('el mistake');
      print(er);
    } */

    return [..._dbitems];
  }

  /* List<Servicio> get items {
    /* var url = Uri.parse('http://localhost:3700/api/consulta-servicio');
    http.get(url, headers: {'Content-Type': 'application/json'}).then((value) {
      print(value.body);
      _dbitems = (value.body as List<Servicio>);
      print(_dbitems);
    }); */
    /* if (showFavoritos) {
      return _items.where((element) => element.isFavorite).toList();
    } */
    return [..._items];
  } */

  /* Future<List<Servicio>> get dbitems async {
    var url = Uri.parse('http://localhost:3700/api/consulta-servicio');
    _dbitems =await http.get(url, headers: {'Content-Type': 'application/json'}).then((value) {
      /* print(value.body);
      //_dbitems = (value.body as List<Servicio>);
      print(_dbitems); */
    });
    return [..._dbitems];
  } */
  /* void showFavoritosonly() {
    showFavoritos = true;
    notifyListeners();
  }

  void showTodos() {
    showFavoritos = false;
    notifyListeners();
  } */

  Future<void> traeServicios() async {
    var url = Uri.http('localhost:3909', '/api/consulta-servicio');
    try {
      var response = await http.get(url);
      print(response);
      var data = json.decode(response.body) as Map<String, dynamic>;
      List<Servicio> jinx = [];
      data.forEach((key, value) {
        print('iniciando desde provider metod calling extranio');
        if (key == 'listaServicio') {
          List vec = value;
          vec.forEach((mt) {
            print('otro intento de loading!');

            jinx.add(Servicio(
              id: mt['id'].toString(),
              nombre: mt['nombre'].toString(),
              descripcion: mt['descripcion'].toString(),
              hora: mt['hora'].toString(),
              precio: mt['precio'].toString(),
              imageUrl: 'images/logoCorteCabello2.png',
            ));
          });
        }
      });
      _dbitems = jinx;
      print('los resultados son');
      _dbitems.forEach((element) {
        print(element.id);
        print(element.nombre);
      });
      notifyListeners();
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future<void> Reservar(empleadoid, servicioid, sernom, hora) async {
    var horadb = hora.toString();
    var horafix = horadb.substring(10, 12);
    print('las variables son:');
    print(empleadoid + ',' + servicioid + ',' + sernom + ',' + horafix);
    var url = Uri.http('localhost:3909', '/api/reservar');
    try {
      var res = http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'cabecera': '',
            'notas': 'android.API-30',
            'mensaje': '',
            'fechaseleccion': DateTime.now().toString(),
            'hora': horafix,
            'descuento': 0.00,
            'subtotal': 0.00,
            'iva': 12,
            'total': 0,
            'fecha_creado': DateTime.now().toString(),
            'servicio_id': servicioid,
            'empleado_id': empleadoid,
            'cliente_id': 1,
            'estado_id': 1,
          }));
    } catch (err) {
      print('el error del post:');
      print(err);
    }
  }

  List<Servicio> get favoriteItems {
    return _dbitems.where((servitem) => servitem.isFavorite).toList();
  }

  Servicio findById(String id) {
    return _dbitems.firstWhere((serv) => serv.id == id);
  }

  void addServicio() {
/*     _items.add(value);
 */
    notifyListeners();
  }
}
