import 'package:deepfocus/utils/result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ApiClient {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<Result<UserCredential>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Result.ok(response);
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<UserCredential>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return Result.ok(
        await FirebaseAuth.instance.signInWithCredential(credential),
      );
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<UserCredential>> signInWithGitHub() async {
    try {
      GithubAuthProvider githubProvider = GithubAuthProvider();

      return Result.ok(
        await FirebaseAuth.instance.signInWithProvider(githubProvider),
      );
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<UserCredential>> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      response.user!.updateDisplayName(name);
      return Result.ok(response);
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return Result.error(Exception("Email already in use"));
      }
      return Result.error(Exception(e.code));
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
