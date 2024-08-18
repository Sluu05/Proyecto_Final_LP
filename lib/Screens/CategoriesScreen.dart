import 'package:flutter/material.dart';
import 'dificulty_selecction.dart';


class CategoryButton extends StatelessWidget {
  final String categoryName;
  final Color color;

  CategoryButton({required this.categoryName, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DifficultySelectionScreen(
                category: categoryName,
              ),
            ),
          );
        },
        child: Text(
          categoryName,
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }
}


class CategoriesScreen extends StatelessWidget {
  final List<String> categories = [
    'Historia',
    'Geografía',
    'Ciencia',
    'Deporte',
    'Arte',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TriviaLUJO'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Categorías',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                   return CategoryButton(
                    categoryName: categories[index],
                    color: _getCategoryColor(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(int index) {
    switch (index) {
      case 0:
        return Colors.lightGreen[200]!;
      case 1:
        return Colors.blue[100]!;
      case 2:
        return Colors.pink[100]!;
      case 3:
        return Colors.orange[200]!;
      case 4:
        return Colors.purple[100]!;
      default:
        return Colors.grey[300]!;
    }
  }
}