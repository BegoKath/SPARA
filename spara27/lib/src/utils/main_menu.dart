import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:spara27/src/models/movimiento_model.dart';
import 'package:spara27/src/widgets/ahorro_widget.dart';
import 'package:spara27/src/widgets/inicio_widget.dart';
import 'package:spara27/src/widgets/movimientos_widget.dart';
import 'package:spara27/src/widgets/perfil_widget.dart';

class MenuItem {
  String label;
  IconData icon;
  MenuItem(this.label, this.icon);
}

List<MenuItem> menuOptions = [
  MenuItem('Inicio', Icons.home),
  MenuItem('Movimientos', Icons.multiple_stop),
  MenuItem('', Icons.add),
  MenuItem('Ahorro', Icons.savings),
  MenuItem('Perfil', Icons.person)
];
List<Widget> contentWidgets = [
  const InicioWidget(),
  const MovimientosWidget(),
  const AhorroWidget(),
  const PerfilWidget()
];
List<Movimiento> ejemploMovimientos = [
  Movimiento(id: 1, monto: 50, descripcion: "asca"),
  Movimiento(id: 2, monto: 70, descripcion: "assdca")
];
