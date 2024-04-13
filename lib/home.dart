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
//   String word = "";
//   final TextEditingController _txt=TextEditingController();
//   FlutterTts flutterTts = FlutterTts();

// Future<void> configureTts() async {
//   await flutterTts.setLanguage('en-IN');
//   await flutterTts.setVoice({"name": "Microsoft Heera - English (India)", "locale":" en-IN"});
//   var v=await flutterTts.getVoices;
//   print(v);
//   await flutterTts.setSpeechRate(0.5);
//   await flutterTts.setVolume(1.0);
// }
//   void _incrementCounter(value) {
//     setState(() {
//      word=value;
//     });
//   }
// void speakText(String text) async {

//   await flutterTts.speak(text);
// }

// void stopSpeaking() async {
//   await flutterTts.stop();
// }
  late CameraController cameraController;
  late List<CameraDescription> cameras;
  @override
  void initState() {
    super.initState();
    //_initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    await cameraController.initialize();
    setState(() {});
  }

  void _load() async {
    if (mounted) {
      setState(() {});
    }
    await Tflite.loadModel(
      model: 'assets/model_unquant.tflite',
      labels: 'assets/labels.txt',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   title: Text('Sign Language Translator'),
      // ),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // SizedBox(height: 180,),
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed:()async {
      //     await configureTts();
      //     _incrementCounter(_txt.text);
      //     speakText(_txt.text);
      //   },

      //   child: const Icon(Icons.speaker),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
