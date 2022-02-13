import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spara27/src/models/cuenta_model.dart';

class CuentaService {
  CuentaService();
  Future<Cuenta> getCuenta(String uid) async {
    Cuenta? user;
    final QuerySnapshot result = await Future.value(FirebaseFirestore.instance
        .collection("cuenta")
        .where("uid", isEqualTo: uid)
        .get());
    var list = result.docs;
    dynamic us = list[0].data();
    user = Cuenta.fromJson(us);
    user.idD = list[0].id;
    return user;
  }

  Future<void> sendToServer(Cuenta usu) async {
    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference =
          FirebaseFirestore.instance.collection('cuenta');
      await reference.add({
        "uid": usu.uid,
        "saldo": usu.saldo,
        "saldoAhorro": usu.saldoAhorro,
        "metaAhorro": usu.metaAhorro
      });
    });
  }

  Future<void> updateToServer(Cuenta usu) async {
    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference =
          FirebaseFirestore.instance.collection('cuenta');
      await reference.doc(usu.idD).update({
        "uid": usu.uid,
        "saldo": usu.saldo,
        "saldoAhorro": usu.saldoAhorro,
        "metaAhorro": usu.metaAhorro
      });
    });
  }
}
