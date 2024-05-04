import 'package:flappy_bird/game/assets.dart';
import 'package:flappy_bird/game/flappy_bird.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MainMenuScreen extends StatelessWidget {
  final FlappyBirdGame game;
  static const String id = 'mainMenu';
  final storage = const FlutterSecureStorage();

  const MainMenuScreen({super.key, required this.game});
  @override
  Widget build(BuildContext context) {
    game.pauseEngine();

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          game.overlays.remove('mainMenu');
          game.resumeEngine();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetsImages.backgroundUsed),
              fit: BoxFit.cover,
            ),
          ),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(image: AssetImage(AssetsImages.message)),
                  const SizedBox(
                    height: 40,
                  ),
                  FutureBuilder<String>(
                    future: _getHighScore(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Text(
                          'High Score: ${snapshot.data}',
                          style: TextStyle(
                            fontSize: 30 , 
                            color : Colors.lightGreen.shade700 , 
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Game'
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<String> _getHighScore() async {
    String? storedScore = await storage.read(key: 'highest_score');
    int highestScore = storedScore != null ? int.parse(storedScore) : 0;
    return highestScore.toString();
  }
}
