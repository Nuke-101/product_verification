import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth;

  AuthService(this._auth);

  Stream<User?> get authStateChanges => _auth.idTokenChanges();

  Future<String> login(String email, String password) async {
    try {
      _auth.signInWithEmailAndPassword(email: email, password: password);
      return "Logged In";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> signUp(String email, String password) async {
    try {
      _auth.createUserWithEmailAndPassword(email: email, password: password);
      return "Signed Up";
    } catch (e) {
      return e.toString();
    }
  }
}
