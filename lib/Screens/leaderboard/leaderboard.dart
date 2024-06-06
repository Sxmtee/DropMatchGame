import 'package:dropmatchgame/Data/crud_helper.dart';
import 'package:flutter/material.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({super.key});

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  late UserDBHelper users;

  @override
  void initState() {
    users = UserDBHelper();
    super.initState();
  }

  Future<void> onRefresh() async {
    setState(() {
      users.getScores();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: users.getScores(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("ERROR: ${snapshot.error}"),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text("NO DATA"),
            );
          } else {
            final items = snapshot.data;

            return ListView.builder(
              itemCount: items!.length,
              itemBuilder: (context, index) {
                final user = items[index];

                return Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(8.0),
                    leading: Text("${index + 1}"),
                    title: Text("${user.score}"),
                    trailing: IconButton(
                      onPressed: () {
                        users.deleteUser((user.id)!);
                        onRefresh();
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
