import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:desktop_drop/desktop_drop.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:picture_taker/data/datasource/level_datasource.dart';
import 'package:picture_taker/domain/PuzzleCombination.dart';
import 'package:picture_taker/domain/PuzzleImage.dart';
import 'package:picture_taker/domain/PuzzleLevel.dart';

import '../Constants.dart';

class LevelDesignScreen extends StatefulWidget {
  const LevelDesignScreen({super.key});

  @override
  State<LevelDesignScreen> createState() => _LevelDesignScreenState();
}

class _LevelDesignScreenState extends State<LevelDesignScreen> {
  List<PuzzleCombination> items = [];
  bool _dragging = false;

  bool _isEditing = false;
  late PuzzleLevel editLevel;

  String _name = '';
  int _order = 0;
  bool isSwitched = false;

  LevelDataSource levelDataSourceImpl = Get.find();

  @override
  void initState() {

    super.initState();

  }

  bool isInited = false;
  void initStates(){
    if(!isInited){
      final int? arg = ModalRoute.of(context)?.settings.arguments as int?;
      if (arg != null) {
        PuzzleLevel level = levelDataSourceImpl.getLevel(arg);
        _isEditing = true;
        setState(() {
          editLevel = level;
          items.addAll(level.combinations);
          _name = level.name;
          _order = level.order;
          isSwitched = level.isMatchUp;
        });
      }
      isInited = true;
    }

  }

  @override
  Widget build(BuildContext context) {
    // ?.settings.arguments as int;
  initStates();

    return Scaffold(
        appBar: AppBar(
          title: Text('Add Level'),
          actions: [
            Switch(
              onChanged: (bool) {
                setState(() {
                  isSwitched = bool;
                });
              },
              value: isSwitched,
              activeColor: Colors.blue,
              activeTrackColor: Colors.white,
              inactiveThumbColor: Colors.blueGrey,
              inactiveTrackColor: Colors.white,
            ),
          ],
        ),
        body: Column(
          children: [
            TextField(
              controller: TextEditingController(text: _name),
              onChanged: (text) {
                _name = text;
              },
              decoration: const InputDecoration(hintText: 'level name'),
            ),
            TextField(
              controller: TextEditingController(text: _order.toString()),
              onChanged: (text) {
                _order = int.parse(text);
              },
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: const InputDecoration(
                hintText: 'level order',
              ),
              keyboardType: TextInputType.number,
            ),
            Expanded(
                child: Stack(
              children: [
                Center(
                  child: DropTarget(
                    onDragDone: (detail) async {
                      //todo check png
                      var paths = detail.files.map((e) => e.path).toList();
                      PuzzleCombination combination =
                      await processImages(paths);

                      setState(() {
                        print(combination.images);
                        items.add(combination);
                      });
                    },
                    onDragUpdated: (details) {},
                    onDragEntered: (detail) {
                      setState(() {
                        _dragging = true;
                        // offset = detail.localPosition;
                      });
                    },
                    onDragExited: (detail) {
                      setState(() {
                        _dragging = false;
                        //   offset = null;
                      });
                    },
                    child: Container(
                      color: _dragging
                          ? Colors.blue.withOpacity(0.2)
                          : Colors.black26,
                      child: const Center(child: Text("Drop here")),
                    ),
                  ),
                ),
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 7,
                    childAspectRatio: 1,
                  ),
                  itemCount: items.length,
                  itemBuilder: getRowList,
                ),

              ],
            )),
          ],
        ),
        floatingActionButton: Wrap(
          children: [
            FloatingActionButton(
              heroTag: "plusButton",
              onPressed: () {
                pickFile().then((value) async {
                  PuzzleCombination combination = await processImages(value);

                  setState(() {
                    items.add(combination);
                  });
                });
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
            const SizedBox(width: 20),
            FloatingActionButton(
              onPressed: () {
                if (!_isEditing) {
                  var a = PuzzleLevel(name: _name, order: _order, isMatchUp: isSwitched);
                  a.combinations.addAll(items);
                  levelDataSourceImpl.insertLevel(a);
                } else {
                  var size = editLevel.combinations.length;
                  editLevel.combinations.removeRange(0, size);
                  editLevel.combinations.addAll(items);
                  editLevel.name = _name;
                  editLevel.order = _order;
                  editLevel.isMatchUp= isSwitched;
                  levelDataSourceImpl.insertLevel(editLevel);
                }

                Navigator.pop(context);
              },
              tooltip: 'Increment',
              child: const Icon(Icons.done),
            ),
          ],
        ));
  }


  Widget getRowList(BuildContext context, int i) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.blueGrey,
        elevation: 10,
        child: Stack(children: [


           GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 7,
              childAspectRatio: 1,
            ),
            itemCount: items[i].images.length,
            itemBuilder: ((context, j) =>
                LayoutBuilder(builder: (context, constraints) {
                  return SizedBox.fromSize(
                    size: Size.square(constraints.maxWidth),
                    child: Image.file(File(items[i].images[j].path)),
                  );
                })),
          ),
          GestureDetector(
            onTap: () {
              // Navigator.of(context).pushNamed(Screens.LEVEL_DESIGN_SCREEN.route,arguments: level.id ).then((value) => setState(() {
              //   refreshState();
              // }));

              print("objectobjectobject");
              showAlertDialog(context,items[i]);
            },
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(Icons.delete, color: Colors.white,),
            ),
          ),

        ],)
      );
  }

  Future<List<String?>> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['png'],
    );
    List<String?> files = [];
    if (result != null) {
      files = result.paths;
    } else {
      // User canceled the picker
    }
    return files;
  }

  Future<PuzzleCombination> processImages(List<String?> paths) async {
    PuzzleCombination combination = PuzzleCombination();
    for (var path in paths) {
      if (path != null) {
        PuzzleImage image = await getPuzzleImage(path);
        combination.images.add(image);
      }
    }
    return combination;
  }

  Future<PuzzleImage> getPuzzleImage(String path) async {
    File file = File(path);
    String imageName = await generateImageHash(file);
    File newFile = await saveACopy(file, imageName);
    return PuzzleImage(newFile.path);
  }

  Future<String> generateImageHash(File imageFile) async {
    var image_bytes = imageFile.readAsBytesSync().toString();
    var bytes = utf8.encode(image_bytes); // data being hashed
    String digest = sha256.convert(bytes).toString();
    print("This is image Digest :  $digest");
    return digest;
  }

  Future<File> saveACopy(File imageFile, String imageName) async {
    final Directory path = await getApplicationDocumentsDirectory();
    final String directoryPath =
        '${path.path}/$APPLICATION_DIRECTORY/$IMAGES_DIRECTORY';

    final File newImage = await imageFile.copy('$directoryPath/$imageName.png');
    print("This is image Digest :  ${newImage.path}");
    return newImage;
  }

  showAlertDialog(BuildContext context, PuzzleCombination item) {
    // set up the buttons
    Widget cancelButton = MaterialButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = MaterialButton(
      child: Text("confirm"),
      onPressed:  () {
        setState(() {
          items.remove(item);
        });
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("Are you sure?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

