import 'package:flappy_bird/game/configuration.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../game/assets.dart';
import '../game/bird_movement.dart';
import '../game/flappy_bird.dart';

class Bird extends SpriteGroupComponent<BirdMovement> 
  with HasGameRef<FlappyBirdGame> , CollisionCallbacks{

    Bird();

    @override
    Future<void> onLoad() async {
      final birdMidFlap = await gameRef.loadSprite(AssetsImages.birdMidFlap);
      final birdUpFlap = await gameRef.loadSprite(AssetsImages.birdUpFlap);
      final birdDownFlap = await gameRef.loadSprite(AssetsImages.birdDownFlap);

      size = Vector2(50, 40);
      position = Vector2(50 , gameRef.size.y/2 - size.y/2);
      current = BirdMovement.middle;
      sprites = {
        BirdMovement.middle: birdMidFlap,
        BirdMovement.up: birdUpFlap,
        BirdMovement.down: birdDownFlap,
      };
      add(CircleHitbox());
    }

    void fly(){
      add(
        MoveByEffect(
          Vector2(0, Config.gravity),
          EffectController(duration: 0.2 , curve: Curves.decelerate),
          onComplete: ()=>
          current = BirdMovement.down
        ),
      );
      current = BirdMovement.up;
    }

    @override
    void onCollisionStart(
      Set<Vector2> intersectionPoints,
      PositionComponent other,
    ){
      super.onCollisionStart(intersectionPoints, other);
      gameOver();
    }

    void gameOver(){
      gameRef.overlays.add('gameOver');
      gameRef.pauseEngine();
      game.isHit = true ;
      updateHighScore(game.score);
    }

    void updateHighScore(int currentScore) async {
      const storage = FlutterSecureStorage();
      String? storedScore = await storage.read(key: 'highest_score');
      int highestScore = storedScore != null ? int.parse(storedScore) : 0;

      if (currentScore > highestScore) {
        await storage.write(key: 'highest_score', value: currentScore.toString());
      }
    }
    
    void reset(){
      position = Vector2(50 , gameRef.size.y/2 - size.y/2);
    }

    @override
    void update(double dt){
      super.update(dt);
      if (position.y < 0) {
        position.y = 0;
      }
      position.y += Config.birdGravity * dt;
    } 
}
