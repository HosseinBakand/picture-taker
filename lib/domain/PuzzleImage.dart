


import 'package:flutter/widgets.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class PuzzleImage {
  PuzzleImage(this.path, {this.id = 0});

  int id;

  late String path;

}
