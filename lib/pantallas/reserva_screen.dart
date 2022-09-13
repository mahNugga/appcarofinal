import '../providers/servicio.dart';
import '../widgets/empleado_single.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../providers/reservas.dart';

class ReservaScreen extends StatefulWidget {
  static const routeName = '/reservar';

  @override
  State<ReservaScreen> createState() => _ReservaScreenState();
}

class _ReservaScreenState extends State<ReservaScreen> {
  var _isloading = false;
  var _isInit = true;
  var fechaneo;
  bool thor = false;
  List empleados = [];
  List empleadosDisp = [];
  @override
  void initSatate() {
    //Provider.of<Reservas>(context).addEmpleado();
  }
  @override
  void didChangeDependencies() {
    if (_isInit) {
      //Provider.of<Reservas>(context).addEmpleado();
    }
    _isInit = false;
  }

  void _presentDatePicker() {
    /* setState(() {
      thor = false;
    }); */
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2024))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        fechaneo = pickedDate;
      });
    });
  }

  void buscahorario() {
    setState(() {
      thor = true;
    });
    empleadosDisp = Provider.of<Reservas>(context, listen: false)
        .matchfechas(fechaneo) as List;
  }

  void presentaEmp() {}
  void reservar() {}
  Widget build(BuildContext context) {
    final empleadosData = Provider.of<Reservas>(context);
    final servinfo = ModalRoute.of(context)!.settings.arguments as Servicio;
    var empleados = empleadosData.empleadosDisp;
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Reserva de Servicio :${servinfo.nombre}',
        style: TextStyle(fontSize: 30),
      )),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(left: 15),
            child: Row(
              children: <Widget>[
                Text(
                  fechaneo == null
                      ? "Elija una fecha"
                      : DateFormat('yyyy-MM-dd').format(fechaneo),
                  style: TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                IconButton(
                  onPressed: _presentDatePicker,
                  icon: Icon(Icons.calendar_today_rounded),
                ),
                Container(
                  child: TextButton(
                    child: Text('Revisar Disponibilidad'),
                    onPressed: buscahorario,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                      'Empleados Disponibles'), //: Text("No datos Seleccionados!"),
                  Container(
                    height: 300,
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      padding: EdgeInsets.all(10),
                      itemCount: empleados.length,
                      itemBuilder: (context, index) =>
                          ChangeNotifierProvider.value(
                        value: empleados[index],
                        child: EmpleadoLista(
                            '${empleados[index].apellido} , ${empleados[index].nombre}',
                            empleados[index].id,
                            servinfo.id,
                            servinfo.nombre),
                      ),
                    ),
                  )
                  /*  Expanded(
                child: SizedBox(
                  height: 300,
                  width: double.infinity,
                  /* child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: empleadosDisp.length,
                    itemBuilder: (context, index) => Card(
                      elevation: 5,
                      /* child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.green,
                          child: Text('$index'),
                        ),
                        //title: Text(empleadosDisp[index]['']),
                      ), */
                    ),
                  ), */
                ),
              ), */
                ]),
          ),
        ],
      ),
    );
  }
}
