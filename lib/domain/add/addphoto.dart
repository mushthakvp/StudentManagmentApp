import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class AddPhotoPov with ChangeNotifier {
  String imageToString = '';

  pickImage() async {
    log('Hello');
    final imageFromGallery = await ImagePicker().getImage(source: ImageSource.gallery);
    final bytes = File(imageFromGallery!.path).readAsBytesSync();
    log('message');
    imageToString = base64Encode(bytes);
    notifyListeners();
  }
}
