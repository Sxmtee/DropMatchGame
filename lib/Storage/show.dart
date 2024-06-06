import 'package:flutter/material.dart';

class ShowScreen extends StatelessWidget {
  final String imagePath;
  const ShowScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        radius: 100,
        backgroundImage: NetworkImage(imagePath),
      ),
    );
  }
}
