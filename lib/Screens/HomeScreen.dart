// HomeScreen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'CategoriesScreen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/home_background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Contenido principal
          Container(
            color: Colors.black.withOpacity(0.6), // Oscurecer el fondo
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo de la aplicación
                  Image.asset(
                    'assets/images/logo.png',
                    width: 150,
                    height: 150,
                  ),
                  SizedBox(height: 30),
                  // Título de bienvenida
                  Text(
                    'Welcome to TriviaLUJO',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  // Subtítulo
                  Text(
                    'Test your knowledge across various topics!',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 50),
                  // Botón de jugar
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoriesScreen()),
                      );
                    },
                    child: Text(
                      'Play Now',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
