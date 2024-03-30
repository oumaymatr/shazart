import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4EADB),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('history')
            .orderBy('date', descending: false)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "You haven't explored any paintings yet. Take a moment to discover them!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontFamily: "ZenOldMincho",
                  ),
                ),
              ),
            );
          }

          // Reverse the list of documents
          var reversedDocs = snapshot.data!.docs.reversed.toList();

          return ListView.builder(
            itemCount: reversedDocs.length,
            itemBuilder: (context, index) {
              var document = reversedDocs[index];
              var imagePath = document['image'];
              var artistName = document['artist'];
              var dateTime = (document['date'] as Timestamp).toDate();
              var formattedDate =
                  DateFormat('HH:mm-dd/MM/yyyy').format(dateTime);

              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(
                        image: FileImage(File(
                            imagePath)), // Use FileImage for local file paths
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.white.withOpacity(0.5),
                          BlendMode.dstATop,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 50, 16, 10),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 45,
                              ),
                              SizedBox(
                                width: 20,
                                height: 40,
                                child: Image.asset(
                                  'assets/images/brush.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                artistName,
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontFamily: "ZenOldMincho",
                                  fontSize: 22,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.access_time, color: Colors.white),
                              SizedBox(width: 8),
                              Text(
                                formattedDate,
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 20,
                                  fontFamily: "ZenOldMincho",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
