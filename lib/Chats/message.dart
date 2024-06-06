import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Messages extends StatefulWidget {
  final String email;
  const Messages({super.key, required this.email});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  final Stream<QuerySnapshot> _messageStream = FirebaseFirestore.instance
      .collection('Messages')
      .orderBy('time')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _messageStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("something is wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final data = snapshot.data!.docs;

        return ListView.builder(
          padding: const EdgeInsets.all(5),
          itemCount: data.length,
          shrinkWrap: true,
          primary: true,
          itemBuilder: (context, index) {
            final qs = data[index];
            final t = qs['time'];
            final d = t.toDate();

            if (kDebugMode) {
              print(d.toString());
            }

            return Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Column(
                crossAxisAlignment: widget.email == qs['email']
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 300,
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.purple,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      title: Text(
                        qs['email'],
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 200,
                            child: Text(
                              qs['message'],
                              softWrap: true,
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Text(
                            "${d.hour}:${d.minute}",
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
