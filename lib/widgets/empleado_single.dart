import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:provider/provider.dart';
import '../providers/reservas.dart';
import '../providers/servicios.dart';
import '../providers/auth.dart';
import '../pantallas/servicios_over_screen.dart';

class EmpleadoLista extends StatefulWidget {
  final String nombreemp;
  final String empleado_id;
  final String servicio_id;
  final String servicionombre;
  final DateTime fechaelegida;
  EmpleadoLista(
    this.nombreemp,
    this.empleado_id,
    this.servicio_id,
    this.servicionombre,
    this.fechaelegida,
  );

  @override
  State<EmpleadoLista> createState() => _EmpleadoListaState();
}

class _EmpleadoListaState extends State<EmpleadoLista> {
  //get empleado_id => null;
  var horaneo;
  void ProcedeReserva(
    empleado_id,
    servicio_id,
    sernom,
    hora,
    fecha,
  ) {
    final clid = Provider.of<Auth>(context, listen: false).userid;
    Provider.of<Servicios>(context, listen: false)
        .Reservar(
      empleado_id,
      servicio_id,
      sernom,
      hora,
      fecha,
      clid,
    )
        .then((_) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('Felicitaciones'),
                content: Text("Su reserva ha sido procesada con exito"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(ServiciosOverScreen.routeName);
                    },
                    child: Text('Entendido'),
                  )
                ],
              ));
    });
  }

  void _presentHoraPicker() {
    TimeOfDay time = TimeOfDay(hour: 10, minute: 00);
    showTimePicker(
      context: context,
      initialTime: time,
    ).then((pickles) {
      if (pickles == null) {
        return;
      }
      setState(() {
        horaneo = pickles;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    TimeOfDay time = TimeOfDay(hour: 10, minute: 00);
    return Container(
      width: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Card(
              elevation: 3,
              color: Colors.deepPurple,
              child: Text(
                widget.nombreemp,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              )),
          Text(
            '',
          ),
          /* Text(
            '${time.hour}',
            style: TextStyle(fontSize: 20),
          ), */
          IconButton(
            onPressed: _presentHoraPicker,
            icon: Icon(Icons.lock_clock),
          ),
          ElevatedButton(
            onPressed: () => ProcedeReserva(
                widget.empleado_id,
                widget.servicio_id,
                widget.servicionombre,
                horaneo, //,
                widget.fechaelegida),
            child: Text("R e s e r v a r"),
          ),
        ],
      ),
    );
    //return Consumer<Empleado>(builder: (context, e, child) => ,);
  }
}
