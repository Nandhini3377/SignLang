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

@override
  void initState() {
    super.initState();
    
    _load();
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
      body: Column(
     crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // SizedBox(height: 180,),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal:30.0),
             child: Text('Sign Language Translator', style: TextStyle(fontSize:27, color: Colors.black),),
           ),
           SizedBox(height: 80,),
          Container(
            width: MediaQuery.of(context).size.width*0.5,
            child: Icon(Icons.translate,size: 100,)
          ),
SizedBox(height: 80,),
          Container(
            width: 140,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink.shade300),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CameraScreen()));
                },
                child: Text(
                  "Translate",
                  style: TextStyle(color: Colors.white),
                ))),
        ],
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
