import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:tflite/tflite.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  String answer = "";
  String word="";
  late CameraController cameraController;
  late CameraImage cameraImage;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() async {
    await Tflite.close();
    cameraController.dispose();
    super.dispose();
  }

  void _load() async {
    await Tflite.loadModel(
      model: 'assets/model_unquant.tflite',
      labels: 'assets/labels.txt',
    );
    initCamera();
    configureTts();
  }

  void initCamera() {
    cameraController = CameraController(
      CameraDescription(
        name: '0',
        lensDirection: CameraLensDirection.back,
        sensorOrientation: 0,
      ),
      ResolutionPreset.medium,
    );

    cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {
        cameraController.startImageStream((image) {
          if (mounted) {
            setState(() {
              cameraImage = image;
            });
            applyModelOnImages();
          }
        });
      });
    });
  }

  void applyModelOnImages() async {
    if (cameraImage != null) {
      var predictions = await Tflite.runModelOnFrame(
        bytesList: cameraImage!.planes.map(
              (plane) {
            return plane.bytes;
          },
        ).toList(),
        imageHeight: cameraImage!.height,
        imageWidth: cameraImage!.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 3,
        threshold: 0.1,
        asynch: true,
      );

      setState(() {
        answer = predictions.toString();
        word=predictions![0]['label'].toString().split('').last;
      });
       speakText(word);
    }
  }
    FlutterTts flutterTts = FlutterTts();

Future<void> configureTts() async {
  await flutterTts.setLanguage('en-IN');
  await flutterTts.setVoice({"name": "Microsoft Heera - English (India)", "locale":" en-IN"});
  var v=await flutterTts.getVoices;
  print(v);
  await flutterTts.setSpeechRate(0.2);
  await flutterTts.setVolume(1.0);
}
 
void speakText(String text) async {
 
  await flutterTts.speak(text);
}


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.purple,
      ),
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: answer.isNotEmpty
              ? Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue,
            child: Stack(
              children: [
                Positioned(
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: AspectRatio(
                        aspectRatio: cameraController.value.aspectRatio,
                        child: CameraPreview(
                          cameraController,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.black87,
                      child: Center(
                        child: Text(
                          answer,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
              : Container(),
        ),
      ),
    );
  }
}
