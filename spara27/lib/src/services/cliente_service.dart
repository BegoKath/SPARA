import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
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

  Future<Usuario> getUsuario(String uid) async {
    Usuario? user;
    final QuerySnapshot result = await Future.value(FirebaseFirestore.instance
        .collection("cliente")
        .where("uid", isEqualTo: uid)
        .get());
    var list = result.docs;
    dynamic us = list[0].data();
    user = Usuario.fromJson(us);
    return user;
  }

  Future<void> sendToServer(Usuario usu) async {
    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference =
          FirebaseFirestore.instance.collection('cliente');
      await reference.add({
        "uid": usu.uid,
        "nombre": usu.nombre,
        "apellido": usu.apellido,
        "email": usu.email,
        "edad": usu.edad,
        "urlImage": usu.urlImage
      });
    });
  }
}
