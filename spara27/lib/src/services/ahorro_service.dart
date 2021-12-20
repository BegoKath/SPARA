import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:spara27/src/models/ahorro_model.dart';

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
}
