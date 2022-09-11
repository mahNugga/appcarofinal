import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import './servicio_item.dart';
import 'package:provider/provider.dart';
import '../providers/servicios.dart';

class ServiciosGrid extends StatelessWidget {
  final bool showFavs;

  ServiciosGrid(this.showFavs);
  @override
  Widget build(BuildContext context) {
    final serviciosData = Provider.of<Servicios>(context);
    final servicios =
        showFavs ? serviciosData.favoriteItems : serviciosData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: servicios.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: servicios[index],
        child: ServicioItem(
            /* servicios[index].id,
        servicios[index].nombre,
        servicios[index].imageUrl, */
            ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 10,
      ),
    );
  }
}
