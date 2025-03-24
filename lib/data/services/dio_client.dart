import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DioClient {
  static final Dio dio = Dio();

  static void setup() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          User? user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            String? token = await user.getIdToken();
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
  }
}
