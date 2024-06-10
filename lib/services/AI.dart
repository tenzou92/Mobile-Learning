import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<String> getAIResponse(String message) async {
  final apiKey = dotenv.env['OPENAI_API_KEY'] ?? '';
  const apiUrl = 'https://api.openai.com/v1/engines/davinci-003/completions';

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'prompt': message,
      'max_tokens': 50,
      'n': 1,
      'stop': ['\n'],
    }),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['choices'][0]['text'].trim();
  } else {
    throw Exception('Failed to fetch response from AI');
  }
}
