import 'package:flutter/material.dart';
import 'package:prueba/Screens/HomeScreen.dart';  

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
      home: HomeScreen(),  // Define la pantalla de inicio
    );
  }
}