import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import 'package:spara27/src/models/ahorro_model.dart';
import 'package:spara27/src/models/movimiento_model.dart';

class AhorrosService {
  AhorrosService();
  final String _rootUrl = "https://spara-backend.web.app/api/ahorro";
  Future<List<Ahorro>> getAhorros() async {
    List<Ahorro> result = [];
    try {
      var url = Uri.parse(_rootUrl);
      final response = await http.get(url);
      if (response.body.isEmpty) return result;
      List<dynamic> listBody = json.decode(response.body);
      for (var item in listBody) {
        final ahorro = Ahorro.fromJson(item);
        result.add(ahorro);
      }
      return result;
    } catch (ex) {
      return result;
    }
  }

  Future<List<Ahorro>> getMovimientos(
      String uid, String fechai, String fechaf) async {
    List<Ahorro> resultado = [];

    try {
      final result = await Future.value(FirebaseFirestore.instance
          .collection("ahorro")
          .where('fechaInicio', isGreaterThanOrEqualTo: fechai)
          .where('fechaInicio', isLessThan: fechaf)
          .where("uid", isEqualTo: uid)
          .orderBy('fechaInicio', descending: true)
          .get());
      var list = result.docs;
      for (var item in list) {
        dynamic us = item.data();
        final movimiento = Ahorro.fromJson(us);
        resultado.add(movimiento);
      }
      return resultado;
    } catch (e) {
      return resultado;
    }
  }

  Future<void> sendToServer(Movimiento usu) async {
    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference =
          FirebaseFirestore.instance.collection('ahorro');
      await reference.add({
        "uid": usu.uid,
        "monto": usu.monto,
        "descripcion": usu.descripcion,
        "fechaInicio": usu.fechaInicio!.toIso8601String(),
      });
    });
  }
}
