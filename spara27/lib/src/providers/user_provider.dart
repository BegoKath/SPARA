import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String? _uid;
  String? _email;

  String? get getUid => _uid;
  String? get getEmail => _email;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> signUpUser(String email, String password) async {
    bool reval = false;
    try {
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (_authResult.user != null) {
        reval = true;
        _uid = _auth.currentUser!.uid;
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