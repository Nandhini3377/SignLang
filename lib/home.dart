import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:sl/camera.dart';
import 'package:tflite/tflite.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late CameraController cameraController;
  late List<CameraDescription> cameras;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Translating silence into understanding',
                style: TextStyle(
                    fontSize: 19,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Image.asset('assets/signl.jpg')),
            SizedBox(
              height: 50,
            ),
            Container(
                width: 160,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        side: BorderSide(color: Colors.blue.shade800),
                        backgroundColor: Colors.white),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CameraScreen()));
                    },
                    child: Text(
                      "Translate",
                      style: TextStyle(color: Colors.black),
                    ))),
          ],
        ),
      ),
    );
  }
}
