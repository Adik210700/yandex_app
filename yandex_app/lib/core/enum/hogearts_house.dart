import 'package:flutter/material.dart';

enum HogeartsHouse {
  gryffindor,
  hufflepuff,
  ravenclaw,
  slytherin,
  unknown;

  String get houseName {
    switch (this) {
      case HogeartsHouse.gryffindor:
        return 'Gryffindor';

      case HogeartsHouse.hufflepuff:
        return 'Hufflepuff';

      case HogeartsHouse.ravenclaw:
        return 'Ravenclaw';

      case HogeartsHouse.slytherin:
        return 'Slytherin';

      case HogeartsHouse.unknown:
        return '';
    }
  }

  Color get color {
    switch (this) {
      case HogeartsHouse.gryffindor:
        return Colors.redAccent;

      case HogeartsHouse.hufflepuff:
        return Colors.orangeAccent;

      case HogeartsHouse.ravenclaw:
        return Colors.blueAccent;

      case HogeartsHouse.slytherin:
        return Colors.green;

      case HogeartsHouse.unknown:
        return Colors.grey;
    }
  }
}
