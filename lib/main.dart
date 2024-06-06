import 'package:dropmatchgame/Data/db_helper.dart';
import 'package:dropmatchgame/Models/shared_preference.dart';
// import 'package:dropmatchgame/Screens/auth/splash_screen.dart';
import 'package:dropmatchgame/chats/register.dart';
import 'package:dropmatchgame/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SimplePreferences.init(); //initialize sharedpreference
  DataBaseHelper.instance.database; //initialize local database(sqflite)
  await Firebase.initializeApp(
    //initialize main database(firebase)
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drop Match Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const RegisterScreen(),
    );
  }
}
