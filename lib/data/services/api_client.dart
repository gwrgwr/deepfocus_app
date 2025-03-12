import 'package:deepfocus/utils/result.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ApiClient {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<Result<UserCredential>> loginUser({required String email, required String password}) async {
    try {
      final response = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return Result.ok(response);
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<UserCredential>> registerUser({required String email, required String password}) async {
    try {
      final response = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return Result.ok(response);
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<void>> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return Result.ok(null);
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    }
  }
}