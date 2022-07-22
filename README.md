# Flutter Music Player
A music player Flutter project.

### Overview
Music Player application based on flutter, all music data getted from  [iTunes Affilate API](https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/iTuneSearchAPI/index.html#//apple_ref/doc/uid/TP40017632-CH3-SW1)

<img src="https://github.com/kemalmaulana/music_player_flutter/blob/master/git_assets/Screenshot%202022-07-23%20at%2000.09.34.png?raw=true" alt="drawing" width="250"/>

### Supported device
- Minimal Android API level 21 (Android 5.0) higher 

### Tested on device
- Google Pixel 3 API Level 31/32 (Android 12)

### Supported Feature
- Material Design 3
- Search Music from Toolbar
- List Music
- Play, Stop, Pause, Seek, Next & Prev Song

![play_demo](https://github.com/kemalmaulana/music_player_flutter/blob/master/git_assets/flutter_music_player_demo_play.gif?raw=true)
![search_demo](https://github.com/kemalmaulana/music_player_flutter/blob/master/git_assets/flutter_music_player_search.gif?raw=true)

### Requirements
- Android Studio
- Gradle 7.1.2
- Kotlin 1.6.10
- Dart 2.17.6
- Flutter 3.0.5

### Used Library

  - Mockito 5.2.0
  - Dio 4.0.6
  - Get 4.6.5
  - Google Fonts 3.0.1
  - Lottie Animation 1.3.0
  - AudioPlayers 1.0.1

### Build & Run
To build the app, follow these steps :
1. Type "flutter pub get" to get the library that we've been added to ```pubspec.yaml```
2. Create SKSL to Reduce shader compilation jank on mobile
```
flutter run --profile --cache-sksl --purge-persistent-cache
```
then Press M, it will create ```flutter_01.sksl.json```
3. Run this command to build APK
```
flutter build apk -v --obfuscate --split-debug-info=/Users/username/AndroidStudioProjects/music_player/deobfuscate --target-platform android-arm,android-arm64 --bundle-sksl-path flutter_01.sksl.json --split-per-abi
```
This command will generate .apk files with config:
- Obfuscated: Obfuscate code and leaving the symbol to read obfuscated stacktrace, for more info about obfuscating the code, head to [Obfuscating Dart code](https://docs.flutter.dev/deployment/obfuscate).
- Target platform: Support only for Android with ARMv7 & ARMv8 processors, for x86 (commonly used for emulator) remove this command flag to include support for all processors.
- Bundle SKSL: Include cache to make app smoother with flutter_01.sksl.json that we've been created in the first step before.
4. The final results should be like this ![list-of-apk-files](https://github.com/kemalmaulana/music_player_flutter/blob/master/git_assets/Screenshot%202022-07-22%20at%2023.18.59.png?raw=true)

*Note : Replace Username with your own username

To Run the app, there are two way to start the app :
1. On the toolbar of Android Studio, you can select the target device and then click on "Play Button" to run.
![deploy-run-app](https://github.com/kemalmaulana/music_player_flutter/blob/master/git_assets/Screenshot%202022-07-23%20at%2000.01.12.png?raw=true)
2. Installing .apk files that we've been created before, directly to the phone or emulator by running command ```adb install <path_to_apk_file>.apk```



