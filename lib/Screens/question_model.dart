import 'dart:convert';

class Question {
  final String difficulty;
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;

  Question({
    required this.difficulty,
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      difficulty: json['difficulty'],
      question: json['question'],
      correctAnswer: json['correct_answer'],
      incorrectAnswers: List<String>.from(json['incorrect_answers']),
    );
  }

  static List<Question> parseQuestions(String responseBody) {
   final List<dynamic> parsed = json.decode(responseBody);
   return parsed.map<Question>((json) => Question.fromJson(json)).toList();
  }
}