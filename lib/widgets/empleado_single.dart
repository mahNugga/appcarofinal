import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:provider/provider.dart';
import '../providers/reservas.dart';
import '../providers/servicios.dart';

class EmpleadoLista extends StatefulWidget {
  final String nombreemp;
  final String empleado_id;
  final String servicio_id;
  final String servicionombre;
  EmpleadoLista(
      this.nombreemp, this.empleado_id, this.servicio_id, this.servicionombre);

  @override
  State<EmpleadoLista> createState() => _EmpleadoListaState();
}

class _EmpleadoListaState extends State<EmpleadoLista> {
  //get empleado_id => null;

  void ProcedeReserva(
    empleado_id,
    servicio_id,
    sernom,
    hora,
  ) {
    Provider.of<Servicios>(context, listen: false).Reservar(
      empleado_id,
      servicio_id,
      sernom,
      hora,
    );
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
            '${time.hour}',
            style: TextStyle(fontSize: 20),
          ),
          IconButton(
            onPressed: () async {
              TimeOfDay? horaneo = await showTimePicker(
                context: context,
                initialTime: time,
              );
              if (horaneo == null) return;
              setState(() {
                time = horaneo;
              });
            },
            icon: Icon(Icons.lock_clock),
          ),
          ElevatedButton(
            onPressed: () => ProcedeReserva(widget.empleado_id,
                widget.servicio_id, widget.servicionombre, time),
            child: Text("R e s e r v a r"),
          ),
        ],
      ),
    );
    //return Consumer<Empleado>(builder: (context, e, child) => ,);
  }
}
