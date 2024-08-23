import 'package:flutter/material.dart';
import 'difficulty_screen.dart';

class CategoryButton extends StatelessWidget {
  final String categoryName;
  final String imageUrl; 
  final int categoryId;

  CategoryButton({
    required this.categoryName,
    required this.imageUrl, 
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero, 
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
      'imageUrl': 'https://res.cloudinary.com/dgsfowxsr/image/upload/v1724437369/historia_hr2jsf.png',
    },
    'Geography': {
      'id': 22,
      'imageUrl': 'https://res.cloudinary.com/dgsfowxsr/image/upload/v1724437369/Geografia_tsar3r.png',
    },
    'Science': {
      'id': 17,
      'imageUrl': 'https://res.cloudinary.com/dgsfowxsr/image/upload/v1724437369/ciencia_cup2hi.png',
    },
    'Sport': {
      'id': 21,
      'imageUrl': 'https://res.cloudinary.com/dgsfowxsr/image/upload/v1724437369/deporte_ixkdmj.png',
    },
    'Art': {
      'id': 25,
      'imageUrl': 'https://res.cloudinary.com/dgsfowxsr/image/upload/v1724437369/arte_abluia.png',
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
