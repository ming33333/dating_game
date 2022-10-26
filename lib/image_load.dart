import 'package:flame/components.dart';

class School extends SpriteComponent {
  School() : super(size: Vector2(1600, 800));

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('campus.png');
  }
}

class Town extends SpriteComponent {
  Town() : super(size: Vector2(1600, 1000));

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('town.png');
  }
}

class Boy1 extends SpriteComponent {
  Boy1() : super(size: Vector2(300, 500), anchor: const Anchor(-3, -.8));

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('Boy1.png');
  }
}
