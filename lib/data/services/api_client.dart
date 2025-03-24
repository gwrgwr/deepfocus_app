import 'dart:convert';

import 'package:deepfocus/data/services/dio_client.dart';
import 'package:deepfocus/models/user_mongo.dart';
import 'package:deepfocus/utils/result.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ApiClient {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final String apiUrl = "https://deepfocus-back.onrender.com/";

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
      DioClient.setup();
      response.user!.updateDisplayName(name);
      final mongoResponse = await DioClient.dio.post(
        "${apiUrl}api/v1/user",
        data: jsonEncode({"id": response.user!.uid}),
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization" : "Bearer ${await response.user!.getIdToken()}"
          },
        ),
      );

      if (mongoResponse.statusCode == 200) {
        return Result.ok(response);
      } else {
        return Result.error(Exception("Error saving user in MongoDB"));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return Result.error(Exception("Email already in use"));
      }
      return Result.error(Exception(e.code));
    }
  }

  Future<Result<UserMongo>> getUserFromMongo() async {
    try {
      final id = _firebaseAuth.currentUser?.uid;
      if (id == null) {
        return Result.error(Exception("User not found"));
      }
      final response = await DioClient.dio.get(
        "${apiUrl}api/v1/user/$id",
        options: Options(headers: {"Content-Type": "application/json"}),
      );
      if (response.statusCode == 200) {
        return Result.ok(UserMongo.fromMap(response.data));
      }
      return Result.error(Exception("User not found"));
    } catch (e) {
      return Result.error(Exception(e));
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

  Future<Result<void>> sendEmailResetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return Result.ok(null);
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    }
  }
}
