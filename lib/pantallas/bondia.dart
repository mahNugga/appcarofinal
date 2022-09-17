import '../pantallas/servicios_over_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class BienvenidaScreen extends StatelessWidget {
  //const BienvenidaScreen({Key? key}) : super(key: key);
  static const routeName = '/hi';
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('es_ES', '');
    final datos = Provider.of<Auth>(context, listen: false);
    final data = Provider.of<Auth>(context).apellidocli;
    final dia = DateTime.now();
    final fechafix = DateFormat('MM-yyyy').format(dia);
    final diafix = DateFormat.EEEE('es_ES').format(dia);

    print('los params');
    print(datos.nombrecli);
    print(data);
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
                Text('${data} - ${datos.nombrecli}'),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Text('Feliz '),
                Text('${diafix}'),
                Text('--'),
                Text('${fechafix}'),
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
