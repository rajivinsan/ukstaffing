import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class DocsPickerServices {
  static Future<String?> getImages({
    required int index,
    bool isImage = true,
  }) async {
    if (index == 0) {
      final file = await ImagePicker().pickImage(source: ImageSource.camera);
      if (file != null) {
        return file.path;
      }
    } else {
      FilePickerResult? result;
      if (isImage) {
        result = await FilePicker.platform.pickFiles(type: FileType.image);
      } else {
        result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['jpg', 'pdf', 'doc'],
        );
      }
      if (result != null) {
        File file = File(result.files.single.path!);
        return file.path;
      } else {
        // User canceled the picker
      }
    }
    return null;
  }

  static Future<String?> getdocs({required int index}) async {
    if (index == 0) {
      final file = await ImagePicker().pickImage(source: ImageSource.camera);
      if (file != null) {
        return file.path;
      }
    } else {
      final file = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (file != null) {
        return file.path;
      }
    }
    return null;
  }
}
