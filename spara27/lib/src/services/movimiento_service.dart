import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:spara27/src/models/movimiento_model.dart';

class MovimientoService {
  MovimientoService();
  final String _rootUrl = "https://spara-backend.web.app/api/movimiento";
  Future<List<Movimiento>> getAhorros() async {
    List<Movimiento> result = [];
    try {
      var url = Uri.parse(_rootUrl);
      final response = await http.get(url);
      if (response.body.isEmpty) return result;
      List<dynamic> listBody = json.decode(response.body);
      for (var item in listBody) {
        final ahorro = Movimiento.fromJson(item);
        result.add(ahorro);
      }
      return result;
    } catch (ex) {
      return result;
    }
  }
}
