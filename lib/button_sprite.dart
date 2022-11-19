import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';

enum ButtonState { unpressed, pressed }

class Boy1 extends SpriteComponent {
  Boy1() : super(size: Vector2(300, 500), anchor: const Anchor(-3, -.8));

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('Boy1.png');
  }
}

class SpriteGroupExample extends FlameGame with HasTappables {
  static const String description = '''
    In this example we show how a `SpriteGroupComponent` can be used to create
    a button which displays different spqrites depending on whether it is pressed
    or not.
  ''';

  @override
  Future<void> onLoad() async {
    add(
      ButtonComponent1()
        ..position = size / 3
        ..size = Vector2(200, 50)
        ..anchor = Anchor.center,
    );
  }
}

int boyNumMax = 1;
mixin HasGameReference on Component {
  SpriteGroupExample get game => findGame()! as SpriteGroupExample;

  List shuffle(List array) {
    //make shuffling shorter
    var random = Random();
    for (var i = array.length - 1; i > 0; i--) {
      var n = random.nextInt(i + 1);
      var temp = array[i];
      array[i] = array[n];
      array[n] = temp;
    }
    return array;
  }
}

class ButtonComponent1 extends SpriteGroupComponent<ButtonState>
    with HasGameRef<SpriteGroupExample>, Tappable {
  @override
  Future<void> onLoad() async {
    final pressedSprite = await gameRef.loadSprite(
      'square.png',
      srcPosition: Vector2(0, 20),
      srcSize: Vector2(60, 20),
    );
    final unpressedSprite = await gameRef.loadSprite(
      'square.png',
      srcSize: Vector2(60, 20),
    );
    sprites = {
      ButtonState.pressed: pressedSprite,
      ButtonState.unpressed: unpressedSprite,
    };
    current = ButtonState.unpressed;
  }

  @override
  bool onTapDown(info) {
    current = ButtonState.pressed;

      add(Boy1());
    

    print("inside tapd down");
    return true;
  }

  @override
  bool onTapUp(info) {
    current = ButtonState.unpressed;
    return true;
  }

  @override
  bool onTapCancel() {
    current = ButtonState.unpressed;
    return true;
  }
}

class ButtonComponent2 extends SpriteGroupComponent<ButtonState>
    with HasGameRef<SpriteGroupExample>, Tappable {
  @override
  Future<void> onLoad() async {
    final pressedSprite = await gameRef.loadSprite(
      'square.png',
      srcPosition: Vector2(100, 20),
      srcSize: Vector2(60, 20),
    );
    final unpressedSprite = await gameRef.loadSprite(
      'square.png',
      srcSize: Vector2(60, 20),
    );
    sprites = {
      ButtonState.pressed: pressedSprite,
      ButtonState.unpressed: unpressedSprite,
    };

    current = ButtonState.unpressed;
  }
}
