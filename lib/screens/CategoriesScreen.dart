import 'package:flutter/material.dart';

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
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: _getCategoryColor(index),
                    child: ListTile(
                      title: Center(
                        child: Text(
                          categories[index],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      onTap: () {
                        //Apartado de navegaciones
                      },
                    ),
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
