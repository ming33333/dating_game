import 'dart:html';
import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/image_composition.dart';
import 'package:flame/input.dart';
import 'package:flame/rendering.dart';
import 'package:flutter/rendering.dart';
import 'text_load.dart';
import 'image_loading/image_load.dart';
import 'image_loading/boy_load.dart';
import 'package:flame/components.dart';
import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:math';
import 'dart:io';
import 'question_load.dart' as ql;
import 'dart:math';

import 'package:flutter/services.dart';

class FullGame extends FlameGame with HasTappableComponents {
  late final RouterComponent router;
  @override
  Future<void> onLoad() async {
    add(
      router = RouterComponent(
        //align name of routes and map names
        routes: {
          'test': Route(TestScreen.new),
          'home': Route(StartPage.new),
          'level1': Route(Level1Page.new),
          'level2': Route(Level2Page.new),
          'pause': PauseRoute(),
        },
        initialRoute: 'test',
      ),
    );
  }
}
abstract class Gfg {

}
mixin HasGameReference on Component {
  FullGame get game => findGame()! as FullGame;

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

  var boyList = [
    Boy1(),
    Boy2(),
    Boy3()
  ]; //OPTIONAL, code enhancement: change to auto make list based on num of boy images
  final int boyNumMax = 0;
  get numList => List<int>.generate(boyNumMax,
      (i) => i); //OPTIONAL, code enhancemen: figure out a way to short shuffle
  get numListShuffle => shuffle(numList);
  int get getName {
    print(boyNumMax);
    return boyNumMax;
  }

  set setNum(int i) {
    final boyNumMax = i;
    print('boy num changed to ' + i.toString());
  }
}

class TestScreen extends Component
    with TapCallbacks, HasGameRef<FullGame>, HasGameReference {

  static const initialCapacity = 16;
  late Sprite background;
  @override
  Future<void> onLoad() async {
    Map myData = json.decode(await ql.getJson());

    addAll([
      TextBoxComponent(
        text: boyNumMax
            .toString(), // fix to randomize questions, text: myData.keys.elementAt(1).toString()
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Color(0x66ffffff),
            fontSize: 16,
          ),
        ),
        align: Anchor.center,
        size: gameRef.canvasSize,
      ),
    ]);
  }

  @override
  bool containsLocalPoint(Vector2 point) => true;

  @override
  void onTapUp(TapUpEvent event) => gameRef.router.pushNamed('home');
}

class StartPage extends Component with HasGameRef<FullGame>, HasGameReference {
  StartPage() {
    
    addAll([
      School(),
      _logo = TextComponent(
        text: numListShuffle.toString(),
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 64,
            color: Color(0xFFC8FFF5),
            fontWeight: FontWeight.w800,
          ),
        ),
        anchor: const Anchor(0.5, 3.5),
      ),
      _button1 = RoundedButton(
          //FIX: adjust to screensize
          text: 'Class',
          action: () => setNum = 1,
          color: const Color(0xffadde6c),
          borderColor: const Color(0xffedffab),
          anchor: const Anchor(-0.8, 6)),
      _button2 = RoundedButton(
          //FIX: adjust to screensize
          text: 'Cafeteria',
          action: () => gameRef.router.pushNamed('level2'),
          color: const Color(0xffdebe6c),
          borderColor: const Color(0xfffff4c7),
          anchor: const Anchor(3.2, 1)),
    ]);
  }

  late final TextComponent _logo;
  late final RoundedButton _button0;
  late final RoundedButton _button1;
  late final RoundedButton _button2;

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    _logo.position = Vector2(size.x / 2, size.y / 3);
    _button1.position = Vector2(size.x / 2, _logo.y + 80);
    _button2.position = Vector2(size.x / 2, _logo.y + 140);
  }
}

class Background extends Component {
  Background(this.color);
  final Color color;

  @override
  void render(Canvas canvas) {
    canvas.drawColor(color, BlendMode.srcATop);
  }
}

