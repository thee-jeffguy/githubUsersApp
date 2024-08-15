import 'package:flutter/material.dart';
import 'search_screen.dart';


class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title:const Text('About GitHub Users App',), // App bar title
      //     centerTitle: true,
      //  backgroundColor: Colors.black,
      //   foregroundColor: Colors.grey.shade200,
      // ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.all(10.0)),
          Text('Welcome to Github Users App', style: TextStyle(fontSize: 20.0, decorationColor: Colors.black),),
          SizedBox(height: 40,),
          Image.asset('assets/global_location.jpg',
          height: 300,
            width: 600,
          ),
         SizedBox(height: 30,),
         const Text(
          'Easily find Github users all over the world. Click the button below to get started!',
           style: TextStyle(fontSize: 20.0) ,
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
        style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.grey.shade200),
      ),
      ],
    ),
      backgroundColor: Colors.grey.shade200,
    );
  }
}


