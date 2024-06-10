import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> getAIResponse(String message) async {
  const apiKey = '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'; 
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
