import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'dart:convert';

import 'package:flutter/services.dart';

class Questions extends FlameGame {
  List _items = [];

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/sample.json');
    final data = await json.decode(response);
    _items = data["items"];
  
  }
}
