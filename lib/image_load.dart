//must run as main.dart file

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';

class MyCrate extends SpriteComponent {
  MyCrate() : super(size: Vector2(1600,800));

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('campus.png');
  }
}

class MyGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    await add(MyCrate());
  }
}

main() {
  final myGame = MyGame();
  runApp(
    GameWidget(
      game: myGame,
    ),
  );
}