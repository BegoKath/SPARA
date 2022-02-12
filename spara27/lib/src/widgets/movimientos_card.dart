import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spara27/src/models/movimiento_model.dart';
import 'package:spara27/src/theme/main_theme.dart';
import 'package:spara27/src/utils/main_menu.dart';

class MovimientosCard extends StatelessWidget {
  const MovimientosCard({Key? key, required this.model}) : super(key: key);
  final Movimiento model;

  @override
  Widget build(BuildContext context) {
    final Categoria categoria = categorias[model.categoria!];
    final tipo = Icon(categoria.icon, color: categoria.color);

    return Card(
        elevation: 7,
        child: ListTile(
          leading: tipo,
          title: Text((model.descripcion ?? "")),
          subtitle: Text(categoria.nombre,
              style: GoogleFonts.robotoSlab(
                  color: categoria.color,
                  textStyle: Theme.of(context).textTheme.bodyText1)),
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
