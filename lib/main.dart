import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import 'full_game.dart';


void main() {
  final game = FullGame();
  runApp(GameWidget(game: game));
}
