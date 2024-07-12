Flappy Bird Game (Flutter & Flame Engine)
This Flappy Bird game, created using Flutter and the Flame engine, delivers an engaging and nostalgic gaming experience. Players navigate a bird through a series of obstacles by tapping the screen to keep it flying. The game features smooth animations, responsive controls, and an increasing difficulty level that challenges players as they progress. The use of the Flame engine ensures efficient performance and a seamless gameplay experience on various devices.

Enter 'flutter pub get' in the project directory.

To create flutter native splash screen 'dart run flutter_native_splash:create'

flutter_icons:
  android: true
  ios: true
  color: "#42a5f5"
  image_path : "assets/images/bird_midflap.png"

flutter:
  uses-material-design: true

  assets:
    - assets/images/
  
  fonts:
    - family: Game
      fonts:
        - asset: assets/fonts/Game.ttf

make this changes in your pubspec.yaml file
