import 'dart:convert';

import 'package:spara27/src/models/ahorro_model.dart';
import 'package:spara27/src/models/cliente_model.dart';
import 'package:spara27/src/models/movimiento_model.dart';

TipoMovimiento tipoMovimientoFromJson(String str) =>
    TipoMovimiento.fromJson(json.decode(str));

String tipoMovimientoToJson(TipoMovimiento data) => json.encode(data.toJson());

class TipoMovimiento {
  TipoMovimiento({
    this.id,
    this.montoTotal,
    this.cliente,
    this.ahorros,
    this.movimientos,
  });

  int? id;
  int? montoTotal;
  Usuario? cliente;
  List<Ahorro>? ahorros;
  List<Movimiento>? movimientos;

  factory TipoMovimiento.fromJson(Map<String, dynamic> json) => TipoMovimiento(
        id: json["Id"],
        montoTotal: json["monto_total"],
        cliente: Usuario.fromJson(json["Cliente"]),
        ahorros:
            List<Ahorro>.from(json["Ahorros"].map((x) => Ahorro.fromJson(x))),
        movimientos: List<Movimiento>.from(
            json["Movimientos"].map((x) => Movimiento.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "monto_total": montoTotal,
        "Cliente": cliente!.toJson(),
        "Ahorros": List<dynamic>.from(ahorros!.map((x) => x.toJson())),
        "Movimientos": List<dynamic>.from(movimientos!.map((x) => x.toJson())),
      };
}