class RoundedButton extends PositionComponent with TapCallbacks {
  RoundedButton({
    required this.text,
    required this.action,
    required Color color,
    required Color borderColor,
    super.anchor = Anchor.center,
  }) : _textDrawable = TextPaint(
          style: const TextStyle(
            fontSize: 20,
            color: Color(0xFF000000),
            fontWeight: FontWeight.w800,
          ),
        ).toTextPainter(text) {
    size = Vector2(150, 40);
    _textOffset = Offset(
      (size.x - _textDrawable.width) / 2,
      (size.y - _textDrawable.height) / 2,
    );
    _rrect = RRect.fromLTRBR(0, 0, size.x, size.y, Radius.circular(size.y / 2));
    _bgPaint = Paint()..color = color;
    _borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = borderColor;
  }

  final String text;
  final void Function() action;
  final TextPainter _textDrawable;
  late final Offset _textOffset;
  late final RRect _rrect;
  late final Paint _borderPaint;
  late final Paint _bgPaint;

  @override
  void render(Canvas canvas) {
    canvas.drawRRect(_rrect, _bgPaint);
    canvas.drawRRect(_rrect, _borderPaint);
    _textDrawable.paint(canvas, _textOffset);
  }

  @override
  void onTapDown(TapDownEvent event) {
    scale = Vector2.all(1.05);
  }

  @override
  void onTapUp(TapUpEvent event) {
    scale = Vector2.all(1.0);
    action();
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    scale = Vector2.all(1.0);
  }
}

abstract class SimpleButton extends PositionComponent with TapCallbacks {
  SimpleButton(this._iconPath, {super.position}) : super(size: Vector2.all(40));

  final Paint _borderPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = const Color(0x66ffffff);
  final Paint _iconPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = const Color(0xffaaaaaa)
    ..strokeWidth = 7;
  final Path _iconPath;

  void action();

  @override
  void render(Canvas canvas) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(size.toRect(), const Radius.circular(8)),
      _borderPaint,
    );
    canvas.drawPath(_iconPath, _iconPaint);
  }

  @override
  void onTapDown(TapDownEvent event) {
    _iconPaint.color = const Color(0xffffffff);
  }

  @override
  void onTapUp(TapUpEvent event) {
    _iconPaint.color = const Color(0xffaaaaaa);
    action();
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    _iconPaint.color = const Color(0xffaaaaaa);
  }
}

class BackButton extends SimpleButton with HasGameRef<FullGame> {
  BackButton()
      : super(
          Path()
            ..moveTo(22, 8)
            ..lineTo(10, 20)
            ..lineTo(22, 32)
            ..moveTo(12, 20)
            ..lineTo(34, 20),
          position: Vector2.all(10),
        );

  @override
  void action() => gameRef.router.pop();
}

class PauseButton extends SimpleButton with HasGameRef<FullGame> {
  PauseButton()
      : super(
          Path()
            ..moveTo(14, 10)
            ..lineTo(14, 30)
            ..moveTo(26, 10)
            ..lineTo(26, 30),
          position: Vector2(60, 10),
        );
  @override
  void action() => gameRef.router.pushNamed('pause');
}

class Level1Page extends Component with HasGameReference {
  @override
  Future<void> onLoad() async {
    RoundedButton;
    addAll([
      Town(),
      boyList[numListShuffle[0]],
      MyTextBox(
        '"level 1 Indeed, I am a criminal. My crime is that of curiosity."',
      )..anchor = const Anchor(0, -2),
      RoundedButton(
          text: 'Choice 1',
          color: const Color(0xffadde6c),
          borderColor: const Color(0xffedffab),
          anchor: const Anchor(-0.8, -8),
          action: () async {
            Questions();
          }),
      RoundedButton(
          text: 'Choice 2',
          color: const Color(0xffadde6c),
          borderColor: const Color(0xffedffab),
          anchor: const Anchor(-0.8, -9),
          action: () async {
            await game.router.pushAndWait(RateRoute());
          }),
      RoundedButton(
          text: 'Choice 3',
          color: const Color(0xffadde6c),
          borderColor: const Color(0xffedffab),
          anchor: const Anchor(-0.8, -10),
          action: () async {
            await game.router.pushAndWait(RateRoute());
          }),
      RoundedButton(
          text: numListShuffle.toString(),
          color: const Color(0xffadde6c),
          borderColor: const Color(0xffedffab),
          anchor: const Anchor(-0.8, -11),
          action: () async {
            await game.router.pushAndWait(RateRoute());
          }),
      BackButton()
    ]);
  }
}

