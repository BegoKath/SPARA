// To parse this JSON data, do
//
//     final movimiento = movimientoFromJson(jsonString);

import 'dart:convert';

Movimiento movimientoFromJson(String str) =>
    Movimiento.fromJson(json.decode(str));

String movimientoToJson(Movimiento data) => json.encode(data.toJson());

class Movimiento {
  Movimiento(
      {this.uid,
      this.monto,
      this.descripcion,
      this.fechaInicio,
      this.tipoMovimiento,
      this.categoria});

  String? uid;
  double? monto;
  String? descripcion;
  DateTime? fechaInicio;
  String? tipoMovimiento;
  int? categoria;

  factory Movimiento.fromJson(Map<String, dynamic> json) => Movimiento(
        uid: json["uid"],
        monto: json["monto"].toDouble(),
        descripcion: json["descripcion"],
        fechaInicio: DateTime.parse(json["fechaInicio"]),
        tipoMovimiento: json["tipoMovimiento"],
        categoria: json["categoria"],
      );
  factory Movimiento.created() => Movimiento(
      uid: "",
      monto: 0.0,
      descripcion: "",
      fechaInicio: DateTime.now(),
      tipoMovimiento: "",
      categoria: 0);
  Map<String, dynamic> toJson() => {
        "uid": uid,
        "monto": monto,
        "descripcion": descripcion,
        "fechaInicio": fechaInicio!.toIso8601String(),
        "tipoMovimiento": tipoMovimiento,
        "categoria": categoria
      };
}
