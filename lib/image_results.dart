
import 'dart:io';
import 'package:flutter/material.dart';

class ImageResultsScreen extends StatelessWidget {
  final String imagePath;
  final List<dynamic> predictions;
  String word;

  ImageResultsScreen({Key? key, required this.imagePath, required this.predictions,required this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Results'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Image.file(
              File(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(word),
                  subtitle: Text(predictions[index]['confidence'].toString()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

