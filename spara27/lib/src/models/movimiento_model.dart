import 'dart:convert';

import 'package:spara27/src/models/tipo_movimiento_model.dart';

Movimiento movimientoFromJson(String str) =>
    Movimiento.fromJson(json.decode(str));

String movimientoToJson(Movimiento data) => json.encode(data.toJson());

class Movimiento {
  Movimiento({
    this.id,
    this.monto,
    this.descripcion,
    this.fechaInicio,
    this.tipoMovimiento,
  });

  int? id;
  int? monto;
  String? descripcion;
  DateTime? fechaInicio;
  TipoMovimiento? tipoMovimiento;

  factory Movimiento.fromJson(Map<String, dynamic> json) => Movimiento(
        id: json["Id"],
        monto: json["monto"],
        descripcion: json["descripcion"],
        fechaInicio: DateTime.parse(json["fecha_inicio"]),
        tipoMovimiento: TipoMovimiento.fromJson(json["tipo_movimiento"]),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "monto": monto,
        "descripcion": descripcion,
        "fecha_inicio": fechaInicio!.toIso8601String(),
        "tipo_movimiento": tipoMovimiento!.toJson(),
      };
}
