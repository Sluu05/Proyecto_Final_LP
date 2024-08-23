// CategoriesScreen.dart

import 'package:flutter/material.dart';
import 'difficulty_screen.dart';

class CategoryButton extends StatelessWidget {
  final String categoryName;
  final String imageUrl; // Nuevo campo para la URL de la imagen
  final int categoryId;

  CategoryButton({
    required this.categoryName,
    required this.imageUrl, // Asignar la URL de la imagen
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero, // Sin padding para que la imagen cubra todo
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
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
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              color: Colors.black.withOpacity(0.5), // Fondo oscuro para el texto
              child: Text(
                categoryName,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class CategoriesScreen extends StatelessWidget {
  final Map<String, Map<String, dynamic>> categories = {
    'History': {
      'id': 23,
      'imageUrl': 'https://example.com/history_image.jpg',
    },
    'Geography': {
      'id': 22,
      'imageUrl': 'https://example.com/geography_image.jpg',
    },
    'Science': {
      'id': 17,
      'imageUrl': 'https://example.com/science_image.jpg',
    },
    'Sport': {
      'id': 21,
      'imageUrl': 'https://example.com/sport_image.jpg',
    },
    'Art': {
      'id': 25,
      'imageUrl': 'https://example.com/art_image.jpg',
    },
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
              'Categories',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  String categoryName = categories.keys.elementAt(index);
                 int? categoryId = categories[categoryName]?['id'];
                 String? imageUrl = categories[categoryName]?['imageUrl'];
                  return CategoryButton(
                    categoryName: categoryName,
                    imageUrl: imageUrl ?? 'https://example.com/default-image.png',
                    categoryId: categoryId ?? 0, 

                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
