import 'package:dating_game/button_sprite.dart';
import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import 'full_game.dart';


void main() {
  final game = SpriteGroupExample();
  runApp(GameWidget(game: game));
}
