import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Reservainfo {
  final String id;
  final String empleado_id;
  final String cliente_id;
  final String servicio_id;
  final num hora;
  final String fecha;
  final double total;

  Reservainfo({
    required this.id,
    required this.empleado_id,
    required this.cliente_id,
    required this.servicio_id,
    required this.hora,
    required this.fecha,
    required this.total,
  });
}

class ReservaCliente {
  String reserva_id;
  String cliente_id;
  String reservahora;
  String servicionombre;
  ReservaCliente({
    required this.reserva_id,
    required this.cliente_id,
    required this.reservahora,
    required this.servicionombre,
  });
}

class Empleado {
  final String id;
  final String nombre;
  final String apellido;
  final String estado;

  Empleado({
    required this.id,
    required this.nombre,
    required this.apellido,
    this.estado = "",
  });
}

class EmpleadoReserva with ChangeNotifier {
  String id;
  String nombre;
  String apellido;
  String horaini;
  String horafin;
  EmpleadoReserva({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.horaini,
    required this.horafin,
  });
}

class Reservas with ChangeNotifier {
  List<EmpleadoReserva> empleadosDisp = [];
  Future<void> addEmpleado() async {
    var url = Uri.parse('http://localhost:3909/api/lista-empleado-gen');
    try {
      var response = await http.get(url);
      print(json.decode(response.body));
      //print('Ahora la response sin el decode de JSON');
      //print(response.body);
      var datos = json.decode(response.body) as Map<String, dynamic>;
      List loadeddata = [];
      /* datos.forEach((key, value) {
        loadeddata.add(Empleado(
            id: value['id'],
            nombre: value['nombre'],
            apellido: value['apellido'],
            estado: value['estado']));
      }); */
      var interdatos = datos;
      print('Inicio del foreach de interdatos');
      interdatos.forEach((key, value) {
        //print(key);
        //print('in between key and value');
        if (key == 'listaSinrangos7') {
          print('daleeeeeeeeeee guachoooooooo');
          print(value);
          List vec = value;
          print('y ahorrrrraaaaaaaaaaaaaaaaaaa guachooooooooo');
          vec.forEach((et) {
            print(et);
            loadeddata.add(Empleado(
                id: et['id'].toString(),
                nombre: et['nombre'].toString(),
                apellido: et['apellido'].toString(),
                estado: et['estado'].toString()));
          });
        }
        //print(value);
      });

      /* print(datos.keys);
      print(loadeddata);
      print(datos.entries);
      
      print(datos.values.length); */
      loadeddata.forEach((element) {
        print(element.id);
      });
    } catch (er) {
      throw er;
    }
  }

  Future<void> matchfechas(DateTime fecha) async {
    var f = fecha.toString().substring(0, 10);
    print(fecha.toString().substring(0, 10));
    var url =
        Uri.http('localhost:3909', '/api/verifica-fechas', {'fechaing': f});

    try {
      var response = await http.get(url);
      //print(json.decode(response.body));
      //print(response);
      print('la respuesta completa');
      print(json.decode(response.body));
      var data = json.decode(response.body) as Map<String, dynamic>;
      List<EmpleadoReserva> jinx = [];
      data.forEach((key, value) {
        if (key == 'fechin') {
          print('vamos bien');
          List vec = value;
          vec.forEach((et) {
            //print(et);
            jinx.add(EmpleadoReserva(
              id: et['empleado_id'].toString(),
              nombre: et['empnombre'].toString(),
              apellido: et['apellido'].toString(),
              horaini: et['hora_inicio'].toString(),
              horafin: et['hora_fin'].toString(),
            ));
          });
        }
      });
      empleadosDisp = jinx;
      print('salimos');
      empleadosDisp.forEach((element) {
        print('emtramossss');
        print(element.id);
        print(element.nombre);
      });
      notifyListeners();
      //return empleadosDisp;
    } catch (er) {
      print(er);
      throw er;
    }
  }

  List<ReservaCliente> reservasDetalle = [];
  Future<void> traerReservas(id, fecha) async {
    print('parametros reserva' + id + fecha);
    var url = Uri.http('localhost:3909', '/api/consulta-reservacioncliente2',
        {'id': id, 'fecha': fecha});
    try {
      var response = await http.get(url);
      print(json.decode(response.body));
      var data = json.decode(response.body) as Map<String, dynamic>;
      List<ReservaCliente> jinx = [];
      data.forEach((key, value) {
        if (key == 'resecliente') {
          List vec = value;
          vec.forEach((ment) {
            print('reservas');
            print(ment);
            jinx.add(ReservaCliente(
              reserva_id: ment['id'].toString(),
              cliente_id: ment['cliente_id'].toString(),
              reservahora: ment['hora'].toString() + ':00',
              servicionombre: ment['servnom'].toString(),
            ));
          });
        }
      });
      reservasDetalle = jinx;
      jinx.forEach((element) {
        print('elementos detalle reservas');
        print(element.servicionombre);
        notifyListeners();
      });
    } catch (err) {
      print(err);
    }
  }

  Future<void> chaoReserva(id) async {
    print('');
    var url = Uri.http('localhost:3909', '/api/eliminar-reservacli');
    try {
      var res = http.put(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'id': id,
            'estado_id': 3,
          }));
      reservasDetalle.removeWhere((element) => element.reserva_id == id);
      notifyListeners();
    } catch (err) {
      print(err);
    }
  }
}
