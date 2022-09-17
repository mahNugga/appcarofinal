import 'package:appcarofinal/pantallas/auth_screen.dart';
import 'package:appcarofinal/pantallas/bondia.dart';
import 'package:appcarofinal/pantallas/servicios_over_screen.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/auth.dart';
import '../pantallas/reservas_cli_screen.dart';

class Botoncito extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var date = new DateTime.now();
    final fecha = DateFormat('yyyy-MM-dd').format(date);
    final cid = Provider.of<Auth>(context).userid;
    final user = Provider.of<Auth>(context, listen: false).nombrecli;
    final usersec = Provider.of<Auth>(context).apellidocli;
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Enlaces rapidos'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.cut_outlined),
            title: Text('Servicios'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ServiciosOverScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.request_quote),
            title: Text('Reservas'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                  ReservasClienteScreen.routeName,
                  arguments: {'cid': cid, 'fecha': fecha});
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.request_quote),
            title: Text('Inicio'),
            onTap: () {
              Navigator.of(context).pushNamed(
                BienvenidaScreen.routeName,
              );
            },
          ),
          /* Divider(),
          ListTile(
            leading: Icon(Icons.key_outlined),
            title: Text('Salir'),
            onTap: () {
              Provider.of<Auth>(context, listen: false).logout();
              /* Navigator.of(context).pushReplacementNamed(''); */
            },
          ), */
        ],
      ),
    );
  }
}
