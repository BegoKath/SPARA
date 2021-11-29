import 'dart:convert';

Ahorro ahorroFromJson(String str) => Ahorro.fromJson(json.decode(str));

String ahorroToJson(Ahorro data) => json.encode(data.toJson());

class Ahorro {
  Ahorro({
    this.id,
    this.monto,
    this.metaAhorro,
    this.descripcion,
    this.fechaInicio,
    this.fechaFinal,
  });

  int? id;
  int? monto;
  int? metaAhorro;
  String? descripcion;
  DateTime? fechaInicio;
  DateTime? fechaFinal;

  factory Ahorro.fromJson(Map<String, dynamic> json) => Ahorro(
        id: json["Id"],
        monto: json["monto"],
        metaAhorro: json["meta-ahorro"],
        descripcion: json["descripcion"],
        fechaInicio: DateTime.parse(json["fecha_inicio"]),
        fechaFinal: DateTime.parse(json["fecha_final"]),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "monto": monto,
        "meta-ahorro": metaAhorro,
        "descripcion": descripcion,
        "fecha_inicio": fechaInicio!.toIso8601String(),
        "fecha_final": fechaFinal!.toIso8601String(),
      };
}
