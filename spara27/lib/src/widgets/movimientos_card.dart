import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spara27/src/models/movimiento_model.dart';
import 'package:spara27/src/theme/main_theme.dart';

class MovimientosCard extends StatelessWidget {
  const MovimientosCard({Key? key, required this.model}) : super(key: key);
  final Movimiento model;
  @override
  Widget build(BuildContext context) {
    final tipo = Icon(Icons.attach_money,
        color: model.tipoMovimiento! == "Egreso"
            ? AppTheme.colorHighPriority
            : AppTheme.colorLowPriority);

    return Card(
        elevation: 7,
        child: ListTile(
          leading: tipo,
          title: Text((model.descripcion ?? "")),
          //subtitle: Text(model.tipoMovimiento ?? ""),
          trailing: Text(
              model.tipoMovimiento! == "Egreso"
                  ? "- " + model.monto.toString()
                  : "+ " + model.monto.toString(),
              style: GoogleFonts.robotoSlab(
                  color: model.tipoMovimiento! == "Egreso"
                      ? AppTheme.colorHighPriority
                      : AppTheme.colorLowPriority,
                  fontSize: 18.0,
                  textStyle: Theme.of(context).textTheme.headline5)),
        ));
  }
}
