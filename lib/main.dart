import 'package:flutter/material.dart';
import 'screens/CategoriesScreen.dart';  // Importa la pantalla de categorías

void main() {
  runApp(TriviaLUJO());
}

class TriviaLUJO extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TriviaLUJO',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: CategoriesScreen(),  // Define la pantalla inicial
    );
  }
}
