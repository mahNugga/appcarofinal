import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import './pantallas/servicios_over_screen.dart';
import './pantallas/servicio_detalle_screen.dart';
import './providers/servicios.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Servicios(),
      child: MaterialApp(
        title: 'AppCaro',
        theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.amber,
          fontFamily: 'Lato',
        ),
        home: ServiciosOverScreen(),
        routes: {
          ServicioDetalleScreen.routeName: (ctx) => ServicioDetalleScreen(),
        },
      ),
    );
  }
}
