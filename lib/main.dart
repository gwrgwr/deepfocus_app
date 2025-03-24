import 'package:deepfocus/firebase_options.dart';
import 'package:deepfocus/ui/auth/widgets/auth_controller.dart';
import 'package:deepfocus/utils/theme_change.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:provider/provider.dart';

const geminiApi = "AIzaSyAaeedkVTKwq_2HnGI8FJaaPL3M-91QAHQ";

void main() async {
  Gemini.init(apiKey: geminiApi);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(create: (_) => ThemeNotifier(), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: Provider.of<ThemeNotifier>(context, listen: false),
      builder: (context, value, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          themeMode: value,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(useMaterial3: true),
          darkTheme: ThemeData.dark(useMaterial3: true),
          home: const AuthController(),
        );
      },
    );
  }
}
