// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropmatchgame/Models/shared_preference.dart';
import 'package:dropmatchgame/Screens/auth/sign_up.dart';
import 'package:dropmatchgame/Screens/game/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool showPassword = false;

  void switchPassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  void login() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailCtrl.text,
        password: passwordCtrl.text,
      );

      var id = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection("users").doc(id).get();

      SimplePreferences.setName(emailCtrl.text);

      var route = MaterialPageRoute(
        builder: (context) => const MainScreen(),
      );
      Navigator.push(context, route);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 50, left: 30, right: 30),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  height: size.height / 3,
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45),
                    image: const DecorationImage(
                      image: AssetImage("assets/crypto.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    label: const Text("E-mail"),
                    hintText: "Enter Your E-mail Address",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.email),
                  ),
                  validator: (value) {
                    var emailValid = EmailValidator.validate(value!);
                    if (!emailValid) {
                      return "Invalid E-mail Address";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: !showPassword,
                  controller: passwordCtrl,
                  decoration: InputDecoration(
                    label: const Text("Password"),
                    hintText: "Enter Your Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: switchPassword,
                      icon: showPassword
                          ? const Icon(Icons.remove_red_eye)
                          : const Icon(Icons.visibility_off),
                    ),
                  ),
                  validator: (value) {
                    if (value!.length < 6) {
                      return "Password weak";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      login();
                    }
                  },
                  color: Colors.blue,
                  shape: const StadiumBorder(),
                  minWidth: 200,
                  height: 50,
                  child: const Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Do Not Have An Account ?",
                      style: TextStyle(fontSize: 17, color: Colors.black),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        var route = MaterialPageRoute(
                          builder: (context) => const SignUp(),
                        );
                        Navigator.push(context, route);
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
