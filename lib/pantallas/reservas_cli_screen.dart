import '../providers/reservas.dart';

import '../providers/auth.dart';

import '../widgets/botoncito.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import '../widgets/cliente_reserva.dart';

class ReservasClienteScreen extends StatelessWidget {
  const ReservasClienteScreen({Key? key}) : super(key: key);

  static const routeName = '/reservas-cliente';

  @override
  Widget build(BuildContext context) {
    final reservasData = Provider.of<Reservas>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detalle de Reservas'),
          actions: <Widget>[
            IconButton(onPressed: () {}, icon: Icon(Icons.clear_outlined))
          ],
        ),
        drawer: Botoncito(),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
              itemCount: reservasData.reservasDetalle.length,
              itemBuilder: (_, i) => ClienteReserva(
                  reservasData.reservasDetalle[i].servicionombre,
                  'images/logoCorteCabello2.png')),
          /* child: ListView.builder(
              itemCount: reservasData.reservasDetalle.length,
              itemBuilder: (_,i)=>), */
        ));
  }
}
