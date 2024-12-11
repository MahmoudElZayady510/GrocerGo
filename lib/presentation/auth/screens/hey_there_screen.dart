import 'package:flutter/material.dart';

class HeyThereScreen extends StatelessWidget {
  const HeyThereScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset('assets/pics/GrocerGo.png',),
          Text('Hey There!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),
          ),
          Text('Log in or Sign up for a more personalized experience.'),
          ElevatedButton(onPressed: (){},
              child: Text('Continue with Google'))
        ],
      ),
    );
  }
}
