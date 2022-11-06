library dating_game.globals;


import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;




  // Fetch content from the json file
Future<String> getJson() {


  return rootBundle.loadString('questions.json');
}

