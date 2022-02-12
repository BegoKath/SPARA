import 'package:flutter/material.dart';

import 'package:spara27/src/widgets/ahorro_widget.dart';
import 'package:spara27/src/widgets/inicio_widget.dart';
import 'package:spara27/src/widgets/movimientos_widget.dart';
import 'package:spara27/src/widgets/settings_widget.dart';

class MenuItem {
  String label;
  IconData icon;
  MenuItem(this.label, this.icon);
}

List<Widget> contentWidgets = [
  const InicioWidget(),
  const MovimientosWidget(),
  const AhorroWidget(),
  const SettingsWisget()
];

class Categoria {
  String nombre;
  IconData icon;
  Color color;
  Categoria(this.nombre, this.icon, this.color);
}

List<Categoria> categorias = [
  Categoria("Alimentación", Icons.food_bank, Colors.deepOrange),
  Categoria("Vivienda", Icons.house_outlined, Colors.greenAccent),
  Categoria("Transporte", Icons.emoji_transportation, Colors.deepPurple),
  Categoria("Salud", Icons.health_and_safety, Colors.redAccent),
  Categoria("Entretenimiento", Icons.movie, Colors.blueAccent),
  Categoria("Vestuario", Icons.shopping_bag, Colors.pink),
  Categoria("Educación", Icons.cast_for_education, Colors.indigo),
  Categoria("Otros Gastos", Icons.more_horiz, Colors.black),
];

class Task {
  String categoria;
  int cantidad;
  Color color;
  IconData icon;
  Task(this.categoria, this.cantidad, this.color, this.icon);
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoria'] = categoria;
    data['cantidad'] = cantidad;
    data['color'] = color;
    data['icon'] = icon;
    return data;
  }
}
