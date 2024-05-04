
import 'package:flappy_bird/screens/game_over_screen.dart';
import 'package:flappy_bird/screens/main_menu_screen.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'game/flappy_bird.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove();
  final game = FlappyBirdGame();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(GameWidget(
    game : game,
    initialActiveOverlays: const [MainMenuScreen.id],
    overlayBuilderMap: {
      'mainMenu':(context, _)=>MainMenuScreen(game: game),
      'gameOver':(context, _)=>GameOverScreen(game: game),
    },
    )
  );
}

