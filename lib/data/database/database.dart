
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';
import 'package:path_provider/path_provider.dart';
import 'package:picture_taker/Constants.dart';
import 'package:picture_taker/domain/PuzzleLevel.dart';
import 'package:picture_taker/objectbox.g.dart';
import 'package:path/path.dart' as path;

class ObjectBox {
  /// The Store of this app.
  late final Store store;
  late final Box<PuzzleLevel> levelBox;

  ObjectBox._create(this.store) {
    levelBox = store.box<PuzzleLevel>();
    Get.put(levelBox);
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    final Directory path = await getApplicationDocumentsDirectory();
    final String directoryPath = '${path.path}/$APPLICATION_DIRECTORY/$ObjectBox';

    final store = await openStore(directory: directoryPath);
    return ObjectBox._create(store);
  }
}