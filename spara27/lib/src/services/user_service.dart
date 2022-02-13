import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  String? _uid;
  String? _email;

  String? get getUid => _uid;
  String? get getEmail => _email;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String> signUpUser(String email, String password) async {
    String reval = "";
    try {
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (_authResult.user != null) {
        _uid = _auth.currentUser!.uid;
        _email = _auth.currentUser!.email;
      }
    } on FirebaseAuthException catch (e) {
      reval = e.code;
    } catch (e) {
      reval = e.toString();
    }
    return reval;
  }

  Future<String> loginUser(String email, String password) async {
    String reval = "";

    try {
      UserCredential _authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (_authResult.user != null) {
        _uid = _authResult.user!.uid;
        _email = _authResult.user!.email;
      }
    } on FirebaseAuthException catch (e) {
      reval = e.code;
    } catch (e) {
      reval = e.toString();
    }
    return reval;
  }
}
