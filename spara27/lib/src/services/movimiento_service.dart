import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spara27/src/models/movimiento_model.dart';

class MovimientoService {
  MovimientoService();

  Future<List<Movimiento>> getMovimientos(String uid, String fecha) async {
    List<Movimiento> resultado = [];
    try {
      final result = await Future.value(FirebaseFirestore.instance
          .collection("movimiento")
          .where('fechaInicio', isLessThanOrEqualTo: fecha)
          .where("uid", isEqualTo: uid)
          .orderBy('fechaInicio', descending: true)
          .get());
      var list = result.docs;
      for (var item in list) {
        dynamic us = item.data();
        final movimiento = Movimiento.fromJson(us);
        resultado.add(movimiento);
      }
      return resultado;
    } catch (e) {
      return resultado;
    }
  }

  Future<int> getMovimientosCategoria(String uid, int categoria) async {
    int resultado = 0;
    try {
      final result = await Future.value(FirebaseFirestore.instance
          .collection("movimiento")
          .where("uid", isEqualTo: uid)
          .where("categoria", isEqualTo: categoria)
          .get());
      resultado = result.docs.length;

      return resultado;
    } catch (e) {
      return resultado;
    }
  }

  Future<void> sendToServer(Movimiento usu) async {
    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference =
          FirebaseFirestore.instance.collection('movimiento');
      await reference.add({
        "uid": usu.uid,
        "monto": usu.monto,
        "descripcion": usu.descripcion,
        "fechaInicio": usu.fechaInicio!.toIso8601String(),
        "tipoMovimiento": usu.tipoMovimiento,
        "categoria": usu.categoria
      });
    });
  }
}
