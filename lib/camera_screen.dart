import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:palette_generator/palette_generator.dart';
import 'dart:io';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  XFile? _image;
  Color? _dominantColor;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = XFile(pickedFile.path);
      });

      // Extract dominant color from the image
      final paletteGenerator = await PaletteGenerator.fromImageProvider(
        FileImage(File(pickedFile.path)),
      );

      setState(() {
        _dominantColor = paletteGenerator.dominantColor?.color ?? Colors.grey;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Color Scanner"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_image != null)
            Image.file(File(_image!.path), height: 300),
          if (_dominantColor != null)
            Text(
              "Dominant Color: ${_dominantColor!.toString()}",
              style: TextStyle(fontSize: 18, color: _dominantColor),
            ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _pickImage,
            child: Text("Scan Object"),
          ),
        ],
      ),
    );
  }
}