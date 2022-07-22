import 'package:get/get.dart';
import 'package:music_player/data/repository/repository.dart';

abstract class BaseController extends GetxController {
  final repository = Get.find<Repository>();
}