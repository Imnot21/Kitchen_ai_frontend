import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Controller {
   XFile? selectedImage; 

   Future<void> pickImage(BuildContext context, ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      selectedImage = pickedFile;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✔️ Image selected successfully!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("❗ No image selected.")),
      );
    }
  }
}
