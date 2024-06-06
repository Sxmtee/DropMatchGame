// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:dropmatchgame/Models/shared_preference.dart';
import 'package:dropmatchgame/Screens/auth/sign_in.dart';
import 'package:dropmatchgame/Screens/game/main_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final name = SimplePreferences.getName();

  @override
  void initState() {
    Timer(
      const Duration(seconds: 5),
      () async {
        if (name == '') {
          var route = MaterialPageRoute(
            builder: (context) => const SignIn(),
          );
          Navigator.push(context, route);
        } else {
          var route = MaterialPageRoute(
            builder: (context) => const MainScreen(),
          );
          Navigator.push(context, route);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        color: Colors.white10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: size.height / 2,
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45),
                image: const DecorationImage(
                  image: AssetImage("assets/crypto.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Text(
              "DROP MATCH GAME",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.lightBlueAccent,
              ),
            ),
            const CircularProgressIndicator(
              color: Colors.lightBlueAccent,
            )
          ],
        ),
      ),
    );
  }
}
