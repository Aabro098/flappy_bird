

import 'package:flappy_bird/game/assets.dart';
import 'package:flappy_bird/game/flappy_bird.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class GameOverScreen extends StatefulWidget {
  static const String id ='gameOver';
  final FlappyBirdGame game;
  
  const GameOverScreen({super.key, required this.game});

  @override
  State<GameOverScreen> createState() => _GameOverScreenState();
}

class _GameOverScreenState extends State<GameOverScreen> {
  final storage = const FlutterSecureStorage();

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
            const SizedBox(height: 20),
            FutureBuilder<bool>(
              future: isNewHighScore(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!) {
                  return const Text(
                    ' New High Score ! ',
                    style: TextStyle(
                      fontSize: 24,
                      color :  Color.fromARGB(255, 163, 253, 83) , 
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Game'
                    ),
                  );
                }
                return const SizedBox(); 
              },
            ),
            const SizedBox(height: 10,),
            Image.asset(AssetsImages.gameOver),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              onPressed: onRestart,
              child: const Text(
                'Restart',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future<bool> isNewHighScore() async {
    final currentScore = widget.game.score;
    final highScore = await _getHighScore();
    final parsedHighScore = highScore != null ? int.parse(highScore) : 0;
    return currentScore > parsedHighScore;
  }

  void onRestart() {
    widget.game.bird.reset();
    widget.game.resetPipes();
    widget.game.overlays.remove('gameOver');
    widget.game.resumeEngine();
  }

  Future<String?> _getHighScore() async {
    return await storage.read(key: 'highest_score');
  }
}
