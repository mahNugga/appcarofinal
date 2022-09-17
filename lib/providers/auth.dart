import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token = '';
  DateTime? _expired;
  String userid = '';
  String externalToken = '';
  String nombrecli = '';
  String apellidocli = '';

  String? get token {
    if (_expired != null &&
        _expired!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  bool get isAuth {
    if (_token.isNotEmpty) {
      print(_token);
      return true;
    }
    return false;
  }

  Future<void> _authenticate(
    String email,
    String password,
    String urlseg,
  ) async {}

  Future<void> signup(
    String nombre,
    String apellido,
    String email,
    String password,
  ) async {
    var url = Uri.http('localhost:3909', '/api/nuevo-cliente');
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {
            'nombre': nombre,
            'apellido': apellido,
            'correo': email,
            'password': password
          },
        ));
    print(json.decode(response.body));
    //_token = response.body;
  }

  Future<void> login(
    String email,
    String password,
  ) async {
    try {
      var url = Uri.http('localhost:3909', '/api/ingreso');
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode(
            {'correo': email, 'password': password},
          ));
      print(json.decode(response.body));
      var data = json.decode(response.body) as Map<String, dynamic>;
      var jinx = '';
      var erpost;
      var idres;
      var nomres;
      var aperes;
      data.forEach((key, value) {
        if (key == 'token') {
          print('entramos a data');
          print(key);
          jinx = value.toString();
          /* vec.forEach((rt, t) {
            print('entro a vec');
            print(t);
            jinx = t;
          }); */
        }
        if (key == 'teller') {
          erpost = value;
        }
        if (key == 'usuariom') {
          List vec = value;
          vec.forEach((t) {
            idres = t['id'].toString();
            nomres = t['nombre'].toString();
            aperes = t['apellido'].toString();
          });
        }
      });
      /* jinx.forEach((element) {
        print(element);
      }); */
      _token = jinx;
      userid = idres;
      //_expired = DateTime.now().add(Duration(seconds: int.parse()));
      print(_token);
      print(userid);
      final result = erpost;
      notifyListeners();
      if (result == 6) {
        throw HttpException('Usuario ya existe, inicie sesion');
      }
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future<void> traerReservas() async {}

  void logout() {
    _token = '';
    _expired = null;
    userid = '';
  }
}
