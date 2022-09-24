
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:picture_taker/data/datasource/level_datasource.dart';
import 'package:picture_taker/domain/PuzzleLevel.dart';

import '../Screens.dart';

class LevelsScreen extends StatefulWidget {
  const LevelsScreen({super.key});

  @override
  State<LevelsScreen> createState() => _LevelsScreenState();
}

class _LevelsScreenState extends State<LevelsScreen> {
  List<Widget> widgets = [];
  List<PuzzleLevel> levels = [];

  LevelDataSource levelDataSourceImpl = Get.find();

  @override
  void initState() {
    super.initState();
    refreshState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Levels'),
        actions: [
          MaterialButton(
              onPressed: () {
              },
              padding: const EdgeInsets.all(8),
              color: Colors.blue[500],
              child:const Center(child: Text("Export"))
          ),
        ],
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 7,
        children: widgets,
      ),
    );
  }

  refreshState(){
    levels=levelDataSourceImpl.getLevels();
    print(levels.map((e) => e.combinations));
    widgets = [];
    for (int i = 0; i < levels.length; i++) {
      widgets.add(getRow(levels[i]));
    }

    widgets.add(Padding(
      padding: const EdgeInsets.all(10.0),
      child: MaterialButton(
          onPressed: () {
            Navigator.of(context).pushNamed(Screens.LEVEL_DESIGN_SCREEN.route ).then((value) => setState(() {
              refreshState();
            }));
            // widgets.add(getRow(widgets.length));
            // log('button');
          },
          padding: const EdgeInsets.all(8),
          color: Colors.blue[500],
          child:const Center(child: Text("Add level"))
      ),
    ));
  }
  Widget getRow(PuzzleLevel level) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(Screens.LEVEL_DESIGN_SCREEN.route,arguments: level.id ).then((value) => setState(() {
          refreshState();
        }));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[(level.id % 9 + 1) * 100],
          child: Center(child: Text("order ${level.order}\n${level.name}")),
        ),
      ),
    );
  }
}

