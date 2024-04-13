import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:sl/image_results.dart';
import 'package:tflite/tflite.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController cameraController;
  late List<CameraDescription> cameras;
  String answer = "";
  String word = "";
  late FlutterTts flutterTts;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _initializeTflite();
    flutterTts = FlutterTts();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    await cameraController.initialize();
    setState(() {});
  }

  Future<void> _initializeTflite() async {
    await Tflite.loadModel(
      model: 'assets/model_unquant.tflite',
      labels: 'assets/labels.txt',
    );
  }

  @override
  void dispose() async {
    await Tflite.close();
    await cameraController.dispose();
    super.dispose();
  }

  Future<void> _captureAndProcessImage() async {
    XFile? imageFile = await cameraController.takePicture();
    
    if (imageFile != null) {
      
      List<dynamic>? predictions = await Tflite.runModelOnImage(
        path: imageFile.path,
        numResults: 5,
        threshold: 0.1,
        imageMean: 127.5,
        imageStd: 127.5,
      );

      if (predictions != null && predictions.isNotEmpty) {
        setState(() {
          answer = predictions.toString();
          word = predictions[0]['label'].toString().split(' ')[1];
        });
        
       
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImageResultsScreen(imagePath: imageFile.path, predictions: predictions,word: word,),
          ),
        );
         _speakText(word);
      }
    }
  }

  Future<void> _speakText(String text) async {
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    if (!cameraController.value.isInitialized) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera Screen'),
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            child: CameraPreview(cameraController)),
          Positioned(
            bottom: 16,
            left: 16,
            child: ElevatedButton(
              onPressed: _captureAndProcessImage,
              child: Icon(Icons.camera_alt),
            ),
          ),
        ],
      ),
    );
  }
}
