import 'dart:convert';
import 'package:http/http.dart' as http;

class ConversationRepository {
  final String apiUrl = "https://healthchatai.pythonanywhere.com/api/bot/";

  Future<String> sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"Question": message}),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["answer"] ?? "No response from bot";
      } else {
        throw Exception("Failed to connect to bot");
      }
    } catch (e) {
      throw Exception("Error: ${e.toString()}");
    }
  }
}
