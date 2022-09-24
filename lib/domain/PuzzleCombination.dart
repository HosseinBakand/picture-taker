// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes
// ignore_for_file: avoid_dynamic_calls


import 'package:collection/collection.dart';
import 'package:objectbox/objectbox.dart';

import 'PuzzleImage.dart';

@Entity()
class PuzzleCombination {
  PuzzleCombination({this.id = 0});

  int id;

  final ToMany<PuzzleImage> images = ToMany();


  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other.id == id &&
            const DeepCollectionEquality().equals(other.images, images));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      id,
      const DeepCollectionEquality().hash(images),
    );
  }
}
