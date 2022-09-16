import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class ClienteReserva extends StatelessWidget {
  //const ClienteReserva({Key? key}) : super(key: key);

  final String title;
  final String imageUrl;
  ClienteReserva(this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
          backgroundImage: AssetImage('images/logoCorteCabello2.png')),
      trailing: IconButton(
        icon: Icon(Icons.accessibility_sharp),
        onPressed: () {},
        color: Colors.redAccent,
      ),
    );
  }
}
