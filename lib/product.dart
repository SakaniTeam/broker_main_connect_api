 // ignore: camel_case_types
// import 'dart:io';
import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart';

class Images {
  Future<String?> getImageUrl() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      // Assuming you have some mechanism to upload the image and get the URL
      // For demonstration purposes, let's just return the file path as URL
      return image.path;
    } else {
      return null;
    }
  }
}



