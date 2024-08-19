import 'package:flutter/material.dart';
import 'search_screen.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(  // Center the whole content
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Welcome to Github Users App',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,  // Center the text
              ),
              const SizedBox(height: 40),
              Image.asset(
                'assets/global_location.jpg',
                height: 400,
                width: 800,
              ),
              const SizedBox(height: 30),
              const Divider(thickness: 2, color: Colors.black,),
              const Text(
                'Easily find Github users all over the world. Click the button below to get started!',
                style: TextStyle(fontSize: 20.0),
                textAlign: TextAlign.center,  // Center and justify the text
              ),
              const SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                child: const Text('Checkout GitHub Users'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.grey.shade200,
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey.shade200,
    );
  }
}
