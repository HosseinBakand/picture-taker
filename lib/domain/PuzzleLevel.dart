

import 'package:collection/collection.dart';
import 'package:objectbox/objectbox.dart';

import 'PuzzleCombination.dart';

@Entity()
class PuzzleLevel {
  PuzzleLevel({
    required this.name,
    required this.order,
    this.isMatchUp = false,
    this.id = 0,
  });

  int id;

  int order;

  String name;

  bool isMatchUp;

  final ToMany<PuzzleCombination> combinations = ToMany();

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other.id == id &&
            other.order == order &&
            other.name == name &&
            other.isMatchUp == isMatchUp &&
            const DeepCollectionEquality()
                .equals(other.combinations, combinations));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      id,
      order,
      name,
      isMatchUp,
      const DeepCollectionEquality().hash(combinations),
    );
  }
}