class Level2Page extends Component with HasGameReference {
  @override
  Future<void> onLoad() async {
    Map myData = json.decode(await ql.getJson());

    addAll([
      Cafe(),
      boyList[boyNumMax],
      MyTextBox(
        myData.keys.elementAt(0).toString(),
      )..anchor = const Anchor(0, -2),
      RoundedButton(
          text: 'Choice 1',
          color: const Color(0xffadde6c),
          borderColor: const Color(0xffedffab),
          anchor: const Anchor(-0.8, -8),
          action: () => getName),
      RoundedButton(
          text: 'Choice 2',
          color: const Color(0xffadde6c),
          borderColor: const Color(0xffedffab),
          anchor: const Anchor(-0.8, -9),
          action: () => setNum =1),
      RoundedButton(
          text: 'Choice 3',
          color: const Color(0xffadde6c),
          borderColor: const Color(0xffedffab),
          anchor: const Anchor(-0.8, -10),
          action: () async {
            await game.router.pushAndWait(RateRoute());
          }),
      RoundedButton(
          text: numListShuffle.toString(),
          color: const Color(0xffadde6c),
          borderColor: const Color(0xffedffab),
          anchor: const Anchor(-0.8, -11),
          action: () async {
            await game.router.pushAndWait(RateRoute());
          }),
      BackButton(),
    ]);
  }
}

int boy1Score = 0;

class RateRoute extends ValueRoute<int> with HasGameReference {
  RateRoute() : super(value: 0, transparent: true);
  @override
  Future<void> onLoad() async {
    boy1Score++;
    add(MyTextBox(numListShuffle.toString()));
  }
}

class Questions extends Component {
  List _items = [];
//  developer.log('log me');

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/sample.json');
    final data = await json.decode(response);
    _items = data["questions"];
    add(MyTextBox(_items[0]));
  }
}

class Planet extends PositionComponent {
  Planet({
    required this.radius,
    required this.color,
    super.position,
    super.children,
  }) : _paint = Paint()..color = color;

  final double radius;
  final Color color;
  final Paint _paint;

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(Offset.zero, radius, _paint);
  }
}

class Orbit extends PositionComponent {
  Orbit({
    required this.radius,
    required this.planet,
    required this.revolutionPeriod,
    double initialAngle = 0,
  })  : _paint = Paint()
          ..style = PaintingStyle.stroke
          ..color = const Color(0x888888aa),
        _angle = initialAngle {
    add(planet);
  }

  final double radius;
  final double revolutionPeriod;
  final Planet planet;
  final Paint _paint;
  double _angle;

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(Offset.zero, radius, _paint);
  }

  @override
  void update(double dt) {
    _angle += dt / revolutionPeriod * Transform2D.tau;
    planet.position = Vector2(radius, 0)..rotate(_angle);
  }
}

class PauseRoute extends Route {
  PauseRoute() : super(PausePage.new, transparent: true);

  @override
  void onPush(Route? previousRoute) {
    previousRoute!
      ..stopTime()
      ..addRenderEffect(
        PaintDecorator.grayscale(opacity: 0.5)..addBlur(3.0),
      );
  }
}

class PausePage extends Component with TapCallbacks, HasGameRef<FullGame> {
  @override
  Future<void> onLoad() async {
    final game = findGame()!;
    addAll([
      TextComponent(
        text: 'PAUSED',
        position: game.canvasSize / 2,
        anchor: Anchor.center,
        children: [
          ScaleEffect.to(
            Vector2.all(1.1),
            EffectController(
              duration: 0.3,
              alternate: true,
              infinite: true,
            ),
          )
        ],
      ),
    ]);
  }

  @override
  bool containsLocalPoint(Vector2 point) => true;

  @override
  void onTapUp(TapUpEvent event) => gameRef.router.pop();
}
