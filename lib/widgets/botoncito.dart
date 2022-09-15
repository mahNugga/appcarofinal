import 'package:appcarofinal/pantallas/auth_screen.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../pantallas/reservas_cli_screen.dart';

class Botoncito extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text(''),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.cut_outlined),
            title: Text('Servicios'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.request_quote),
            title: Text('Reservas'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ReservasClienteScreen.routeName);
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
