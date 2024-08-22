import 'package:http/http.dart' as http;
import 'question_model.dart';

class QuestionService {
  final String baseUrl = 'https://raw.githubusercontent.com/Sluu05/Archivos_json/main/';

  Future<List<Question>> fetchQuestions(String category) async {
    final response = await http.get(Uri.parse('$baseUrl${category}_Json.json'));

    if (response.statusCode == 200) {
      return Question.parseQuestions(response.body);
    } else {
      throw Exception('Failed to load questions');
    }
  }
}
