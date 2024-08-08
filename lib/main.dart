import 'package:flutter/material.dart';
import '../Presentation/Screens/splash_screen.dart';
import 'domain/entities/user.dart';
import 'presentation/Screens/user_profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GITHUB USERS APP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
      home:  const SplashScreen(),



    );
  }
}

