import 'package:flutter/material.dart';
import 'package:spara27/src/models/movimiento_model.dart';
import 'package:spara27/src/theme/main_theme.dart';

class MovimientosCard extends StatelessWidget {
  const MovimientosCard({Key? key, required this.model}) : super(key: key);
  final Movimiento model;
  @override
  Widget build(BuildContext context) {
    final tipo = Container(
        height: 32,
        width: 32,
        color: model.tipoMovimiento!.movimento == "Ingreso"
            ? AppTheme.colorHighPriority
            : model.tipoMovimiento!.movimento == "Ahorro"
                ? AppTheme.colorMediumPriority
                : AppTheme.colorLowPriority,
        child: Icon(Icons.priority_high,
            color: model.tipoMovimiento!.movimento == "Egreso"
                ? Colors.black
                : Colors.white));

    return Card(
        elevation: 7,
        child: ListTile(
          title: Text((model.descripcion ?? "")),
        ));
  }
}
