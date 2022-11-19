import 'dart:math';

import 'package:flame/components.dart';

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

class Boy1 extends SpriteComponent {
  Boy1() : super(size: Vector2(300, 500), anchor: const Anchor(-3, -.8));

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('Boy1.png');
  }
}

// ignore: non_constant_identifier_names


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

// Creating Class named Gfg
abstract class Gfg {
  var boyList = [
    Boy1(),
    Boy2(),
    Boy3()
  ]; //OPTIONAL, code enhancement: change to auto make list based on num of boy images

  int boyNumMax = 0;

  int get getName {
    print(boyNumMax);
    return boyNumMax;
  }

  set setNum(int i) {
    boyNumMax = i;
    print('boy num changed to ' + i.toString());
  }
}
