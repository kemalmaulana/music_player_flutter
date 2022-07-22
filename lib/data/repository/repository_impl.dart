
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:music_player/data/model/search_music_model.dart';
import 'package:music_player/data/network.dart';
import 'package:music_player/data/repository/repository.dart';

class RepositoryImpl implements Repository {

  RepositoryImpl({required this.network});
  Network network;

  @override
  FutureOr<SearchMusicModel?> searchMusic(String term, String entity) async {
    late Response? response;
    try {
      response = await network.get("/search", queryParameters: {
        "term": term,
        "entity": entity
      });
      return searchMusicModelFromJson(response?.data);
    } on DioError catch (e) {
      debugPrint(e.message);
      return Future.error(e);
    }
  }

}