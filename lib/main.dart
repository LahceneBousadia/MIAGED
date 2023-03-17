import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:miaged/firebase_options.dart';
import 'LoginPage.dart';
import 'CartPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // initialiser Firebase
  runApp(MyApp());
}

const Color primaryColor = Color(0xFF623CEA);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MIAGED',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF193D5B),
        ),
      ),

      home: login_page(), // Remplacez HomePage() par LoginPage()
    );
  }
}
