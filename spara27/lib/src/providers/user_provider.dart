import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spara27/src/models/cliente_model.dart';

class UserProvider extends ChangeNotifier {
  String? _uid;
  String? _email;
  String _nombre = "";
  Usuario? _user =
      Usuario(nombre: "", apellido: "", edad: "", uid: "", urlImage: "");

  String? get getUid => _uid;
  String? get getEmail => _email;
  String? get getNombre => _nombre;
  Usuario? get getUsuario => _user;

  set setNombre(String value) {
    _nombre = value;
    notifyListeners();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> setUser(Usuario user) async {
    _user = user;
  }

  Usuario? getUser() {
    return _user;
  }

  Future<bool> signUpUser(String email, String password) async {
    bool reval = false;
    try {
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (_authResult.user != null) {
        reval = true;
        _uid = _auth.currentUser!.uid;
        _email = _auth.currentUser!.email;
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return reval;
  }

  Future<bool> loginUser(String email, String password) async {
    bool reval = false;
    try {
      UserCredential _authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (_authResult.user != null) {
        _uid = _authResult.user!.uid;
        _email = _authResult.user!.email;
        reval = true;
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return reval;
  }
}
