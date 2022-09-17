import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/reservas.dart';

class ClienteReserva extends StatelessWidget {
  //const ClienteReserva({Key? key}) : super(key: key);

  final String title;
  final String id;
  final String imageUrl;
  final String hora;
  ClienteReserva(this.title, this.imageUrl, this.hora, this.id);

  @override
  Widget build(BuildContext context) {
    void eliminador(id) {
      Provider.of<Reservas>(context).chaoReserva(id);
    }

    return ListTile(
      title: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Text(
                  'Servicio : ',
                  style: TextStyle(
                      wordSpacing: 2,
                      color: Colors.indigo[900],
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  title,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 9.0),
            child: Row(
              children: [
                Text(
                  'Hora Reserva :',
                  style: TextStyle(
                      color: Colors.indigo[900],
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  hora,
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          )
        ],
      ),
      leading: CircleAvatar(
          backgroundImage: AssetImage('images/logoCorteCabello2.png')),
      trailing: IconButton(
        icon: Icon(Icons.accessibility_sharp),
        onPressed: () {},
        color: Colors.redAccent,
      ),
    );
  }
}
