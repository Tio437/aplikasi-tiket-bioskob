import 'package:flutter/material.dart';

import 'movie_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cineplex Movie App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF072A1D),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF072A1D),
          primary: const Color(0xFF072A1D),
          secondary: const Color(0xFFD4AF37),
        ),
        useMaterial3: true,
      ),
      home: const MovieListScreen(),
    );
  }
}

