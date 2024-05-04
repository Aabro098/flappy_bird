import 'dart:math';

import 'package:flappy_bird/components/pipe.dart';
import 'package:flappy_bird/game/flappy_bird.dart';
import 'package:flame/components.dart';

import '../game/configuration.dart';
import '../game/pipe_position.dart';

class PipeGroup extends PositionComponent with HasGameRef<FlappyBirdGame>{
  PipeGroup();
  final _random = Random();

  @override
  Future<void> onLoad() async {
    gameRef.pipes.add(this);
    int spacing = 140;
    position.x =gameRef.size.x;
    final heightMinusGround = gameRef.size.y - Config.groundHeight;
    double minHeight = 50+Config.groundHeight;
    double maxHeight = gameRef.size.y/1.5 + 30;
    final centerY = minHeight + _random.nextDouble()*(maxHeight - minHeight);

    addAll([
      Pipe(height: centerY - spacing/2, pipePosition: PipePosition.top),
      Pipe(height: heightMinusGround - (centerY+spacing/2), 
        pipePosition: PipePosition.bottom),
    ]);
  }  
  @override
  void update(double dt){
    super.update(dt);
    position.x -= Config.gameSpeed*dt ;
    if (position.x < -10 ){
      removeFromParent();
    }
    if (gameRef.isHit){
      removeFromParent();
      gameRef.isHit = false;
    }
  }
}