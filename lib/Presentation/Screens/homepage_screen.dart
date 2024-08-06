import 'package:flutter/material.dart';
import 'search_screen.dart';


class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('About GitHub Users App', style: TextStyle(color: Colors.grey),
        ), // App bar title
          centerTitle: true,
       backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         const Text(
          'GitHub Users App is used to search for users that have accounts on GitHub. one can either search by location or name according to the feature desired. To view a specific user, one selects a desired user and the profile details are displayed. To get started, click the button below!',
          style: TextStyle(fontSize: 24.0),
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
      ),
      ],
    ),
      backgroundColor: Colors.grey,
    );
  }
}


