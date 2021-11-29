import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

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
