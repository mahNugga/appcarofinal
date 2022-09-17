import 'package:appcarofinal/pantallas/servicio_detalle_screen.dart';
import 'package:appcarofinal/pantallas/servicios_over_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:intl/intl.dart';

class BienvenidaScreen extends StatelessWidget {
  //const BienvenidaScreen({Key? key}) : super(key: key);
  static const routeName = '/hi';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carolina Aguirre'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(25),
            child: Row(
              children: [
                Text('Bievenido '),
                Text(''),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Text('Feliz '),
                Text(''),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pushNamed(ServiciosOverScreen.routeName);
            },
            icon: Icon(Icons.add_shopping_cart),
            label: Text('Servicios'),
          ),
          SizedBox(
            height: 25,
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.add_location_rounded),
            label: Text('Localizacion'),
          ),
        ],
      ),
    );
  }
}
