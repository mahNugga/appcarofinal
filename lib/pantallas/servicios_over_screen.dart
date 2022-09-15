import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../providers/servicios.dart';
import '../widgets/servicios_grid.dart';
import '../widgets/botoncito.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum filtroOp {
  Favoritos,
  Todos,
}

class ServiciosOverScreen extends StatefulWidget {
  @override
  State<ServiciosOverScreen> createState() => _ServiciosOverScreenState();
}

class _ServiciosOverScreenState extends State<ServiciosOverScreen> {
  var _showOnlyFavoritos = false;
  var _isInit = true;
  var _isloading = false;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isloading = true;
      });
      Provider.of<Servicios>(context).traeServicios().then((_) {
        setState(() {
          _isloading = false;
        });
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carolina Aguiree Servicios'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (filtroOp selectedValue) {
              setState(() {
                if (selectedValue == filtroOp.Favoritos) {
                  _showOnlyFavoritos = true;
                } else {
                  _showOnlyFavoritos = false;
                }
              });
            },
            icon: Icon(Icons.more_horiz),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Favoritos'),
                value: filtroOp.Favoritos,
              ),
              PopupMenuItem(
                child: Text('Todos'),
                value: filtroOp.Todos,
              ),
            ],
          )
        ],
      ),
      drawer: Botoncito(),
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ServiciosGrid(_showOnlyFavoritos),
    );
  }
}
