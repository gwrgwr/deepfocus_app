import 'package:deepfocus/data/services/api_client.dart';
import 'package:deepfocus/utils/result.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final ApiClient _apiClient = ApiClient();

  Future<Result<UserCredential>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      return await _apiClient.loginUser(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<UserCredential>> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    return _apiClient.registerUser(
      name: name,
      email: email,
      password: password,
    );
  }

  Future<Result<void>> signOut() async {
    try {
      return await _apiClient.signOut();
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<UserCredential>> signInWithGoogle() async {
    return await _apiClient.signInWithGoogle();
  }

  Future<Result<UserCredential>> signInWithGitHub() async {
    return await _apiClient.signInWithGitHub();
  }
}
