import 'package:flutter/material.dart';
import 'package:prueba/Screens/HomeScreen.dart';

void main() {
  runApp(TriviaLUJO());
}

class TriviaLUJO extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TriviaLUJO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyLarge: TextStyle(color: Colors.black87),
              bodyMedium: TextStyle(color: Colors.black54),
            ),
      ),
      home: HomeScreen(),
    );
  }
}
