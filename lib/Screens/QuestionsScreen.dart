import 'package:flutter/material.dart';
import 'question_model.dart';

class QuestionScreen extends StatelessWidget {
  final List<Question> questions;

  QuestionScreen({required this.questions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preguntas'),
      ),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final question = questions[index];
          return ListTile(
            title: Text(question.question),
            subtitle: Text('Dificultad: ${question.difficulty}'),
          );
        },
      ),
    );
  }
}
