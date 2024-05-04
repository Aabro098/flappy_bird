import 'package:flappy_bird/game/flappy_bird.dart';
import 'package:flappy_bird/game/pipe_position.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';

import '../game/assets.dart';
import '../game/configuration.dart';

class Pipe extends SpriteComponent with HasGameRef<FlappyBirdGame>{
 Pipe({
  required this.height,
  required this.pipePosition
 });

  @override
  final double height;
  final PipePosition pipePosition;

  @override
  Future<void> onLoad() async {
    final pipe = await Flame.images.load(AssetsImages.pipe);
    final pipeRotated = await Flame.images.load(AssetsImages.pipeRotated);

    size = Vector2(50, height);

    switch(pipePosition){
      case PipePosition.top:
        position.y = 0;
        sprite = Sprite(pipeRotated);
        break;
      case PipePosition.bottom:
        position.y = gameRef.size.y - size.y - Config.groundHeight;
        sprite = Sprite(pipe);
        break;
    } 
    add(RectangleHitbox());
  }
}