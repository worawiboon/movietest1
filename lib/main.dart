import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movietest/views/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF2A0944),
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFF2A0944),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF3B185F),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          titleLarge:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        cardTheme: CardTheme(
          color: Color(0xFF3B185F).withOpacity(0.5),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        listTileTheme: ListTileThemeData(
          tileColor: Color(0xFF3B185F).withOpacity(0.3),
          textColor: Colors.white,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
