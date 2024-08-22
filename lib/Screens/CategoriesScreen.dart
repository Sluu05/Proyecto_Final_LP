import 'package:flutter/material.dart';
import 'QuestionsScreen.dart';
import 'question_service.dart';

class CategoriesScreen extends StatelessWidget {
  final QuestionService questionService = QuestionService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categorías'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            CategoryTile(
              color: Colors.lightGreen[200]!,
              category: 'Historia',
              service: questionService,
              jsonCategory: 'Historia',
            ),
            CategoryTile(
              color: Colors.lightBlue[100]!,
              category: 'Geografía',
              service: questionService,
              jsonCategory: 'Geografia',
            ),
            CategoryTile(
              color: Colors.purple[100]!,
              category: 'Ciencia',
              service: questionService,
              jsonCategory: 'Ciencia',
            ),
            CategoryTile(
              color: Colors.orange[100]!,
              category: 'Deporte',
              service: questionService,
              jsonCategory: 'Deporte',
            ),
            CategoryTile(
              color: Colors.pink[100]!,
              category: 'Arte',
              service: questionService,
              jsonCategory: 'Arte',
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final Color color;
  final String category;
  final QuestionService service;
  final String jsonCategory;

  CategoryTile({
    required this.color,
    required this.category,
    required this.service,
    required this.jsonCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          title: Center(
            child: Text(
              category,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          onTap: () => _showDifficultyDialog(context),
        ),
      ),
    );
  }

  void _showDifficultyDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      String selectedDifficulty = 'Fácil'; // Valor predeterminado

      return AlertDialog(
        title: Text('Seleccionar Dificultad'),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<String>(
                  title: const Text('Fácil'),
                  value: 'Fácil',
                  groupValue: selectedDifficulty,
                  onChanged: (value) {
                    setState(() {
                      selectedDifficulty = value!;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Medio'),
                  value: 'Medio',
                  groupValue: selectedDifficulty,
                  onChanged: (value) {
                    setState(() {
                      selectedDifficulty = value!;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Difícil'),
                  value: 'Difícil',
                  groupValue: selectedDifficulty,
                  onChanged: (value) {
                    setState(() {
                      selectedDifficulty = value!;
                    });
                  },
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () async {
              try {
                // Muestra un indicador de carga mientras se obtienen las preguntas
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => Center(child: CircularProgressIndicator()),
                );

                // Intenta obtener las preguntas
                final questions = await service.fetchQuestions(jsonCategory);

                // Filtra por dificultad y navega a la pantalla de preguntas
                Navigator.of(context).pop(); // Cerrar el diálogo de carga
                Navigator.of(context).pop(); // Cerrar el diálogo de dificultad

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuestionScreen(
                      questions: questions
                          .where((q) => q.difficulty == selectedDifficulty)
                          .toList(),
                    ),
                  ),
                );
              } catch (error) {
                Navigator.of(context).pop(); // Cerrar el diálogo de carga si hay un error
                // Muestra un mensaje de error
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error al cargar preguntas: $error'),
                  ),
                );
              }
            },
            child: Text('Empezar'),
          ),
        ],
      );
    },
  );
}
}

