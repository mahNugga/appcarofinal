import '../providers/reservas.dart';

import '../providers/auth.dart';

import '../widgets/botoncito.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../widgets/cliente_reserva.dart';

class ReservasClienteScreen extends StatefulWidget {
  const ReservasClienteScreen({Key? key}) : super(key: key);

  static const routeName = '/reservas-cliente';

  @override
  State<ReservasClienteScreen> createState() => _ReservasClienteScreenState();
}

class _ReservasClienteScreenState extends State<ReservasClienteScreen> {
  var _isInit = true;
  var _isloading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isloading = true;
      });
      final cid =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      Provider.of<Reservas>(context)
          .traerReservas(cid['cid'], cid['fecha'])
          .then((_) {
        setState(() {
          _isloading = false;
        });
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final reservasData = Provider.of<Reservas>(context);
    //List listadoReservas = [];
    //listadoReservas =
    //Provider.of<Reservas>(context, listen: false).traerReservas() as List;
    //var listareserva = reservasData.traerReservas();
    //print(reservasData.reservasDetalle.length);
    //print(listareserva);
    //final reservas = reservasData.reservasDetalle;
    //print(reservas[0].servicionombre);
    var reserva = reservasData.reservasDetalle;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de Reservas'),
        /* actions: <Widget>[
            IconButton(onPressed: () {}, icon: Icon(Icons.clear_outlined))
          ], */
      ),
      drawer: Botoncito(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
            itemCount: reserva.length,
            itemBuilder: (_, i) => ClienteReserva(
                  reserva[i].servicionombre,
                  'images/logoCorteCabello2.png',
                  reserva[i].reservahora,
                  reserva[i].reserva_id,
                )),
      ),
      /* child: ListView.builder(
              itemCount: reservasData.reservasDetalle.length,
              itemBuilder: (_,i)=>), */
    );
  }
}
