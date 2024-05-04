

import 'package:flappy_bird/game/assets.dart';
import 'package:flappy_bird/game/flappy_bird.dart';
import 'package:flutter/material.dart';


class GameOverScreen extends StatefulWidget {
  static const String id ='gameOver';
  final FlappyBirdGame game;

  const GameOverScreen({super.key, required this.game});

  @override
  State<GameOverScreen> createState() => _GameOverScreenState();
}

class _GameOverScreenState extends State<GameOverScreen> {
 
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black38,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Score: ${widget.game.score}',
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontFamily: 'Game',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset(AssetsImages.gameOver),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              onPressed: onRestart,
              child: const Text(
                'Restart',
                style: TextStyle(fontSize: 26, color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  void onRestart() {
    widget.game.bird.reset();
    widget.game.resetPipes();
    widget.game.overlays.remove('gameOver');
    widget.game.resumeEngine();
  }
}
