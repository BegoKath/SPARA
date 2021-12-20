import 'package:flutter/material.dart';
import 'package:spara27/src/models/ahorro_model.dart';

class AhorroCard extends StatelessWidget {
  const AhorroCard({Key? key, required this.model}) : super(key: key);
  final Ahorro model;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      child: ListTile(
          leading: Text(" Saldo " + model.metaAhorro.toString()),
          title: Text(model.descripcion ?? ""),
          subtitle: Text(model.fechaInicio ?? ""),
          trailing: const Icon(Icons.money)),
    );
  }
}
