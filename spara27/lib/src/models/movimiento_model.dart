// To parse this JSON data, do
//
//     final movimiento = movimientoFromJson(jsonString);

import 'dart:convert';

Movimiento movimientoFromJson(String str) =>
    Movimiento.fromJson(json.decode(str));

String movimientoToJson(Movimiento data) => json.encode(data.toJson());

class Movimiento {
  Movimiento({
    this.idMovimiento,
    this.monto,
    this.descripcion,
    this.fechaInicio,
    this.tipoMovimiento,
  });

  String? idMovimiento;
  int? monto;
  String? descripcion;
  String? fechaInicio;
  String? tipoMovimiento;

  factory Movimiento.fromJson(Map<String, dynamic> json) => Movimiento(
        idMovimiento: json["idMovimiento"],
        monto: json["monto"],
        descripcion: json["descripcion"],
        fechaInicio: json["fechaInicio"],
        tipoMovimiento: json["tipoMovimiento"],
      );

  Map<String, dynamic> toJson() => {
        "idMovimiento": idMovimiento,
        "monto": monto,
        "descripcion": descripcion,
        "fechaInicio": fechaInicio,
        "tipoMovimiento": tipoMovimiento,
      };
}
