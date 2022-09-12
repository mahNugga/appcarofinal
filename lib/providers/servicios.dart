import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './servicio.dart';

class Servicios with ChangeNotifier {
  List<Servicio> _items = [
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
  ];

  /* var showFavoritos = false; */

  List<Servicio> _dbitems = [];
  Future<void> listaServicios() async {
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
    }
  }

  List<Servicio> get dbitems {
    listaServicios();
    return [..._dbitems];
  }

  List<Servicio> get items {
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
  }

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
  List<Servicio> get favoriteItems {
    return _items.where((servitem) => servitem.isFavorite).toList();
  }

  Servicio findById(String id) {
    return _items.firstWhere((serv) => serv.id == id);
  }

  void addServicio() {
/*     _items.add(value);
 */
    notifyListeners();
  }
}
