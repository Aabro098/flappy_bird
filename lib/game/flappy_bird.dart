import 'dart:async';
import 'package:flappy_bird/components/ground.dart';
import 'package:flappy_bird/components/pipe_group.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../components/background.dart';
import '../components/bird.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection  {
  late Bird bird;
  late Timer interval;
  late Timer initialDisplayTimer;
  int score = 0;
  bool isHit = false;
  List<PipeGroup> pipes = [];

  @override
  Future<void> onLoad() async {
    addAll([
      Background(),
      Ground(),
      bird = Bird(),
    ]);

    initialDisplayTimer = Timer(const Duration(seconds: 1), () {
      interval = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
        if (!paused) {
          add(PipeGroup());
        }
      });
    });
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!paused) {
        score++;
      }
    });
  }

  @override
  void onTap() {
    super.onTap();
    bird.fly();
  }

  void resetPipes() {
    for (var pipeGroup in pipes) {
      pipeGroup.removeFromParent();
    }
    pipes.clear();
    score = 0;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    const textStyle = TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontFamily: 'Game'
    );
    final textSpan = TextSpan(
      text: 'Score: $score',
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: canvasSize.x);
    textPainter.paint(canvas, const Offset(10, 35)); 
  }
}
