import 'package:flame/components.dart';

class School extends SpriteComponent {
  School() : super(size: Vector2(1600, 800));

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('campus.png');
  }
}
class Cafe extends SpriteComponent {
  Cafe() : super(size: Vector2(1600, 800));

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('cafe.png');
  }
}

class Town extends SpriteComponent {
  Town() : super(size: Vector2(1600, 1000));

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('town.png');
  }
}


