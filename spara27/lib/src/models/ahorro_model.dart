import 'dart:convert';

Ahorro ahorroFromJson(String str) => Ahorro.fromJson(json.decode(str));

String ahorroToJson(Ahorro data) => json.encode(data.toJson());

class Ahorro {
  Ahorro({
    this.idahorro,
    this.monto,
    this.metaAhorro,
    this.descripcion,
    this.fechaInicio,
  });

  String? idahorro;
  double? monto;
  int? metaAhorro;
  String? descripcion;
  String? fechaInicio;

  factory Ahorro.fromJson(Map<String, dynamic> json) => Ahorro(
        idahorro: json["idahorro"],
        monto: json["monto"].toDouble(),
        metaAhorro: json["metaAhorro"],
        descripcion: json["descripcion"],
        fechaInicio: json["fechaInicio"],
      );

  Map<String, dynamic> toJson() => {
        "idahorro": idahorro,
        "monto": monto,
        "metaAhorro": metaAhorro,
        "descripcion": descripcion,
        "fechaInicio": fechaInicio,
      };
}
