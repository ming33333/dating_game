import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import 'router.dart';
import 'image_load.dart';
import 'text_load.dart';


void main() {
  final game = RouterGame();
  runApp(GameWidget(game: game));
}
