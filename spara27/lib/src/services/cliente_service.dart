import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:spara27/src/models/cliente_model.dart';

class ClienteService {
  ClienteService();

  Future<Usuario> getUsuario(String uid) async {
    Usuario? user;
    final QuerySnapshot result = await Future.value(FirebaseFirestore.instance
        .collection("cliente")
        .where("uid", isEqualTo: uid)
        .get());
    var list = result.docs;
    dynamic us = list[0].data();
    user = Usuario.fromJson(us);
    user.idD = list[0].id;
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

  Future<void> updateToServer(Usuario usu) async {
    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference =
          FirebaseFirestore.instance.collection('cliente');
      await reference.doc(usu.idD).update({
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
