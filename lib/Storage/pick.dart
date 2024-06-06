// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:dropmatchgame/Storage/show.dart';
import 'package:dropmatchgame/Widgets/snackbar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickScreen extends StatefulWidget {
  const PickScreen({super.key});

  @override
  State<PickScreen> createState() => _PickScreenState();
}

class _PickScreenState extends State<PickScreen> {
  final firebaseStorage = FirebaseStorage.instance;
  File? image;
  String imagePath = "";

  Future<String> storeFileToFirebase(String ref, File file) async {
    UploadTask uploadTask = firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<File?> pickImageFromGallery(BuildContext context) async {
    File? image;
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        image = File(pickedImage.path);
      }
    } catch (e) {
      snackBar(context, e.toString());
    }
    return image;
  }

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            if (image != null) {
              imagePath = await storeFileToFirebase("OUR PICTURE", image!);
              setState(() {});
            }

            var route = MaterialPageRoute(
              builder: (context) => ShowScreen(imagePath: imagePath),
            );
            Navigator.push(context, route);
          },
          icon: const Icon(Icons.image),
        ),
      ),
      body: Center(
        child: GestureDetector(
          onTap: selectImage,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DottedBorder(
              color: Theme.of(context).iconTheme.color!,
              borderType: BorderType.RRect,
              radius: const Radius.circular(15),
              dashPattern: const [10, 4],
              child: image == null
                  ? const SizedBox(
                      height: 120,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.folder_open_outlined, size: 30),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Upload image",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(
                      height: 400,
                      width: double.infinity,
                      child: Image.file(image!),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
