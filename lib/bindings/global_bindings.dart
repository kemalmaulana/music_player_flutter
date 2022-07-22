import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:music_player/data/network.dart';
import 'package:music_player/data/repository/repository.dart';
import 'package:music_player/data/repository/repository_impl.dart';

class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<Dio>(Dio(), permanent: true);
    Get.put<Network>(Network(), permanent: true);
    Get.put<Repository>(RepositoryImpl(network: Get.find<Network>()),
        permanent: true);
  }
}
