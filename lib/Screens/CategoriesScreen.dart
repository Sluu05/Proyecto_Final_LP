import 'package:flutter/material.dart';
import 'difficulty_selection.dart';


class CategoryButton extends StatelessWidget {
  final String categoryName;
  final Color color;
  final int categoryId; 

  CategoryButton({
    required this.categoryName,
    required this.color,
    required this.categoryId, 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: color,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DifficultySelectionScreen(
                category: categoryName,
                categoryId: categoryId, 
              ),
            ),
          );
        },
        child: Text(
          categoryName,
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
    );
  }
}



class CategoriesScreen extends StatelessWidget {
  final Map<String, int> categories = {
    'Historia': 23,
    'Geografía': 22,
    'Ciencia': 17,
    'Deporte': 21,
    'Arte': 25,
  };

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
                  String categoryName = categories.keys.elementAt(index);
                  int categoryId = categories.values.elementAt(index);
                  return CategoryButton(
                    categoryName: categoryName,
                    color: _getCategoryColor(index),
                    categoryId: categoryId,
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
