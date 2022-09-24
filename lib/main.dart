import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:picture_taker/Screens.dart';
import 'package:picture_taker/screens/LevelsScreen.dart';
import 'package:picture_taker/screens/LevelDesignScreen.dart';

import 'Constants.dart';
import 'data/database/database.dart';
import 'data/datasource/level_datasource.dart';

late ObjectBox objectBox;

Future<void> main() async{

  await initialPaths();
  objectBox = await ObjectBox.create();
  Get.put(objectBox);
  Get.put(LevelDataSourceImpl() as LevelDataSource);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LevelsScreen(),
      routes: Screens.routes(),
    );
  }
}

Future<void> initialPaths()async {
  final Directory path = await getApplicationDocumentsDirectory();
  final String directoryPath = '${path.path}/$APPLICATION_DIRECTORY';
  final String objectDirectoryPath = '${path.path}/$APPLICATION_DIRECTORY/$OBJECT_BOX_DIRECTORY';
  final String imagesDirectoryPath = '${path.path}/$APPLICATION_DIRECTORY/$IMAGES_DIRECTORY';

  if (!await Directory(directoryPath).exists()) {
    Directory(directoryPath).create();
  }
  if (!await Directory(objectDirectoryPath).exists()) {
    Directory(objectDirectoryPath).create();
  }
  if (!await Directory(imagesDirectoryPath).exists()) {
    Directory(imagesDirectoryPath).create();
  }
}


