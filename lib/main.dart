import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'package:provider/provider.dart';
import 'components/search_text.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);
  runApp(
    ChangeNotifierProvider(create: (_) => SearchTextProvider(), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Shazart',
      home: MySplash(),
      debugShowCheckedModeBanner: false,
    );
  }
}
