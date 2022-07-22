import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:music_player/data/model/search_music_model.dart';
import 'package:music_player/data/network.dart';
import 'package:music_player/data/repository/repository.dart';
import 'package:music_player/data/repository/repository_impl.dart';

class RepositoryTestMock extends Repository with Mock implements RepositoryImpl {}

@GenerateMocks([RepositoryTestMock])
void main() {
  late RepositoryImpl repository;

  setUp(() async {
    WidgetsFlutterBinding.ensureInitialized();
    Get.put(Network());
    repository = RepositoryTestMock();
  });

  test("repository search music test", () async {
    when(repository.searchMusic("post+malone", "song")).thenAnswer((realInvocation) => SearchMusicModel(resultCount: 50));
    expect(await repository.searchMusic("post+malone", "song"), isA<SearchMusicModel>());
  });
}