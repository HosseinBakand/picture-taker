

import 'package:flutter/material.dart';
import 'package:picture_taker/screens/LevelsScreen.dart';
import 'package:picture_taker/screens/LevelDesignScreen.dart';

enum Screens{
  LEVELS_SCREEN,
  LEVEL_DESIGN_SCREEN;

  static Map<String, Widget Function(BuildContext)> routes() => {
    LEVELS_SCREEN.route : (context) => const LevelsScreen(),
    LEVEL_DESIGN_SCREEN.route : (context) => const LevelDesignScreen(),
  };
}

extension ScreensExtension on Screens {

  String get route {
    switch (this) {
      case Screens.LEVELS_SCREEN:
        return "level_screens";
      case Screens.LEVEL_DESIGN_SCREEN:
        return "level_design_screen";
    }
  }

}