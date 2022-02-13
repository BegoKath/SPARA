import 'dart:convert';

Cuenta cuentaFromJson(String str) => Cuenta.fromJson(json.decode(str));

String cuentaToJson(Cuenta data) => json.encode(data.toJson());

class Cuenta {
  Cuenta({this.idD, this.uid, this.saldo, this.saldoAhorro, this.metaAhorro});
  String? idD;
  String? uid;
  double? saldo;
  double? saldoAhorro;
  double? metaAhorro;

  factory Cuenta.fromJson(Map<String, dynamic> json) => Cuenta(
      uid: json["uid"],
      saldo: json["saldo"].toDouble(),
      saldoAhorro: json["saldoAhorro"].toDouble(),
      metaAhorro: json["metaAhorro"].toDouble());
  factory Cuenta.created() =>
      Cuenta(uid: "", saldo: 0, saldoAhorro: 0, metaAhorro: 0);

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "saldo": saldo,
        "saldoAhorro": saldoAhorro,
        "metaAhorro": metaAhorro
      };
}
