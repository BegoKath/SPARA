import 'dart:convert';

Ahorro ahorroFromJson(String str) => Ahorro.fromJson(json.decode(str));

String ahorroToJson(Ahorro data) => json.encode(data.toJson());

class Ahorro {
  Ahorro({
    this.uid,
    this.monto,
    this.descripcion,
    this.fechaInicio,
  });

  String? uid;
  double? monto;
  String? descripcion;
  DateTime? fechaInicio;

  factory Ahorro.fromJson(Map<String, dynamic> json) => Ahorro(
        uid: json["uid"],
        monto: json["monto"].toDouble(),
        descripcion: json["descripcion"],
        fechaInicio: DateTime.parse(json["fechaInicio"]),
      );
  factory Ahorro.created() =>
      Ahorro(uid: "", monto: 0, descripcion: "", fechaInicio: DateTime.now());
  Map<String, dynamic> toJson() => {
        "uid": uid,
        "monto": monto,
        "descripcion": descripcion,
        "fechaInicio": fechaInicio!.toIso8601String(),
      };
}
