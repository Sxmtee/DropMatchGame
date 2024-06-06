import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropmatchgame/Chats/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class Chatpage extends StatefulWidget {
  final String email;
  const Chatpage({super.key, required this.email});

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  final firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final TextEditingController messageCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CHAT'),
        actions: [
          MaterialButton(
            onPressed: () {
              _auth.signOut().whenComplete(() {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                );
              });
            },
            child: const Text(
              "signOut",
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.79, //for responsiveness
              child: Messages(email: widget.email),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: messageCtrl,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.purple[100],
                      hintText: 'message',
                      contentPadding: const EdgeInsets.only(
                        left: 14.0,
                        bottom: 8.0,
                        top: 8.0,
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.purple),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (messageCtrl.text.isNotEmpty) {
                      firestore.collection('Messages').doc().set({
                        'message': messageCtrl.text.trim(),
                        'time': DateTime.now(),
                        'email': widget.email,
                      });

                      messageCtrl.clear();
                    }
                  },
                  icon: const Icon(Icons.send_sharp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
