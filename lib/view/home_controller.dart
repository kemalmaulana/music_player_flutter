import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/data/base/base_controller.dart';
import 'package:music_player/data/model/search_music_model.dart';

class HomeController extends BaseController {
  final audioPlayer = AudioPlayer(
      playerId: "music_player_fita"
  );
  final searchController = TextEditingController();
  final isLoading = false.obs;
  final errorMessage = "".obs;
  final searchTerm = "a".obs;
  Results? currentlyPlayingMusic;
  final currentlyPlayingState = false.obs;
  final currentPlayingDuration = 0.obs;
  final maxDuration = 0.obs;
  final currentSeekbar = 0.obs;
  int? currentlyPlayingIndex;


  Widget appBarTitle = const Text("Music Player");
  Icon actionIcon = const Icon(Icons.search, color: Colors.white);
  List<Results>? musicList;

  @override
  onInit() {
    super.onInit();
    fetchMusic("a");
  }

  /// Play Audio from URL with given [url]
  /// releasing any current playing music and assigning to new [url]
  /// notifying current position of duration and max duration of streamed music
  /// in milliseconds
  void playAudioFromUrl(String? url) async {
    if(url != null) {
      await audioPlayer.release();
      await audioPlayer.setSourceUrl(url);
    }
    await audioPlayer.resume();
    currentlyPlayingState.value = true;
    audioPlayer.onDurationChanged.listen((event) {
      maxDuration.value = event.inMilliseconds;
      update();
    });
    audioPlayer.onPositionChanged.listen((event) {
      currentPlayingDuration.value = event.inMilliseconds;
      update();
    });
  }

  /// pause the music if the play/pause button pressed
  void pauseMusic() async {
    await audioPlayer.pause();
    currentlyPlayingState.value = false;
    update();
  }

  /// Stop the music before dispose
  void stopMusic() async {
    await audioPlayer.stop();
    currentlyPlayingState.value = false;
    update();
  }

  /// resume the music if the play/pause button pressed
  /// with last duration
  void resumeMusic() async {
    await audioPlayer.resume();
    currentlyPlayingState.value = true;
    update();
  }

  /// Play next music from the list with given variable [currentlyPlayingIndex]
  /// increasing index by 1 to play next track
  void nextMusic() async {
    if(currentlyPlayingIndex != null && currentlyPlayingIndex! < musicList!.length-1) {
      currentlyPlayingIndex = (currentlyPlayingIndex!+1);
      currentlyPlayingMusic = musicList?[currentlyPlayingIndex!];
      update();
    }
    debugPrint("Current Index Playing : $currentlyPlayingIndex");
    playAudioFromUrl(musicList?[currentlyPlayingIndex!].previewUrl);
  }

  /// Play previous music from the list with given variable [currentlyPlayingIndex]
  /// decreasing index by 1 to play previous track
  void previousMusic() async {
    if(currentlyPlayingIndex != null && currentlyPlayingIndex! > 0) {
      currentlyPlayingIndex = (currentlyPlayingIndex!-1);
      currentlyPlayingMusic = musicList?[currentlyPlayingIndex!];
      update();
    }
    playAudioFromUrl(musicList?[currentlyPlayingIndex!].previewUrl);
  }

  /// Update seekbar timer with given variable [newValue] from seekbar widget
  /// setting in with [audioPlayer] with Duration in milliseconds
  void setSeekbar(int newValue) {
    audioPlayer.seek(Duration(milliseconds: newValue));
  }

  /// Resetting all value to null in [currentlyPlayingMusic], [currentlyPlayingState], and [currentlyPlayingIndex]
  /// Fetch music list from [repository] with given variable [term]
  /// setting up entity to song because we don't want to search anything else except songs
  /// handle no internet access with exception [IOException].
  dynamic fetchMusic(String term) async {
    Get.focusScope?.unfocus();
    currentlyPlayingMusic = null;
    currentlyPlayingState.value = false;
    currentlyPlayingIndex = null;
    stopMusic();
    isLoading.value = true;
    try {
      var response = await repository.searchMusic(term, "song");
      if (response?.resultCount != null || response?.resultCount != 0) {
        musicList = response?.results;
      } else {
        musicList = [];
        errorMessage.value = "Something went wrong";
      }
      isLoading.value = false;

    } on IOException catch(e) {
      debugPrint(e.toString());
      errorMessage.value = e.toString();
    }
    update();
  }

  @override
  void onClose() {
    stopMusic();
    super.onClose();
  }

  @override
  void dispose() {
    stopMusic();
    audioPlayer.dispose();
    super.dispose();
  }
}