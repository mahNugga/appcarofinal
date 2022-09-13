import 'package:flutter/foundation.dart';

class Servicio with ChangeNotifier {
  final String id;
  final String nombre;
  final String descripcion;
  final String hora;
  final String precio;
  final num estado;
  final String imageUrl;
  bool isFavorite;

  Servicio({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.hora,
    required this.precio,
    this.estado = 1,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
