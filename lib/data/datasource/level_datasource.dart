import 'package:get/get.dart';
import 'package:objectbox/objectbox.dart';
import 'package:picture_taker/domain/PuzzleLevel.dart';


abstract class LevelDataSource {
  List<PuzzleLevel> getLevels();

  PuzzleLevel getLevel(int id);

  void insertLevel(PuzzleLevel level);


}

class LevelDataSourceImpl extends LevelDataSource {

  final Box<PuzzleLevel> _levelBox = Get.find();

  @override
  List<PuzzleLevel> getLevels() {
    return _levelBox.getAll();
  }

  @override
  PuzzleLevel getLevel(int id) {
    return _levelBox.get(id)!;
  }

  @override
  void insertLevel(PuzzleLevel level) {
    print(level.combinations);
      _levelBox.put(level);
  }
}
