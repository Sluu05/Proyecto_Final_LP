import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> translateText(String text, String targetLanguage) async {
  final String apiKey = 'AIzaSyDkx9lbZG3vCo-xyzVdxLJUOlOqc-7MVcQ';  
  final String url =
      'https://translation.googleapis.com/language/translate/v2?key=$apiKey';

  final response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'q': text,
      'target': targetLanguage,
    }),
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final translatedText = jsonResponse['data']['translations'][0]['translatedText'];
    return translatedText;
  } else {
    throw Exception('Failed to translate text');
  }
}
