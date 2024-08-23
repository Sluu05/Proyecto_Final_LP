import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QuestionScreen extends StatefulWidget {
  final String category;
  final String difficulty;

  QuestionScreen({required this.category, required this.difficulty});

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  List questions = [];
  int currentQuestionIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    final response = await http.get(
        Uri.parse('https://opentdb.com/api.php?amount=10&category=${widget.category}&difficulty=${widget.difficulty}&type=multiple'));
    
    if (response.statusCode == 200) {
      setState(() {
        questions = json.decode(response.body)['results'];
      });
    } else {
      throw Exception('Failed to load questions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TriviaLUJO - ${widget.category}'),
        backgroundColor: Colors.green,
      ),
      body: questions.isEmpty
          ? Center(child: CircularProgressIndicator())
          : buildQuestion(),
    );
  }

  Widget buildQuestion() {
    var question = questions[currentQuestionIndex];
    List options = [...question['incorrect_answers'], question['correct_answer']];
    options.shuffle();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            question['question'],
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          ...options.map((option) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.greenAccent,
                ),
                onPressed: () {
                  checkAnswer(option == question['correct_answer']);
                },
                child: Text(
                  option,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  void checkAnswer(bool isCorrect) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isCorrect ? '¡Correcto!' : 'Incorrecto'),
          content: Text(isCorrect
              ? '¡Buena respuesta!'
              : 'La respuesta correcta era: ${questions[currentQuestionIndex]['correct_answer']}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  currentQuestionIndex++;
                  if (currentQuestionIndex >= questions.length) {
                    currentQuestionIndex = 0;
                  }
                });
              },
              child: Text('Siguiente'),
            ),
          ],
        );
      },
    );
  }
}
