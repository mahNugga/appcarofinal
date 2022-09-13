import '../pantallas/reserva_screen.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/servicio.dart';
import '../providers/servicios.dart';

class ServicioDetalleScreen extends StatelessWidget {
  /* final String nombre;

  ServicioDetalleScreen(this.nombre); */
  static const routeName = '/servicio-detalle';
  @override
  Widget build(BuildContext context) {
    print('que paso');
    final servicioid = ModalRoute.of(context)!.settings.arguments as String;
    //... all
    final loadedServicio = Provider.of<Servicios>(
      context,
      listen: false,
    ).findById(servicioid);
    print('secuencia');
    print(servicioid);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedServicio.nombre),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image(
                image: AssetImage(loadedServicio.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '\$ ${loadedServicio.precio}',
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  loadedServicio.descripcion,
                  textAlign: TextAlign.center,
                  softWrap: true,
                )),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, ReservaScreen.routeName,
                    arguments: Servicio(
                        id: servicioid,
                        nombre: loadedServicio.nombre,
                        descripcion: loadedServicio.descripcion,
                        hora: loadedServicio.hora,
                        precio: loadedServicio.precio,
                        imageUrl: 'images/logoCorteCabello2.png'));
              },
              child: Text("Reservar"),
            )
          ],
        ),
      ),
    );
  }
}
