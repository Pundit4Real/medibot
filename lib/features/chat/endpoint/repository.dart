import 'dart:convert';
import 'package:http/http.dart' as http;

class ConversationRepository {
  final String apiUrl = "https://healthchatai.pythonanywhere.com/api/bot/";

  Future<List<Map<String, String>>> sendMessage(String message, List<Map<String, String>> chatHistory) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"Question": message}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final botResponse = data["answer"] ?? "No response from bot";

        // Append new interactions to history
        chatHistory.add({"sender": "user", "text": message});
        chatHistory.add({"sender": "bot", "text": botResponse});

        return chatHistory;
      } else {
        throw Exception("Failed to connect to bot");
      }
    } catch (e) {
      throw Exception("Error: ${e.toString()}");
    }
  }
}
