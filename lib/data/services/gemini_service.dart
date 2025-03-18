import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiService {
  final gemini = Gemini.instance;
  final List<Map<String, String>> chatHistory = [];

  void saveUserContext({
    required int index,
    required String message,
    required Map<String, List<String>> saveUserOnBoardingPreference,
  }) {
    chatHistory.insert(index, {
      "role": "system",
      "content": "$message : $saveUserOnBoardingPreference",
    });
  }

  Future<String> sendMessage(String message) async {
    chatHistory.add({"role": "user", "content": message});
    final List<Part> parts =
        chatHistory.map((m) => Part.text(m["content"]!)).toList();
    final response = await gemini.chat(
      chatHistory.map((m) => Content(parts: parts)).toList(),
    );
    if (response != null) {
      final botMessage = response.output;
      if (botMessage != null) {
        chatHistory.add({"role": "bot", "content": botMessage});
        return botMessage;
      }
      return "Error trying to retrieve your answer.";
    } else {
      return "Error trying to connect to Gemini.";
    }
  }
}
