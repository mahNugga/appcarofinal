import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem(
    String servicioid,
    double price,
    String nombre,
  ) {
    if (_items.containsKey(servicioid)) {
      _items.update(
          servicioid,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                price: existingCartItem.price,
                quantity: existingCartItem.quantity + 1,
              ));
    } else {
      _items.putIfAbsent(
        servicioid,
        () => CartItem(
          id: DateTime.now().toString(),
          title: nombre,
          price: price,
          quantity: 1,
        ),
      );
    }
  }
}
