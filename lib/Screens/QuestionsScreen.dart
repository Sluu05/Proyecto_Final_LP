// QuestionsScreen.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'ResultsScreen.dart';

class QuestionScreen extends StatefulWidget {
  final String category;
  final int categoryId;
  final String difficulty;

  QuestionScreen({
    required this.category,
    required this.categoryId,
    required this.difficulty,
  });

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  List questions = [];
  int currentQuestionIndex = 0;
  int correctAnswers = 0;
  bool isLoading = true;
  bool isAnswered = false;
  String selectedAnswer = '';

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    final response = await http.get(
      Uri.parse(
          'https://opentdb.com/api.php?amount=10&category=${widget.categoryId}&difficulty=${widget.difficulty}&type=multiple'),
    );

    if (response.statusCode == 200) {
      setState(() {
        questions = json.decode(response.body)['results'];
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load questions');
    }
  }

  void checkAnswer(String answer) {
    setState(() {
      isAnswered = true;
      selectedAnswer = answer;
      if (answer == questions[currentQuestionIndex]['correct_answer']) {
        correctAnswers++;
      }
    });
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        isAnswered = false;
        selectedAnswer = '';
      });
    } else {
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
  }

  String decodeHtml(String htmlString) {
    return HtmlUnescape().convert(htmlString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.category} Quiz',
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: Colors.green,
        elevation: 0,
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : buildQuestionContent(),
    );
  }

  Widget buildQuestionContent() {
    var question = questions[currentQuestionIndex];
    List options = [
      ...question['incorrect_answers'],
      question['correct_answer']
    ];
    options.shuffle();

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/home_background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          // Indicador de progreso
          LinearPercentIndicator(
            percent: (currentQuestionIndex + 1) / questions.length,
            lineHeight: 8.0,
            progressColor: Colors.greenAccent,
            backgroundColor: Colors.white,
          ),
          SizedBox(height: 20),
          // Contador de preguntas
          Text(
            'Question ${currentQuestionIndex + 1} of ${questions.length}',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: Colors.white70,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(height: 20),
          // Tarjeta de pregunta
          Card(
            color: Colors.white.withOpacity(0.9),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                decodeHtml(question['question']),
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 30),
          // Opciones de respuesta
          Expanded(
            child: ListView.builder(
              itemCount: options.length,
              itemBuilder: (context, index) {
                String option = decodeHtml(options[index]);
                bool isCorrect =
                    option == decodeHtml(question['correct_answer']);
                return GestureDetector(
                  onTap: isAnswered ? null : () => checkAnswer(option),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    decoration: BoxDecoration(
                      color: getOptionColor(option, isCorrect),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.white70,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      option,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          // Botón Siguiente
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.greenAccent,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 5,
            ),
            onPressed: isAnswered ? nextQuestion : null,
            child: Text(
              currentQuestionIndex == questions.length - 1
                  ? 'See Results'
                  : 'Next Question',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color getOptionColor(String option, bool isCorrect) {
    if (!isAnswered) {
      return Colors.white.withOpacity(0.8);
    } else if (selectedAnswer == option) {
      return isCorrect ? Colors.greenAccent : Colors.redAccent;
    } else if (isCorrect) {
      return Colors.greenAccent;
    } else {
      return Colors.white.withOpacity(0.8);
    }
  }
}

class HtmlUnescape {
  String convert(String text) {
    return text
        .replaceAll('&quot;', '"')
        .replaceAll('&#039;', "'")
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&eacute;', 'é')
        .replaceAll('&uuml;', 'ü')
        .replaceAll('&aacute;', 'á')
        .replaceAll('&ntilde;', 'ñ')
        .replaceAll('&rsquo;', '’')
        .replaceAll('&ldquo;', '“')
        .replaceAll('&rdquo;', '”');
  }
}
