import 'package:deepfocus/data/repositories/auth_repository.dart';
import 'package:deepfocus/utils/commander.dart';
import 'package:deepfocus/utils/result.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthViewmodel {
  AuthViewmodel() {
    loginUser = Command1(_loginUser);
    registerUser = Command1(_registerUser);
    signOut = Command0(_signOut);
  }

  final AuthRepository _authRepository = AuthRepository();

  UserCredential? userCredential;

  late final Command1<void, (String email, String password)> loginUser;

  late final Command1<void, (String email, String password)> registerUser;

  late final Command0<void> signOut;

  Future<Result<void>> _loginUser(
    (String email, String password) credentials,
  ) async {
    final (email, password) = credentials;
    final result = await _authRepository.registerUser(
      email: email,
      password: password,
    );
    switch (result) {
      case Ok<UserCredential>():
        userCredential = result.value;
        return Result.ok(null);
      case Error<UserCredential>():
        return Result.error(result.error);
    }
  }

  Future<Result<void>> _registerUser(
    (String email, String password) credentials,
  ) async {
    final (email, password) = credentials;
    final result = await _authRepository.registerUser(
      email: email,
      password: password,
    );
    switch (result) {
      case Ok<UserCredential>():
        userCredential = result.value;
        return Result.ok(null);
      case Error<UserCredential>():
        return Result.error(result.error);
    }
  }

  Future<Result<void>> _signOut() async {
    final result = await _authRepository.signOut();
    switch (result) {
      case Ok<void>():
        userCredential = null;
        return Result.ok(null);
      case Error<void>():
        return Result.error(result.error);
    }
  }
}
