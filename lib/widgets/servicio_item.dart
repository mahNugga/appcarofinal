import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pantallas/servicio_detalle_screen.dart';
import '../providers/servicio.dart';

class ServicioItem extends StatelessWidget {
  /* final String id;
  final String nombre;
  final String imageUrl;

  ServicioItem(this.id, this.nombre, this.imageUrl); */

  @override
  Widget build(BuildContext context) {
    //final serv = Provider.of<Servicio>(context);
    return Consumer<Servicio>(
      builder: (ctx, s, child) => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          footer: GridTileBar(
            leading: IconButton(
              onPressed: () {
                s.toggleFavorite();
              },
              icon: Icon(
                s.isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
            ),
            backgroundColor: Colors.black87,
            title: Text(
              s.nombre,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.face_retouching_natural_sharp),
              color: Theme.of(context).accentColor,
            ),
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                ServicioDetalleScreen.routeName,
                arguments: s.id,
              );
            },
            child: Image(
              image: AssetImage(s.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
