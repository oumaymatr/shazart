import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:file_picker/file_picker.dart';

class Model extends StatefulWidget {
  const Model({Key? key}) : super(key: key);

  @override
  State<Model> createState() => _ModelState();
}

class _ModelState extends State<Model> {
  bool _loading = true;
  late File _image;
  List? _output;

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _output = output;
      _loading = false;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
        model: 'assets/model_unquant.tflite', labels: 'assets/labels.txt');
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      File file = File(result.files.first.path!);
      setState(() {
        _image = file;
      });
      classifyImage(_image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child:
                Image.asset("assets/images/paintings.png", fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(0.2), // Adjust opacity as needed
            ),
          ),

          // Content
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: _loading
                        ? SizedBox(
                            height: 100,
                            width: 100,
                            child:
                                Container(), // Empty container to maintain space
                          )
                        : Column(
                            children: [
                              SizedBox(
                                height: 250,
                                child: Image.file(_image),
                              ),
                              const SizedBox(height: 20),
                              _output != null
                                  ? Text(
                                      '${_output?[0]['label']}',
                                      style:
                                          const TextStyle(color: Colors.pink),
                                    )
                                  : Container()
                            ],
                          ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(90.0),
                        child: GestureDetector(
                          onTap: pickImage,
                          child: Container(
                            width: MediaQuery.of(context).size.width - 180,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            decoration: BoxDecoration(
                              color: const Color(0xFF80B2BE),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Text(
                              "Select Image",
                              maxLines: 1,
                              style: TextStyle(
                                  fontFamily: "ZenOldMincho",
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
