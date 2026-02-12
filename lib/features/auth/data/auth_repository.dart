import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future login({required String email, required String password})async{
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
      );
  }

  Future signUp({required String email, required String password})async{
      await _firebaseAuth.createUserWithEmailAndPassword(email: email,password: password);
  }

  Future Logout() async {
      await _firebaseAuth.signOut();

  }

}