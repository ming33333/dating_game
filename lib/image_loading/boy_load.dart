import 'package:flame/components.dart';

class Boy1 extends SpriteComponent {
  Boy1() : super(size: Vector2(300, 500), anchor: const Anchor(-3, -.8));

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('Boy1.png');
  }
}

class Boy2 extends SpriteComponent {
  Boy2() : super(size: Vector2(300, 500), anchor: const Anchor(-0, 0));

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('Boy2.png');
  }
}

class Boy3 extends SpriteComponent {
  Boy3() : super(size: Vector2(300, 500), anchor: const Anchor(-3, -.8));

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('Boy3.png');
  }
}