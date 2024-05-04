import 'package:flappy_bird/game/flappy_bird.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import '../game/assets.dart';

class Background extends SpriteComponent with HasGameRef<FlappyBirdGame>{
  Background();

  @override
  Future<void> onLoad() async {
    final background = await Flame.images.load(AssetsImages.background);
    size = gameRef.size;
    sprite = Sprite(background);
  }
}