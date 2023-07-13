import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  Future<void> signinWithEmainPass({required String email, required String pass}) async {
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: pass);
  }

  Future<void> createWithEmainPass({required String email, required String pass}) async {
    await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: pass);
  }

  Future<void> signout() async{
    await _firebaseAuth.signOut();
  }
}