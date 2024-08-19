import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'ResultsScreen.dart';
import 'TranslateGoogle.dart';

class QuestionScreen extends StatefulWidget {
  final String category;
  final int categoryId;  
  final String difficulty;

  QuestionScreen({required this.category, required this.categoryId, required this.difficulty}); 

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  List questions = [];
  int currentQuestionIndex = 0;
  int correctAnswers = 0;

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

bool isLoading = false;

Future<void> fetchQuestions() async {
  setState(() {
    isLoading = true;
  });

  try {
    final response = await http.get(
      Uri.parse('https://opentdb.com/api.php?amount=10&category=${widget.categoryId}&difficulty=${widget.difficulty}&type=multiple'),
    );

    if (response.statusCode == 200) {
      List fetchedQuestions = json.decode(response.body)['results'];
      List translatedQuestions = [];

      for (var question in fetchedQuestions) {
        String translatedQuestion = await translateText(question['question'], 'es');
        List translatedAnswers = await Future.wait(
            question['incorrect_answers'].map((answer) => translateText(answer, 'es')).toList());
        String translatedCorrectAnswer = await translateText(question['correct_answer'], 'es');

        translatedQuestions.add({
          'question': translatedQuestion,
          'incorrect_answers': translatedAnswers,
          'correct_answer': translatedCorrectAnswer,
        });
      }

      setState(() {
        questions = translatedQuestions;
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load questions');
    }
  } catch (e) {
    setState(() {
      isLoading = false;
    });
    print('Error fetching questions: $e');
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
    if (isCorrect) {
      correctAnswers++;
    }

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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultsScreen(
                          correctAnswers: correctAnswers,
                          totalQuestions: questions.length,
                        ),
                      ),
                    );
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
