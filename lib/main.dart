import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import './pantallas/servicios_over_screen.dart';
import './pantallas/servicio_detalle_screen.dart';
import './pantallas/reserva_screen.dart';
import './pantallas/reserva_conf.dart';
import './providers/servicios.dart';
import './providers/reservas.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      /* create: (ctx) => Servicios(), */
      providers: [
        ChangeNotifierProvider.value(
          value: Servicios(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Reservas(),
        ),
      ],
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
          ReservaConfScreen.routeName: (ctx) => ReservaConfScreen(),
          ReservaScreen.routeName: (ctx) => ReservaScreen(),
        },
      ),
    );
  }
}
