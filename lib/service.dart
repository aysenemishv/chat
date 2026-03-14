import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future uploadImage(File imagePath) async {
  var uri = Uri.parse('https://api.escuelajs.co/api/v1/files/upload');

  var request = http.MultipartRequest('POST', uri);
  debugPrint('ddfsvsv');
  request.files.add(
    await http.MultipartFile.fromPath(
      'file', // field name expected by backend
      imagePath.path,
    ),
  );
  debugPrint('23329g');
  var res = await request.send();
  var response = await http.Response.fromStream(res);

  debugPrint(response.body);
  debugPrint(response.statusCode.toString());

  if (response.statusCode == 201) {
    debugPrint("Upload success");
  } else {
    debugPrint("Upload failed");
  }
}

final ImagePicker _picker = ImagePicker();

Future<File?> pickImage() async {
  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

  if (image != null) {
    debugPrint('object');
    return File(image.path);
  }
  return null;
}
