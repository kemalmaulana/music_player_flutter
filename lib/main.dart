import 'package:flutter/material.dart';
import 'package:music_player/bindings/global_bindings.dart';
import 'package:music_player/music_player_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GlobalBindings().dependencies();
  runApp(const MusicPlayerApp());
}