

import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:path_provider/path_provider.dart';

import '../Constants.dart';


Future<String> generateImageHash(File imageFile) async {
  var image_bytes = imageFile.readAsBytesSync().toString();
  var bytes = utf8.encode(image_bytes); // data being hashed
  String digest = sha256.convert(bytes).toString();
  print("This is image Digest :  $digest");
  return digest;
}

Future<File> saveACopy(File imageFile, String imageName) async {
  final Directory path = await getApplicationDocumentsDirectory();
  final String directoryPath = '${path.path}/$APPLICATION_DIRECTORY/$IMAGES_DIRECTORY';

  if (!await Directory(directoryPath).exists()) {
    Directory(directoryPath).create();
  }

  final File newImage = await imageFile
      .copy('$directoryPath/$imageName.png');
  print("This is image Digest :  ${newImage.path}");
  return newImage;
}