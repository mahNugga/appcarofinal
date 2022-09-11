import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/servicios.dart';

class ServicioDetalleScreen extends StatelessWidget {
  /* final String nombre;

  ServicioDetalleScreen(this.nombre); */
  static const routeName = '/servicio-detalle';
  @override
  Widget build(BuildContext context) {
    final servicioid = ModalRoute.of(context)!.settings.arguments as String;
    //... all
    final loadedServicio = Provider.of<Servicios>(
      context,
      listen: false,
    ).findById(servicioid);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedServicio.nombre),
      ),
    );
  }
}
