import 'dart:async';

import 'package:music_player/data/model/search_music_model.dart';

abstract class Repository {
  FutureOr<SearchMusicModel?> searchMusic(String term, String entity);
}