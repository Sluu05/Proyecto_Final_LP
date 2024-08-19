import 'package:flutter/material.dart';
import 'CategoriesScreen.dart';

class ResultsScreen extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;

  ResultsScreen({required this.correctAnswers, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    int stars = (correctAnswers * 5 / totalQuestions).round();

    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '¡Resultados!',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return Icon(
                  index < stars ? Icons.star : Icons.star_border,
                  color: Colors.yellow,
                  size: 40,
                );
              }),
            ),
            SizedBox(height: 20),
            Text(
              '$correctAnswers / $totalQuestions respuestas correctas',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: Colors.green,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => CategoriesScreen()),
                );
              },
              child: Text(
                'Volver a Categorías',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: Colors.green,
              ),
              onPressed: () {
                Navigator.pop(context); 
              },
              child: Text(
                'Jugar de Nuevo',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
