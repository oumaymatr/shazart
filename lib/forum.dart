import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kInputDecoration = InputDecoration(
  hintText: 'Enter your email',
  hintStyle: TextStyle(color: Colors.grey),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

final _firestore = FirebaseFirestore.instance;
User? loggedUser;

class Forum extends StatefulWidget {
  const Forum({super.key});

  @override
  _Forum createState() => _Forum();
}

class _Forum extends State<Forum> {
  final textController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  late String msgText;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedUser = user;
      }
    } on Exception {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
                // messagesStream();
              }),
        ],
        title: const Text(
            style: TextStyle(
              color: Colors.white,
            ),
            '⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      textCapitalization:
                          TextCapitalization.sentences, // Capitalize sentences
                      controller: textController,
                      onChanged: (value) {
                        msgText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      textController.clear();
                      Timestamp timestamp = Timestamp.now();
                      _firestore.collection("messages").add({
                        'text': msgText,
                        'sender': loggedUser!.email,
                        'date': timestamp
                      });
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {super.key,
      required this.text,
      required this.sender,
      required this.date,
      required this.isMe});
  final String text;
  final String sender;
  final Timestamp date;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    // Extracted timestamp
    final DateTime dateTime = date.toDate(); // Convert Timestamp to DateTime

    // Format the time
    final formattedTime =
        DateFormat.jm().format(dateTime); // Format time (e.g., "8:24 PM")
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
          ),
          Material(
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            borderRadius: isMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))
                : const BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
            elevation: 20,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 17, color: isMe ? Colors.white : Colors.black54),
              ),
            ),
          ),
          Text(
            "Sent at $formattedTime",
            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  const MessageStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('messages')
          .orderBy('date', descending: true) // Order by timestamp
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        // Extract the documents from the snapshot
        final documents = snapshot.data!.docs.toList();
        return Expanded(
          flex: 1,
          child: ListView(
            reverse: true,
            children: documents.map((doc) {
              // Extract message and sender from the document
              final String messageText = doc['text'] ?? '';
              final String messageSender = doc['sender'] ?? '';
              final String? currentUser = loggedUser!.email;
              // Check if the message is from the current user
              final bool isMe = currentUser == messageSender;
              // Return a ListTile with the message and sender
              final Timestamp date = doc['date'];
              return MessageBubble(
                text: messageText,
                sender: messageSender,
                date: date,
                isMe: isMe,
              );
            }).toList(), // Convert the iterable to a list
          ),
        );
      },
    );
  }
}
