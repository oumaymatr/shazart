import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:file_picker/file_picker.dart';
import 'components/search_history.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Model extends StatefulWidget {
  const Model({Key? key}) : super(key: key);

  @override
  State<Model> createState() => _ModelState();
}

class _ModelState extends State<Model> {
  final _firestore = FirebaseFirestore.instance;
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
      await classifyImage(_image);
      _firestore.collection('history').add({
        'image': _image.path, // Example: storing image path
        'artist': _output?[0]['label'] ?? 'Unknown',
        'date': Timestamp.now(), // Storing current timestamp
      });
      Provider.of<SearchHistoryProvider>(context, listen: false)
          .addToSearchHistory(
        SearchHistory(
          image: _image,
          artistName: _output?[0]['label'] ?? 'Unknown',
          dateTime: DateTime.now(),
        ),
      );
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
            padding: const EdgeInsets.all(0),
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
                        : Stack(
                            children: [
                              Positioned(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(50),
                                    bottomRight: Radius.circular(50),
                                  ),
                                  child: Container(
                                    color: Colors.black.withOpacity(
                                        0.7), // Adjust opacity as needed
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 50,
                                    ),
                                    SizedBox(
                                      height: 250,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.file(_image)),
                                    ),
                                    const SizedBox(height: 20),
                                    _output != null
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "It's a painting of  ",
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "ZenOldMincho"),
                                              ),
                                              Text(
                                                '${_output?[0]['label']}',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "MrDafoe",
                                                    fontSize: 30),
                                              ),
                                            ],
                                          )
                                        : Container(),
                                    const SizedBox(height: 30),
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF80B2BE),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 20),
                                      ),
                                      child: Text(
                                        "See more of this artist",
                                        style: TextStyle(
                                          fontFamily: "ZenOldMincho",
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
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

class PaintingBox extends StatelessWidget {
  final File image;

  const PaintingBox({required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2), // Painting frame
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
            18), // Make it slightly smaller than the frame
        child: SizedBox(
          height: 250, // Adjust height as needed
          width: 250, // Adjust width as needed
          child: Image.file(image),
        ),
      ),
    );
  }
}
