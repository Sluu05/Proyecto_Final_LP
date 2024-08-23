import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'CategoriesScreen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/home_background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          Container(
            color: Colors.black.withOpacity(0.6), 
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                 
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
                  
                  Text(
                    'Test your knowledge across various topics!',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Color.fromARGB(179, 255, 251, 134),
                        fontSize: 18,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 50),
                  
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
