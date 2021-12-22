import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:spara27/src/models/ahorro_model.dart';
import 'package:spara27/src/models/cliente_model.dart';

class ClienteService {
  ClienteService();
  final String _rootUrl = "https://spara-backend.web.app/api/cliente";
  Future<Usuario> getAhorros() async {
    Usuario? result;
    try {
      var url = Uri.parse(_rootUrl);
      final response = await http.get(url);
      if (response.body.isEmpty) return result!;
      List<dynamic> listBody = json.decode(response.body);
      for (var item in listBody) {
        final ahorro = Usuario.fromJson(item);
        result = ahorro;
      }
      return result!;
    } catch (ex) {
      return result!;
    }
  }
}
