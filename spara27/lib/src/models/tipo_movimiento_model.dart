import 'dart:convert';

TipoMovimiento tipoMovimientoFromJson(String str) =>
    TipoMovimiento.fromJson(json.decode(str));

String tipoMovimientoToJson(TipoMovimiento data) => json.encode(data.toJson());

class TipoMovimiento {
  TipoMovimiento({
    this.id,
    this.movimento,
  });

  int? id;
  String? movimento;

  factory TipoMovimiento.fromJson(Map<String, dynamic> json) => TipoMovimiento(
        id: json["Id"],
        movimento: json["movimento"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "movimento": movimento,
      };
}
