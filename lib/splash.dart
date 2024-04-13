import 'package:flutter/material.dart';

import 'home.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Sign Language Translator',
            style: TextStyle(fontSize: 27, color: Colors.black),
          ),
          Container(
            child: Image.asset('assets/sign.jpg'),
          ),
          Container(
              width: 140,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink.shade300),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyHomePage()));
                  },
                  child: Text(
                    "Get Started",
                    style: TextStyle(color: Colors.white),
                  ))),
        ],
      ),
    );
  }
}
