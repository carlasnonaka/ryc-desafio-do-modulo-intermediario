import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
//import 'screens/details_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marvel App',
      theme: ThemeData(
        primaryColor: Color(0xFFED1D24), // Vermelho Marvel
        scaffoldBackgroundColor: Color(0xFF333333), // Cinza escuro
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFED1D24), // AppBar em vermelho
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'MarvelFont', // Fonte personalizada
          ),
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        //'/details': (context) => DetailsScreen(),
      },
    );
  }
}
